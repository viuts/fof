package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"

	firebase "firebase.google.com/go/v4"
	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"google.golang.org/api/option"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/encoding/protojson"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"

	"github.com/joho/godotenv"
	"github.com/viuts/fof/apps/backend/internal/handler"
	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/repository"
	"github.com/viuts/fof/apps/backend/internal/seeds"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"github.com/viuts/fof/apps/backend/pkg/database"
)

func main() {
	// Load .env file
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found, relying on environment variables")
	}

	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		dsn = "postgres://postgres:postgres@localhost:5432/fof?sslmode=disable"
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("failed to connect database: %v", err)
	}

	// Auto Migration
	err = database.AutoMigrate(db)
	if err != nil {
		log.Fatalf("failed to auto migrate: %v", err)
	}

	// Seed Achievements
	seeds.SeedAchievements(db)

	// Wiring
	userRepo := repository.NewUserRepository(db)
	shopRepo := repository.NewShopRepository(db)
	locationRepo := repository.NewLocationRepository(db)
	visitRepo := repository.NewVisitRepository(db)
	achievementRepo := repository.NewAchievementRepository(db)

	achievementUC := usecase.NewAchievementUseCase(achievementRepo)
	shopUC := usecase.NewShopUsecase(shopRepo)
	locationUC := usecase.NewLocationUsecase(locationRepo)
	visitUC := usecase.NewVisitUsecase(visitRepo, shopRepo, userRepo, locationRepo, achievementUC)

	shopHandler := handler.NewShopHandler(shopUC, visitUC)
	locationHandler := handler.NewLocationHandler(locationUC)
	visitHandler := handler.NewVisitHandler(visitUC)
	achievementHandler := handler.NewAchievementHandler(achievementUC)
	userHandler := handler.NewUserHandler(userRepo)

	// Unified Server setup
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	grpcServer := grpc.NewServer()
	fofv1.RegisterShopServiceServer(grpcServer, shopHandler)
	fofv1.RegisterLocationServiceServer(grpcServer, locationHandler)
	fofv1.RegisterVisitServiceServer(grpcServer, visitHandler)
	fofv1.RegisterAchievementServiceServer(grpcServer, achievementHandler)
	fofv1.RegisterUserServiceServer(grpcServer, userHandler)

	mux := runtime.NewServeMux(
		runtime.WithMarshalerOption(runtime.MIMEWildcard, &runtime.JSONPb{
			MarshalOptions: protojson.MarshalOptions{
				UseProtoNames:   false,
				EmitUnpopulated: true,
			},
			UnmarshalOptions: protojson.UnmarshalOptions{
				DiscardUnknown: true,
			},
		}),
	)
	if err := fofv1.RegisterShopServiceHandlerServer(ctx, mux, shopHandler); err != nil {
		log.Fatalf("failed to register shop gateway: %v", err)
	}
	if err := fofv1.RegisterLocationServiceHandlerServer(ctx, mux, locationHandler); err != nil {
		log.Fatalf("failed to register location gateway: %v", err)
	}
	if err := fofv1.RegisterVisitServiceHandlerServer(ctx, mux, visitHandler); err != nil {
		log.Fatalf("failed to register visit gateway: %v", err)
	}
	if err := fofv1.RegisterAchievementServiceHandlerServer(ctx, mux, achievementHandler); err != nil {
		log.Fatalf("failed to register achievement gateway: %v", err)
	}
	if err := fofv1.RegisterUserServiceHandlerServer(ctx, mux, userHandler); err != nil {
		log.Fatalf("failed to register user gateway: %v", err)
	}

	mixedHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.ProtoMajor == 2 && strings.HasPrefix(r.Header.Get("Content-Type"), "application/grpc") {
			grpcServer.ServeHTTP(w, r)
			return
		}
		mux.ServeHTTP(w, r)
	})

	// Firebase Init
	var opts []option.ClientOption
	creds := os.Getenv("GOOGLE_APPLICATION_CREDENTIALS")
	if strings.HasPrefix(strings.TrimSpace(creds), "{") {
		opts = append(opts, option.WithCredentialsJSON([]byte(creds)))
	}

	firebaseApp, err := firebase.NewApp(context.Background(), nil, opts...)
	if err != nil {
		log.Fatalf("error initializing firebase app: %v", err)
	}
	log.Println("Firebase app initialized")
	authMiddleware := middleware.NewAuthMiddleware(firebaseApp, userRepo)
	authenticatedHandler := authMiddleware.Handle(mixedHandler)

	// Add CORS middleware
	withCORS := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, PATCH, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}
		authenticatedHandler.ServeHTTP(w, r)
	})

	server := &http.Server{
		Addr:    ":" + port,
		Handler: h2c.NewHandler(withCORS, &http2.Server{}),
	}

	log.Printf("server listening at %v", port)
	go func() {
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("failed to serve: %v", err)
		}
	}()

	<-ctx.Done()

	log.Println("shutting down server...")
	grpcServer.GracefulStop()
	if err := server.Shutdown(context.Background()); err != nil {
		log.Fatalf("server shutdown failed: %v", err)
	}
	log.Println("server exited")
}

func ptr(s string) *string {
	return &s
}

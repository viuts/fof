package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"

	"github.com/google/uuid"
	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"google.golang.org/grpc"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"

	"github.com/joho/godotenv"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/handler"
	"github.com/viuts/fof/apps/backend/internal/repository"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
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
	err = db.AutoMigrate(&domain.User{}, &domain.Shop{}, &domain.Visit{}, &domain.UserFog{})

	// Seed some sample data if no shops exist
	var count int64
	db.Model(&domain.Shop{}).Count(&count)
	if count == 0 {
		shops := []domain.Shop{
			{
				Name:    "Independent Cafe",
				IsChain: false,
				Geom:    ptr("SRID=4326;POINT(139.7671 35.6812)"), // Tokyo Station
			},
			{
				Name:    "Chain Burger",
				IsChain: true,
				Geom:    ptr("SRID=4326;POINT(139.7690 35.6820)"),
			},
		}
		for _, s := range shops {
			db.Create(&s)
		}
		log.Println("Seeded sample shops")
	}

	// Seed MVP User
	userID := "24e7e8ae-c205-4dba-b42d-f6294db20e9e"
	userUUID, _ := uuid.Parse(userID)
	var userCount int64
	db.Model(&domain.User{}).Where("id = ?", userUUID).Count(&userCount)
	if userCount == 0 {
		user := domain.User{
			ID:       userUUID,
			Username: "mvp_user",
			Email:    "mvp@example.com",
		}
		if err := db.Create(&user).Error; err != nil {
			log.Printf("failed to seed user: %v", err)
		} else {
			log.Println("Seeded MVP user")
		}
	}
	if err != nil {
		log.Fatalf("failed to migrate database: %v", err)
	}

	// Initialize PostGIS extension if not exists
	db.Exec("CREATE EXTENSION IF NOT EXISTS postgis;")

	// Wiring
	flavorRepo := repository.NewFlavorRepository(db)
	flavorUC := usecase.NewFlavorUsecase(flavorRepo)
	flavorHandler := handler.NewFlavorHandler(flavorUC)

	// Unified Server setup
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	grpcServer := grpc.NewServer()
	fofv1.RegisterFlavorServiceServer(grpcServer, flavorHandler)

	mux := runtime.NewServeMux()
	if err := fofv1.RegisterFlavorServiceHandlerServer(ctx, mux, flavorHandler); err != nil {
		log.Fatalf("failed to register gateway: %v", err)
	}

	mixedHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.ProtoMajor == 2 && strings.HasPrefix(r.Header.Get("Content-Type"), "application/grpc") {
			grpcServer.ServeHTTP(w, r)
			return
		}
		mux.ServeHTTP(w, r)
	})

	// Add CORS middleware
	withCORS := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}
		mixedHandler.ServeHTTP(w, r)
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

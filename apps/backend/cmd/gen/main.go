package main

import (
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/driver/postgres"
	"gorm.io/gen"
	"gorm.io/gorm"
)

// Generate GORM Gen code
func main() {
	// Load environment variables
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found, using environment variables")
	}

	// Initialize GORM
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		dsn = "postgres://postgres:postgres@localhost:5432/fof?sslmode=disable"
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	// Initialize generator
	g := gen.NewGenerator(gen.Config{
		OutPath:       "./pkg/database/query",
		Mode:          gen.WithoutContext | gen.WithDefaultQuery | gen.WithQueryInterface,
		FieldNullable: true,
	})

	g.UseDB(db)

	// Generate code for models
	g.ApplyBasic(
		domain.Shop{},
		domain.Visit{},
		domain.UserFog{},
		domain.User{},
	)

	// Execute generation
	g.Execute()

	log.Println("GORM Gen code generation completed successfully")
}

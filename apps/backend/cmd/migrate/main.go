package main

import (
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/viuts/fof/apps/backend/pkg/database"
)

func main() {
	// Load environment variables
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found, using environment variables")
	}

	// Env is DATABASE_URL
	// Format: postgres://user:password@host:port/dbname?sslmode=disable

	dbUrl := os.Getenv("DATABASE_URL")
	if dbUrl == "" {
		log.Fatal("DATABASE_URL is not set")
	}

	dbConfig, err := database.ParseDatabaseURL(dbUrl)
	if err != nil {
		log.Fatalf("Failed to parse DATABASE_URL: %v", err)
	}

	// Connect to database
	dbClient, err := database.NewClient(dbConfig)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer dbClient.Close()

	// Get command
	if len(os.Args) < 2 {
		printUsage()
		os.Exit(1)
	}

	command := os.Args[1]

	switch command {
	case "up":
		log.Println("Running migrations...")
		if err := database.AutoMigrate(dbClient.DB); err != nil {
			log.Fatalf("Migration failed: %v", err)
		}
		log.Println("Migrations completed successfully")

	case "drop":
		log.Println("⚠️  WARNING: This will drop all tables!")
		fmt.Print("Are you sure? (yes/no): ")
		var confirm string
		fmt.Scanln(&confirm)
		if confirm != "yes" {
			log.Println("Aborted")
			return
		}

		if err := database.DropTables(dbClient.DB); err != nil {
			log.Fatalf("Drop failed: %v", err)
		}
		log.Println("Tables dropped successfully")

	default:
		fmt.Printf("Unknown command: %s\n", command)
		printUsage()
		os.Exit(1)
	}
}

func printUsage() {
	fmt.Println("Usage: go run cmd/migrate/main.go [command]")
	fmt.Println("\nCommands:")
	fmt.Println("  up   - Run auto migrations (create/update tables)")
	fmt.Println("  drop - Drop all tables (requires confirmation)")
}

func getEnv(key, defaultValue string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return defaultValue
}

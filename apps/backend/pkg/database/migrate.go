package database

import (
	"fmt"
	"log"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

// AutoMigrate runs automatic migrations for all models
func AutoMigrate(db *gorm.DB) error {
	log.Println("Running auto migrations...")

	if err := db.Exec("CREATE EXTENSION IF NOT EXISTS postgis;").Error; err != nil {
		return fmt.Errorf("failed to create postgis extension %w", err)
	}

	if err := db.AutoMigrate(
		&domain.User{},
		&domain.Shop{},
		&domain.Visit{},
		&domain.UserFog{},
		&domain.Achievement{},
		&domain.UserAchievement{},
	); err != nil {
		return fmt.Errorf("failed to run auto migrations: %w", err)
	}

	// Ensure opening_hours is jsonb (with cast if needed)
	if err := db.Exec("ALTER TABLE shops ALTER COLUMN opening_hours SET DATA TYPE jsonb USING opening_hours::jsonb").Error; err != nil {
		log.Printf("Warning: failed to convert opening_hours to jsonb via direct cast: %v. Attempting reset.", err)
		// If cast fails (due to existing non-json data), reset to empty jsonb
		if err := db.Exec("ALTER TABLE shops ALTER COLUMN opening_hours SET DATA TYPE jsonb USING '{}'::jsonb").Error; err != nil {
			log.Printf("Error: failed to force opening_hours to jsonb: %v", err)
		}
	}

	// Ensure unique constraint on source_url for upserts
	db.Exec("ALTER TABLE shops DROP CONSTRAINT IF EXISTS uni_shops_source_url")
	if err := db.Exec("ALTER TABLE shops ADD CONSTRAINT uni_shops_source_url UNIQUE (source_url)").Error; err != nil {
		log.Printf("Warning: failed to add unique constraint on source_url: %v", err)
	}

	// Migrate ClearanceRadius to Computed Column
	// 1. Drop existing column (if exists and is not generated, or just recreate)
	if err := db.Exec("ALTER TABLE shops DROP COLUMN IF EXISTS clearance_radius").Error; err != nil {
		log.Printf("Warning: failed to drop clearance_radius: %v", err)
	}
	// 2. Add as generated column
	// Priority: >3.5 or <2.5 -> 500m
	//           Independent -> 250m
	//           Default -> 100m
	query := `
		ALTER TABLE shops ADD COLUMN clearance_radius double precision GENERATED ALWAYS AS (
			CASE
				WHEN rating > 3.5 OR rating < 2.5 THEN 500
				WHEN is_chain = false THEN 250
				ELSE 100
			END
		) STORED
	`
	if err := db.Exec(query).Error; err != nil {
		log.Printf("Warning: failed to add generated clearance_radius: %v", err)
	}

	log.Println("Auto migrations completed successfully")
	return nil
}

// DropTables drops all tables (use with caution!)
func DropTables(db *gorm.DB) error {
	log.Println("Dropping all tables...")

	if err := db.Migrator().DropTable(
		&domain.User{},
		&domain.Shop{},
		&domain.Visit{},
		&domain.UserFog{},
		&domain.Achievement{},
		&domain.UserAchievement{},
	); err != nil {
		return fmt.Errorf("failed to drop tables: %w", err)
	}

	log.Println("Tables dropped successfully")
	return nil
}

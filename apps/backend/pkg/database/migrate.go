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

	if err := db.AutoMigrate(
		&domain.User{},
		&domain.Shop{},
		&domain.Visit{},
		&domain.UserFog{},
	); err != nil {
		return fmt.Errorf("failed to run auto migrations: %w", err)
	}

	// Ensure unique constraint on source_url for upserts
	db.Exec("ALTER TABLE shops DROP CONSTRAINT IF EXISTS uni_shops_source_url")
	if err := db.Exec("ALTER TABLE shops ADD CONSTRAINT uni_shops_source_url UNIQUE (source_url)").Error; err != nil {
		log.Printf("Warning: failed to add unique constraint on source_url: %v", err)
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
	); err != nil {
		return fmt.Errorf("failed to drop tables: %w", err)
	}

	log.Println("Tables dropped successfully")
	return nil
}

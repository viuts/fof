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
		&domain.UserFogTile{},
		&domain.Achievement{},
		&domain.UserAchievement{},
	); err != nil {
		return fmt.Errorf("failed to run auto migrations: %w", err)
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
		&domain.UserFogTile{},
		&domain.Achievement{},
		&domain.UserAchievement{},
	); err != nil {
		return fmt.Errorf("failed to drop tables: %w", err)
	}

	log.Println("Tables dropped successfully")
	return nil
}

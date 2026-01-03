package repository

import (
	"context"
	"os"
	"testing"

	"github.com/google/uuid"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func TestUpdateLocationIntegration(t *testing.T) {
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		t.Skip("Skipping integration test: DATABASE_URL not set")
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		t.Fatalf("Failed to connect to database: %v", err)
	}

	repo := NewFlavorRepository(db)
	userID := uuid.New().String()

	ctx := context.Background()
	path := []*fofv1.LatLng{
		{Lat: 35.6812, Lng: 139.7671},
		{Lat: 35.6813, Lng: 139.7672},
	}

	newlyCleared, geoJSON, err := repo.UpdateLocation(ctx, userID, path)
	if err != nil {
		t.Fatalf("UpdateLocation failed: %v", err)
	}

	if !newlyCleared {
		t.Error("Expected newlyCleared to be true for new user")
	}

	if geoJSON == "" {
		t.Error("Expected geoJSON to be non-empty")
	}
	t.Logf("GeoJSON: %s", geoJSON)
}

func TestGetClearedAreaIntegration(t *testing.T) {
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		t.Skip("Skipping integration test: DATABASE_URL not set")
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		t.Fatalf("Failed to connect to database: %v", err)
	}

	repo := NewFlavorRepository(db)
	userID := uuid.New().String()

	ctx := context.Background()
	
	// Initial state - should return empty multipolygon
	geoJSON, err := repo.GetClearedArea(ctx, userID)
	if err != nil {
		t.Fatalf("GetClearedArea failed: %v", err)
	}
	if geoJSON != `{"type":"MultiPolygon","coordinates":[]}` {
		t.Errorf("Expected empty MultiPolygon, got: %s", geoJSON)
	}

	// Update location
	path := []*fofv1.LatLng{{Lat: 35.6812, Lng: 139.7671}}
	_, _, _ = repo.UpdateLocation(ctx, userID, path)

	// Final state
	geoJSON, err = repo.GetClearedArea(ctx, userID)
	if err != nil {
		t.Fatalf("GetClearedArea failed: %v", err)
	}
	if geoJSON == "" || geoJSON == `{"type":"MultiPolygon","coordinates":[]}` {
		t.Errorf("Expected non-empty GeoJSON, got: %s", geoJSON)
	}
}

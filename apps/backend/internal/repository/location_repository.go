package repository

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/google/uuid"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"gorm.io/gorm"
)

type LocationRepository interface {
	UpdateLocation(ctx context.Context, userID uuid.UUID, path []*fofv1.LatLng) (newlyCleared bool, geoJSON string, err error)
	GetClearedArea(ctx context.Context, userID uuid.UUID) (string, error)
	ClearAreaAroundPoint(ctx context.Context, tx *gorm.DB, userID uuid.UUID, lat, lng, radius float64) (string, error)
}

type locationRepository struct {
	db *gorm.DB
}

func NewLocationRepository(db *gorm.DB) LocationRepository {
	return &locationRepository{db: db}
}

func (r *locationRepository) UpdateLocation(ctx context.Context, userID uuid.UUID, path []*fofv1.LatLng) (bool, string, error) {
	if len(path) == 0 {
		area, _ := r.GetClearedArea(ctx, userID)
		return false, area, nil
	}

	var geomWKT string
	if len(path) == 1 {
		geomWKT = fmt.Sprintf("POINT(%f %f)", path[0].Lng, path[0].Lat)
	} else {
		var points []string
		for _, p := range path {
			points = append(points, fmt.Sprintf("%f %f", p.Lng, p.Lat))
		}
		geomWKT = fmt.Sprintf("LINESTRING(%s)", strings.Join(points, ","))
	}

	query := `
		INSERT INTO user_fogs (user_id, cleared_area, updated_at)
		VALUES (?, ST_Multi(ST_Buffer(ST_GeomFromText(?, 4326)::geography, 100)::geometry), ?)
		ON CONFLICT (user_id) DO UPDATE SET
			cleared_area = ST_Multi(ST_Buffer(
				ST_Union(
					user_fogs.cleared_area::geometry,
					ST_Buffer(ST_GeomFromText(?, 4326)::geography, 100)::geometry
				)::geography,
				0
			)::geometry),
			updated_at = EXCLUDED.updated_at
		RETURNING ST_AsGeoJSON(cleared_area)
	`

	var geoJSON string
	err := r.db.WithContext(ctx).Raw(query, userID, geomWKT, time.Now(), geomWKT).Scan(&geoJSON).Error
	if err != nil {
		return false, "", err
	}

	return true, geoJSON, nil
}

func (r *locationRepository) GetClearedArea(ctx context.Context, userID uuid.UUID) (string, error) {
	var geoJSON string
	err := r.db.WithContext(ctx).Raw("SELECT ST_AsGeoJSON(cleared_area) FROM user_fogs WHERE user_id = ?", userID).Scan(&geoJSON).Error
	if err == gorm.ErrRecordNotFound || geoJSON == "" {
		return `{"type":"MultiPolygon","coordinates":[]}`, nil
	}
	return geoJSON, err
}

func (r *locationRepository) ClearAreaAroundPoint(ctx context.Context, tx *gorm.DB, userID uuid.UUID, lat, lng, radius float64) (string, error) {
	geomWKT := fmt.Sprintf("POINT(%f %f)", lng, lat)
	query := `
		INSERT INTO user_fogs (user_id, cleared_area, updated_at)
		VALUES (?, ST_Multi(ST_Buffer(ST_GeomFromText(?, 4326)::geography, ?)::geometry), ?)
		ON CONFLICT (user_id) DO UPDATE SET
			cleared_area = ST_Multi(ST_Buffer(
				ST_Union(
					user_fogs.cleared_area::geometry,
					ST_Buffer(ST_GeomFromText(?, 4326)::geography, ?)::geometry
				)::geography,
				0
			)::geometry),
			updated_at = EXCLUDED.updated_at
		RETURNING ST_AsGeoJSON(cleared_area)
	`
	var geoJSON string
	err := tx.Raw(query, userID, geomWKT, radius, time.Now(), geomWKT, radius).Scan(&geoJSON).Error
	return geoJSON, err
}

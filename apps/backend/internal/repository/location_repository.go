package repository

import (
	"context"
	"fmt"
	"math"
	"strings"
	"time"

	"github.com/google/uuid"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"gorm.io/gorm"
)

const (
	// Earth radius in meters
	earthRadius = 6371000.0
	// Distance threshold to split paths (meters)
	pathSplitThreshold = 200.0
)

// distance calculates the Haversine distance between two points in meters.
func distance(lat1, lon1, lat2, lon2 float64) float64 {
	dLat := (lat2 - lat1) * math.Pi / 180.0
	dLon := (lon2 - lon1) * math.Pi / 180.0

	a := math.Sin(dLat/2)*math.Sin(dLat/2) +
		math.Cos(lat1*math.Pi/180.0)*math.Cos(lat2*math.Pi/180.0)*
			math.Sin(dLon/2)*math.Sin(dLon/2)
	c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))

	return earthRadius * c
}

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

	var geoms []string

	if len(path) == 1 {
		geoms = append(geoms, fmt.Sprintf("POINT(%f %f)", path[0].Lng, path[0].Lat))
	} else {
		var currentSegment []string
		currentSegment = append(currentSegment, fmt.Sprintf("%f %f", path[0].Lng, path[0].Lat))

		for i := 1; i < len(path); i++ {
			p1 := path[i-1]
			p2 := path[i]

			dist := distance(p1.Lat, p1.Lng, p2.Lat, p2.Lng)

			if dist > pathSplitThreshold {
				// Close current segment as a LineString if it has more than one point, otherwise a Point
				if len(currentSegment) > 1 {
					geoms = append(geoms, fmt.Sprintf("LINESTRING(%s)", strings.Join(currentSegment, ",")))
				} else {
					geoms = append(geoms, fmt.Sprintf("POINT(%s)", currentSegment[0]))
				}
				// Start new segment
				currentSegment = []string{fmt.Sprintf("%f %f", p2.Lng, p2.Lat)}
			} else {
				currentSegment = append(currentSegment, fmt.Sprintf("%f %f", p2.Lng, p2.Lat))
			}
		}

		// Close final segment
		if len(currentSegment) > 1 {
			geoms = append(geoms, fmt.Sprintf("LINESTRING(%s)", strings.Join(currentSegment, ",")))
		} else {
			geoms = append(geoms, fmt.Sprintf("POINT(%s)", currentSegment[0]))
		}
	}

	geomWKT := fmt.Sprintf("GEOMETRYCOLLECTION(%s)", strings.Join(geoms, ","))

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

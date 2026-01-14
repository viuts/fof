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
	// Zoom level for fog tiles
	fogZoom = 15
)

func latLngToTile(lat, lng float64, zoom int) (x, y int) {
	n := math.Exp2(float64(zoom))
	x = int((lng + 180.0) / 360.0 * n)
	latRad := lat * math.Pi / 180.0
	y = int((1.0 - math.Log(math.Tan(latRad)+(1.0/math.Cos(latRad)))/math.Pi) / 2.0 * n)
	return x, y
}

type LocationRepository interface {
	UpdateLocation(ctx context.Context, userID uuid.UUID, path []*fofv1.LatLng) error
	GetClearedArea(ctx context.Context, userID uuid.UUID, minLat, minLng, maxLat, maxLng float64) (string, float64, float64, error)
	ClearAreaAroundPoint(ctx context.Context, tx *gorm.DB, userID uuid.UUID, lat, lng, radius float64) error
}

type locationRepository struct {
	db *gorm.DB
}

func NewLocationRepository(db *gorm.DB) LocationRepository {
	return &locationRepository{db: db}
}

func (r *locationRepository) UpdateLocation(ctx context.Context, userID uuid.UUID, path []*fofv1.LatLng) error {
	if len(path) == 0 {
		return nil
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

	// Calculate tile range
	margin := 0.002 // Approx 200m
	minLat, maxLat := path[0].Lat, path[0].Lat
	minLng, maxLng := path[0].Lng, path[0].Lng
	for _, p := range path {
		if p.Lat < minLat {
			minLat = p.Lat
		}
		if p.Lat > maxLat {
			maxLat = p.Lat
		}
		if p.Lng < minLng {
			minLng = p.Lng
		}
		if p.Lng > maxLng {
			maxLng = p.Lng
		}
	}

	x1, y1 := latLngToTile(minLat-margin, minLng-margin, fogZoom)
	x2, y2 := latLngToTile(maxLat+margin, maxLng+margin, fogZoom)

	minX, maxX := x1, x2
	if x1 > x2 {
		minX, maxX = x2, x1
	}
	minY, maxY := y1, y2
	if y1 > y2 {
		minY, maxY = y2, y1
	}

	query := `
		WITH new_area AS (
			SELECT ST_Multi(ST_Buffer(ST_GeomFromText(?, 4326)::geography, 100)::geometry) as geom
		)
		INSERT INTO user_fog_tiles (user_id, z, x, y, geom, updated_at)
		SELECT 
			?, ?::integer, x, y, 
			ST_Multi(ST_Intersection(ST_Transform(ST_TileEnvelope(?::integer, x::integer, y::integer), 4326), (SELECT geom FROM new_area))), 
			?
		FROM generate_series(?::integer, ?::integer) AS x, generate_series(?::integer, ?::integer) AS y
		WHERE ST_Intersects(ST_Transform(ST_TileEnvelope(?::integer, x::integer, y::integer), 4326), (SELECT geom FROM new_area))
		ON CONFLICT (user_id, z, x, y) DO UPDATE SET
			geom = ST_Multi(ST_Buffer(
				ST_Union(
					user_fog_tiles.geom,
					ST_Intersection(ST_Transform(ST_TileEnvelope(user_fog_tiles.z::integer, user_fog_tiles.x::integer, user_fog_tiles.y::integer), 4326), (SELECT geom FROM new_area))
				)::geography,
				0
			)::geometry),
			updated_at = EXCLUDED.updated_at;
	`

	err := r.db.WithContext(ctx).Exec(query,
		geomWKT,
		userID, fogZoom, fogZoom, time.Now(),
		minX, maxX, minY, maxY,
		fogZoom,
	).Error
	if err != nil {
		return err
	}

	return nil
}

func (r *locationRepository) GetClearedArea(ctx context.Context, userID uuid.UUID, minLat, minLng, maxLat, maxLng float64) (string, float64, float64, error) {
	var result struct {
		GeoJSON string
		Area    float64
	}

	whereClause := "user_id = ?"
	args := []interface{}{userID}

	if minLat != 0 || minLng != 0 || maxLat != 0 || maxLng != 0 {
		whereClause += " AND ST_Intersects(geom, ST_MakeEnvelope(?, ?, ?, ?, 4326))"
		args = append(args, minLng, minLat, maxLng, maxLat)
	}

	query := fmt.Sprintf(`
		SELECT 
			ST_AsGeoJSON(ST_SimplifyPreserveTopology(ST_Multi(ST_Union(geom)), 0.00001)) as geo_json, 
			SUM(ST_Area(geom::geography)) as area 
		FROM user_fog_tiles 
		WHERE %s
	`, whereClause)
	err := r.db.WithContext(ctx).Raw(query, args...).Scan(&result).Error
	if err == gorm.ErrRecordNotFound || result.GeoJSON == "" {
		return `{"type":"MultiPolygon","coordinates":[]}`, 0, 0, nil
	}

	// Earth land area is approx 148,940,000 km^2 = 148,940,000,000,000 m^2
	worldCoverage := (result.Area / 148940000000000.0) * 100

	return result.GeoJSON, result.Area, worldCoverage, err
}

func (r *locationRepository) ClearAreaAroundPoint(ctx context.Context, tx *gorm.DB, userID uuid.UUID, lat, lng, radius float64) error {
	geomWKT := fmt.Sprintf("POINT(%f %f)", lng, lat)

	// Calculate tile range
	marginRad := radius / 111320.0 // Very rough approx for tile range
	x1, y1 := latLngToTile(lat-marginRad, lng-marginRad, fogZoom)
	x2, y2 := latLngToTile(lat+marginRad, lng+marginRad, fogZoom)

	minX, maxX := x1, x2
	if x1 > x2 {
		minX, maxX = x2, x1
	}
	minY, maxY := y1, y2
	if y1 > y2 {
		minY, maxY = y2, y1
	}

	query := `
		WITH new_area AS (
			SELECT ST_Multi(ST_Buffer(ST_GeomFromText(?, 4326)::geography, ?)::geometry) as geom
		)
		INSERT INTO user_fog_tiles (user_id, z, x, y, geom, updated_at)
		SELECT 
			?, ?::integer, x, y, 
			ST_Multi(ST_Intersection(ST_Transform(ST_TileEnvelope(?::integer, x::integer, y::integer), 4326), (SELECT geom FROM new_area))), 
			?
		FROM generate_series(?::integer, ?::integer) AS x, generate_series(?::integer, ?::integer) AS y
		WHERE ST_Intersects(ST_Transform(ST_TileEnvelope(?::integer, x::integer, y::integer), 4326), (SELECT geom FROM new_area))
		ON CONFLICT (user_id, z, x, y) DO UPDATE SET
			geom = ST_Multi(ST_Buffer(
				ST_Union(
					user_fog_tiles.geom,
					ST_Intersection(ST_Transform(ST_TileEnvelope(user_fog_tiles.z::integer, user_fog_tiles.x::integer, user_fog_tiles.y::integer), 4326), (SELECT geom FROM new_area))
				)::geography,
				0
			)::geometry),
			updated_at = EXCLUDED.updated_at;
	`

	err := tx.Exec(query,
		geomWKT, radius,
		userID, fogZoom, fogZoom, time.Now(),
		minX, maxX, minY, maxY,
		fogZoom,
	).Error
	if err != nil {
		return err
	}

	return nil
}

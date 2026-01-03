package repository

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"gorm.io/gorm"
)

type flavorRepository struct {
	db *gorm.DB
}

func NewFlavorRepository(db *gorm.DB) FlavorRepository {
	return &flavorRepository{db: db}
}

func (r *flavorRepository) UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) (bool, string, error) {
	userUUID, _ := uuid.Parse(userID)
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
	// Note: ST_Buffer(..., 0) is a trick to fix invalid geometries after union

	var geoJSON string
	err := r.db.Raw(query, userUUID, geomWKT, time.Now(), geomWKT).Scan(&geoJSON).Error
	if err != nil {
		return false, "", err
	}

	return true, geoJSON, nil
}

func (r *flavorRepository) GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error) {
	var shops []domain.Shop
	// Use geography casting for meter-based distance calculation
	query := r.db.Where("ST_DWithin(geom::geography, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)", lng, lat, radius)
	if onlyIndie {
		query = query.Where("is_chain = ?", false)
	}

	if err := query.Find(&shops).Error; err != nil {
		return nil, err
	}
	return shops, nil
}

func (r *flavorRepository) GetVisitedShops(ctx context.Context, userID string) ([]domain.Shop, error) {
	var shops []domain.Shop
	userUUID, _ := uuid.Parse(userID)

	err := r.db.Table("shops").
		Joins("JOIN visits ON visits.shop_id = shops.id").
		Where("visits.user_id = ?", userUUID).
		Find(&shops).Error

	return shops, err
}

func (r *flavorRepository) CreateVisit(ctx context.Context, userID string, shopID string) (string, error) {
	userUUID, _ := uuid.Parse(userID)
	shopUUID, _ := uuid.Parse(shopID)

	var shop domain.Shop
	if err := r.db.First(&shop, "id = ?", shopUUID).Error; err != nil {
		return "", err
	}

	// Register visit
	visit := domain.Visit{
		UserID:    userUUID,
		ShopID:    shop.ID,
		VisitedAt: time.Now(),
	}
	if err := r.db.Create(&visit).Error; err != nil {
		return "", err
	}

	// Clear area around the shop (200m instead of 100m)
	geomWKT := fmt.Sprintf("POINT(%f %f)", shop.Lng, shop.Lat)
	radius := 200.0
	if shop.IsChain {
		radius = 100.0
	}

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
	err := r.db.Raw(query, userUUID, geomWKT, radius, time.Now(), geomWKT, radius).Scan(&geoJSON).Error
	return geoJSON, err
}

func (r *flavorRepository) GetClearedArea(ctx context.Context, userID string) (string, error) {
	userUUID, _ := uuid.Parse(userID)
	var geoJSON string
	err := r.db.Raw("SELECT ST_AsGeoJSON(cleared_area) FROM user_fogs WHERE user_id = ?", userUUID).Scan(&geoJSON).Error
	if err == gorm.ErrRecordNotFound {
		return `{"type":"MultiPolygon","coordinates":[]}`, nil
	}
	return geoJSON, err
}

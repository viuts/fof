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

func (r *flavorRepository) GetVisitedShops(ctx context.Context, userID string) ([]domain.Visit, error) {
	var visits []domain.Visit
	userUUID, _ := uuid.Parse(userID)

	err := r.db.Preload("Shop").
		Where("user_id = ?", userUUID).
		Order("visited_at DESC").
		Find(&visits).Error

	return visits, err
}

func (r *flavorRepository) CreateVisit(ctx context.Context, userID string, shopID string, rating int, comment string) (string, int, int, int, error) {
	userUUID, _ := uuid.Parse(userID)
	shopUUID, _ := uuid.Parse(shopID)

	var shop domain.Shop
	if err := r.db.First(&shop, "id = ?", shopUUID).Error; err != nil {
		return "", 0, 0, 0, err
	}

	expGained := 100
	var currentExp, currentLevel int
	var geoJSON string

	err := r.db.Transaction(func(tx *gorm.DB) error {
		// 1. Register visit with EXP
		visit := domain.Visit{
			UserID:    userUUID,
			ShopID:    shop.ID,
			VisitedAt: time.Now(),
			Rating:    rating,
			Comment:   comment,
			Exp:       expGained,
		}
		if err := tx.Create(&visit).Error; err != nil {
			return err
		}

		// 2. Update user EXP and Level
		var user domain.User
		if err := tx.First(&user, "id = ?", userUUID).Error; err != nil {
			return err
		}

		user.Exp += expGained
		// Level formula: Level = floor(sqrt(Exp / 100)) + 1
		// Example: 100 exp -> Lev 2, 400 exp -> Lev 3, 900 exp -> Lev 4
		
		// For simplicity in Go without bringing in math package everywhere:
		level := 1
		for (level * level * 100) <= user.Exp {
			level++
		}
		user.Level = level
		currentExp = user.Exp
		currentLevel = user.Level

		if err := tx.Save(&user).Error; err != nil {
			return err
		}

		// 3. Clear area around the shop (250m "blast")
		geomWKT := fmt.Sprintf("POINT(%f %f)", shop.Lng, shop.Lat)
		radius := 250.0

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

		return tx.Raw(query, userUUID, geomWKT, radius, time.Now(), geomWKT, radius).Scan(&geoJSON).Error
	})

	return geoJSON, expGained, currentExp, currentLevel, err
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

func (r *flavorRepository) GetShop(ctx context.Context, shopID string) (*domain.Shop, error) {
	var shop domain.Shop
	shopUUID, err := uuid.Parse(shopID)
	if err != nil {
		return nil, err
	}
	if err := r.db.WithContext(ctx).First(&shop, "id = ?", shopUUID).Error; err != nil {
		return nil, err
	}
	return &shop, nil
}

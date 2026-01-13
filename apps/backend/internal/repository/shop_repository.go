package repository

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

type ShopRepository interface {
	GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error)
	SearchQuestShops(ctx context.Context, lat, lng, radius float64, categories []string, keyword string, minRating, maxRating float64) ([]domain.Shop, error)
	GetByID(ctx context.Context, shopID uuid.UUID) (*domain.Shop, error)
}

type shopRepository struct {
	db *gorm.DB
}

func NewShopRepository(db *gorm.DB) ShopRepository {
	return &shopRepository{db: db}
}

func (r *shopRepository) GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error) {
	var shops []domain.Shop
	query := r.db.WithContext(ctx).Where("ST_DWithin(geom::geography, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)", lng, lat, radius)
	// Filter out shops that likely not operating
	query = query.Where("rating > 0")
	if onlyIndie {
		query = query.Where("is_chain = ?", false)
	}

	if err := query.Find(&shops).Error; err != nil {
		return nil, err
	}
	return shops, nil
}

func (r *shopRepository) SearchQuestShops(ctx context.Context, lat, lng, radius float64, categories []string, keyword string, minRating, maxRating float64) ([]domain.Shop, error) {
	var shops []domain.Shop
	query := r.db.WithContext(ctx)

	// Geom filter (required)
	query = query.Where("ST_DWithin(geom::geography, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)", lng, lat, radius)

	// Filter Categories
	if len(categories) > 0 {
		query = query.Where("category IN ?", categories)
	}

	// Filter Keyword (Name or Address)
	if keyword != "" {
		likePattern := "%" + keyword + "%"
		query = query.Where("name ILIKE ? OR address ILIKE ?", likePattern, likePattern)
	}

	// Filter Rating
	if minRating > 0 {
		query = query.Where("rating >= ?", minRating)
	}
	if maxRating > 0 {
		query = query.Where("rating <= ?", maxRating)
	}

	if err := query.Find(&shops).Error; err != nil {
		return nil, err
	}
	return shops, nil
}

func (r *shopRepository) GetByID(ctx context.Context, shopID uuid.UUID) (*domain.Shop, error) {
	var shop domain.Shop
	if err := r.db.WithContext(ctx).First(&shop, "id = ?", shopID).Error; err != nil {
		return nil, err
	}
	return &shop, nil
}

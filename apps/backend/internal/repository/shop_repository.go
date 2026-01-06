package repository

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

type ShopRepository interface {
	GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error)
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
	if onlyIndie {
		query = query.Where("is_chain = ?", false)
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

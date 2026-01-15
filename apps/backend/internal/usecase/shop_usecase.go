package usecase

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
)

type ShopUsecase interface {
	GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error)
	GetShop(ctx context.Context, shopID string) (*domain.Shop, error)
}

type shopUsecase struct {
	shopRepo repository.ShopRepository
}

func NewShopUsecase(r repository.ShopRepository) ShopUsecase {
	return &shopUsecase{shopRepo: r}
}

func (u *shopUsecase) GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error) {
	return u.shopRepo.GetNearbyShops(ctx, lat, lng, radius, onlyIndie)
}

func (u *shopUsecase) GetShop(ctx context.Context, shopID string) (*domain.Shop, error) {
	sid, err := uuid.Parse(shopID)
	if err != nil {
		return nil, err
	}
	return u.shopRepo.GetByID(ctx, sid)
}

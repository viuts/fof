package usecase

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
)

type ShopUsecase interface {
	GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error)
	GetQuestShop(ctx context.Context, lat, lng, radius float64, categories []string, keyword string, minRating, maxRating float64, targetTime time.Time) (*domain.Shop, error)
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

func (u *shopUsecase) GetQuestShop(ctx context.Context, lat, lng, radius float64, categories []string, keyword string, minRating, maxRating float64, targetTime time.Time) (*domain.Shop, error) {
	// 1. Search candidates from DB
	candidates, err := u.shopRepo.SearchQuestShops(ctx, lat, lng, radius, categories, keyword, minRating, maxRating)
	if err != nil {
		return nil, err
	}

	// 2. Filter by Opening Hours if specified
	var filtered []domain.Shop
	if !targetTime.IsZero() {
		for _, shop := range candidates {
			if shop.OpeningHours.IsOpen(targetTime) {
				filtered = append(filtered, shop)
			}
		}
	} else {
		filtered = candidates
	}

	if len(filtered) == 0 {
		return nil, nil // No shop found
	}

	// 3. Randomly select one
	// Use simple random selection for now
	// Ideally seed with time or something, but global rand is fine for MVP
	randomIndex := time.Now().UnixNano() % int64(len(filtered))
	selected := filtered[randomIndex]

	return &selected, nil
}

func (u *shopUsecase) GetShop(ctx context.Context, shopID string) (*domain.Shop, error) {
	sid, err := uuid.Parse(shopID)
	if err != nil {
		return nil, err
	}
	return u.shopRepo.GetByID(ctx, sid)
}

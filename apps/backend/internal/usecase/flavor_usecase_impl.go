package usecase

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

type flavorUsecase struct {
	flavorRepo repository.FlavorRepository
}

func NewFlavorUsecase(r repository.FlavorRepository) FlavorUsecase {
	return &flavorUsecase{flavorRepo: r}
}

func (u *flavorUsecase) UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) (bool, string, error) {
	return u.flavorRepo.UpdateLocation(ctx, userID, path)
}

func (u *flavorUsecase) GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error) {
	return u.flavorRepo.GetNearbyShops(ctx, lat, lng, radius, onlyIndie)
}

func (u *flavorUsecase) GetVisitedShops(ctx context.Context, userID string) ([]domain.Shop, error) {
	return u.flavorRepo.GetVisitedShops(ctx, userID)
}

func (u *flavorUsecase) CreateVisit(ctx context.Context, userID string, shopID string) (string, error) {
	return u.flavorRepo.CreateVisit(ctx, userID, shopID)
}

func (u *flavorUsecase) GetClearedArea(ctx context.Context, userID string) (string, error) {
	return u.flavorRepo.GetClearedArea(ctx, userID)
}

package usecase

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/repository"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

type LocationUsecase interface {
	UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) error
	GetClearedArea(ctx context.Context, userID string, minLat, minLng, maxLat, maxLng float64) (string, float64, float64, error)
}

type locationUsecase struct {
	locationRepo repository.LocationRepository
}

func NewLocationUsecase(r repository.LocationRepository) LocationUsecase {
	return &locationUsecase{locationRepo: r}
}

func (u *locationUsecase) UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) error {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return err
	}
	return u.locationRepo.UpdateLocation(ctx, uid, path)
}

func (u *locationUsecase) GetClearedArea(ctx context.Context, userID string, minLat, minLng, maxLat, maxLng float64) (string, float64, float64, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return "", 0, 0, err
	}
	return u.locationRepo.GetClearedArea(ctx, uid, minLat, minLng, maxLat, maxLng)
}


package usecase

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/repository"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

type LocationUsecase interface {
	UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) (bool, string, error)
	GetClearedArea(ctx context.Context, userID string) (string, error)
}

type locationUsecase struct {
	locationRepo repository.LocationRepository
}

func NewLocationUsecase(r repository.LocationRepository) LocationUsecase {
	return &locationUsecase{locationRepo: r}
}

func (u *locationUsecase) UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) (bool, string, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return false, "", err
	}
	return u.locationRepo.UpdateLocation(ctx, uid, path)
}

func (u *locationUsecase) GetClearedArea(ctx context.Context, userID string) (string, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return "", err
	}
	return u.locationRepo.GetClearedArea(ctx, uid)
}

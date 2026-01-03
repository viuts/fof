package usecase

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/domain"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

type FlavorUsecase interface {
	UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) (newlyCleared bool, geoJSON string, err error)
	GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error)
	GetVisitedShops(ctx context.Context, userID string) ([]domain.Shop, error)
	CreateVisit(ctx context.Context, userID string, shopID string, rating int, comment string) (geoJSON string, expGained int, currentExp int, currentLevel int, err error)
	GetClearedArea(ctx context.Context, userID string) (string, error)
}

package usecase

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"

	"github.com/google/uuid"
)

type flavorUsecase struct {
	flavorRepo      repository.FlavorRepository
	achievementUseCase AchievementUseCase
}

func NewFlavorUsecase(r repository.FlavorRepository, au AchievementUseCase) FlavorUsecase {
	return &flavorUsecase{
		flavorRepo:      r,
		achievementUseCase: au,
	}
}

func (u *flavorUsecase) UpdateLocation(ctx context.Context, userID string, path []*fofv1.LatLng) (bool, string, error) {
	return u.flavorRepo.UpdateLocation(ctx, userID, path)
}

func (u *flavorUsecase) GetNearbyShops(ctx context.Context, lat, lng, radius float64, onlyIndie bool) ([]domain.Shop, error) {
	return u.flavorRepo.GetNearbyShops(ctx, lat, lng, radius, onlyIndie)
}

func (u *flavorUsecase) GetVisitedShops(ctx context.Context, userID string) ([]domain.Visit, error) {
	return u.flavorRepo.GetVisitedShops(ctx, userID)
}

func (u *flavorUsecase) CreateVisit(ctx context.Context, userID string, shopID string, rating int, comment string) (string, int, int, int, []domain.Achievement, error) {
	geoJSON, level, exp, gainedExp, err := u.flavorRepo.CreateVisit(ctx, userID, shopID, rating, comment)
	if err != nil {
		return "", 0, 0, 0, nil, err
	}

	// Calculate unlocked achievements
	var unlocked []domain.Achievement
	uid, _ := uuid.Parse(userID)
	
	// Context data for achievement check
	// We might need to fetch shop details here to know category etc, 
	// but for now let's assume we can get it or verify it in usecase.
	// For simplicity, we just pass what we have.
    // Ideally, we should fetch the shop to pass its category.
	shop, _ := u.flavorRepo.GetShop(ctx, shopID)
	
	contextData := map[string]interface{}{
		"shop_id": shopID,
		"rating": rating,
	}
	if shop != nil {
		contextData["category"] = shop.Category
		contextData["is_chain"] = shop.IsChain
	}

	unlocked, _ = u.achievementUseCase.CheckAchievements(ctx, uid, "VISIT", contextData)

	return geoJSON, level, exp, gainedExp, unlocked, nil
}

func (u *flavorUsecase) GetClearedArea(ctx context.Context, userID string) (string, error) {
	return u.flavorRepo.GetClearedArea(ctx, userID)
}

func (u *flavorUsecase) GetAchievements(ctx context.Context, userID string) ([]domain.UserAchievementComposite, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}
	return u.achievementUseCase.GetAchievements(ctx, uid)
}

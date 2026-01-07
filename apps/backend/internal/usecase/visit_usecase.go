package usecase

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
	"gorm.io/gorm"
)

type VisitUsecase interface {
	GetVisitedShops(ctx context.Context, userID string) ([]domain.Visit, error)
	CreateVisit(ctx context.Context, userID string, shopID string, rating int, comment string) (string, int, int, int, []domain.Achievement, error)
	UpdateVisit(ctx context.Context, userID string, shopID string, rating int, comment string, imageURLs []string) error
}

type visitUsecase struct {
	visitRepo     repository.VisitRepository
	shopRepo      repository.ShopRepository
	userRepo      repository.UserRepository
	locationRepo  repository.LocationRepository
	achievementUC AchievementUseCase
}

func NewVisitUsecase(vr repository.VisitRepository, sr repository.ShopRepository, ur repository.UserRepository, lr repository.LocationRepository, au AchievementUseCase) VisitUsecase {
	return &visitUsecase{
		visitRepo:     vr,
		shopRepo:      sr,
		userRepo:      ur,
		locationRepo:  lr,
		achievementUC: au,
	}
}

func (u *visitUsecase) GetVisitedShops(ctx context.Context, userID string) ([]domain.Visit, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}
	return u.visitRepo.GetByUserID(ctx, uid)
}

func (u *visitUsecase) CreateVisit(ctx context.Context, userID string, shopID string, rating int, comment string) (string, int, int, int, []domain.Achievement, error) {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return "", 0, 0, 0, nil, err
	}
	shopUUID, err := uuid.Parse(shopID)
	if err != nil {
		return "", 0, 0, 0, nil, err
	}

	shop, err := u.shopRepo.GetByID(ctx, shopUUID)
	if err != nil {
		return "", 0, 0, 0, nil, err
	}

	expGained := 100
	var currentExp, currentLevel int
	var geoJSON string

	err = u.visitRepo.GetDB().Transaction(func(tx *gorm.DB) error {
		// 1. Register visit
		visit := domain.Visit{
			UserID:    userUUID,
			ShopID:    shop.ID,
			VisitedAt: time.Now(),
			Rating:    rating,
			Comment:   comment,
			Exp:       expGained,
		}
		if err := u.visitRepo.CreateWithTx(ctx, tx, &visit); err != nil {
			return err
		}

		// 2. Update user
		user, err := u.userRepo.GetByID(ctx, userUUID)
		if err != nil {
			return err
		}
		user.Exp += expGained
		level := 1
		for (level * level * 100) <= user.Exp {
			level++
		}
		user.Level = level
		currentExp = user.Exp
		currentLevel = user.Level

		if err := u.userRepo.SaveWithTx(ctx, tx, user); err != nil {
			return err
		}

		// 3. Clear area
		geoJSON, err = u.locationRepo.ClearAreaAroundPoint(ctx, tx, userUUID, shop.Lat, shop.Lng, 250.0)
		return err
	})

	if err != nil {
		return "", 0, 0, 0, nil, err
	}

	now := time.Now()
	contextData := map[string]interface{}{
		"shop_id":      shopID,
		"rating":       rating,
		"category":     shop.Category,
		"is_chain":     shop.IsChain,
		"day_of_week":  int(now.Weekday()), // 0=Sunday, 6=Saturday
		"hour":         now.Hour(),
	}

	unlocked, _ := u.achievementUC.CheckAchievements(ctx, userUUID, "VISIT", contextData)

	return geoJSON, currentLevel, currentExp, expGained, unlocked, nil
}

func (u *visitUsecase) UpdateVisit(ctx context.Context, userID string, shopID string, rating int, comment string, imageURLs []string) error {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return err
	}
	shopUUID, err := uuid.Parse(shopID)
	if err != nil {
		return err
	}

	visit, err := u.visitRepo.GetByUserIDAndShopID(ctx, userUUID, shopUUID)
	if err != nil {
		return err
	}

	visit.Rating = rating
	visit.Comment = comment
	visit.ImageURLs = imageURLs

	return u.visitRepo.Save(ctx, visit)
}

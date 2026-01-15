package usecase

import (
	"context"
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
	"gorm.io/gorm"
)

type QuestUsecase interface {
	StartQuest(ctx context.Context, userID string, shopID string, lat, lng, radius float64, categories []string, keyword string, minRating, maxRating float64, targetTime time.Time) (*domain.Quest, error)
	CompleteQuest(ctx context.Context, userID, questID string) (*domain.Quest, error)
	CancelQuest(ctx context.Context, userID, questID string) (*domain.Quest, error)
	GetActiveQuest(ctx context.Context, userID string) (*domain.Quest, error)
	GetQuestHistory(ctx context.Context, userID string, limit, offset int) ([]domain.Quest, int64, error)
}

type questUsecase struct {
	questRepo repository.QuestRepository
	shopRepo  repository.ShopRepository
}

func NewQuestUsecase(qr repository.QuestRepository, sr repository.ShopRepository) QuestUsecase {
	return &questUsecase{
		questRepo: qr,
		shopRepo:  sr,
	}
}

func (u *questUsecase) StartQuest(ctx context.Context, userID string, shopID string, lat, lng, radius float64, categories []string, keyword string, minRating, maxRating float64, targetTime time.Time) (*domain.Quest, error) {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}

	// Check if user already has an active quest
	activeQuest, err := u.questRepo.FindActiveByUserID(ctx, userUUID)
	if err == nil && activeQuest != nil {
		return nil, errors.New("user already has an active quest")
	}

	var shopUUID uuid.UUID

	// If shop_id is provided, use it directly; otherwise search for a quest shop
	if shopID != "" {
		shopUUID, err = uuid.Parse(shopID)
		if err != nil {
			return nil, err
		}
		// Verify shop exists
		_, err = u.shopRepo.GetByID(ctx, shopUUID)
		if err != nil {
			return nil, err
		}
	} else {
		// Use quest shop search logic: get candidates and filter by opening hours
		candidates, err := u.shopRepo.SearchQuestShops(ctx, lat, lng, radius, categories, keyword, minRating, maxRating)
		if err != nil {
			return nil, err
		}

		// Filter by opening hours if targetTime is specified
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
			return nil, errors.New("no quest shop found matching criteria")
		}

		// Randomly select one
		randomIndex := time.Now().UnixNano() % int64(len(filtered))
		shopUUID = filtered[randomIndex].ID
	}

	// Create new quest
	quest := &domain.Quest{
		UserID:    userUUID,
		ShopID:    shopUUID,
		Status:    domain.QuestStatusActive,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

	if err := u.questRepo.Create(ctx, quest); err != nil {
		return nil, err
	}

	// Reload with associations
	return u.questRepo.FindByID(ctx, quest.ID)
}

func (u *questUsecase) CompleteQuest(ctx context.Context, userID, questID string) (*domain.Quest, error) {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}
	questUUID, err := uuid.Parse(questID)
	if err != nil {
		return nil, err
	}

	quest, err := u.questRepo.FindByID(ctx, questUUID)
	if err != nil {
		return nil, err
	}

	// Verify quest belongs to user
	if quest.UserID != userUUID {
		return nil, errors.New("quest does not belong to user")
	}

	// Verify quest is active
	if quest.Status != domain.QuestStatusActive {
		return nil, errors.New("quest is not active")
	}

	// Update quest status
	now := time.Now()
	quest.Status = domain.QuestStatusCompleted
	quest.CompletedAt = &now
	quest.UpdatedAt = now

	if err := u.questRepo.Update(ctx, quest); err != nil {
		return nil, err
	}

	return quest, nil
}

func (u *questUsecase) CancelQuest(ctx context.Context, userID, questID string) (*domain.Quest, error) {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}
	questUUID, err := uuid.Parse(questID)
	if err != nil {
		return nil, err
	}

	quest, err := u.questRepo.FindByID(ctx, questUUID)
	if err != nil {
		return nil, err
	}

	// Verify quest belongs to user
	if quest.UserID != userUUID {
		return nil, errors.New("quest does not belong to user")
	}

	// Verify quest is active
	if quest.Status != domain.QuestStatusActive {
		return nil, errors.New("quest is not active")
	}

	// Update quest status
	quest.Status = domain.QuestStatusCancelled
	quest.UpdatedAt = time.Now()

	if err := u.questRepo.Update(ctx, quest); err != nil {
		return nil, err
	}

	return quest, nil
}

func (u *questUsecase) GetActiveQuest(ctx context.Context, userID string) (*domain.Quest, error) {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}

	quest, err := u.questRepo.FindActiveByUserID(ctx, userUUID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil // No active quest is not an error
		}
		return nil, err
	}

	return quest, nil
}

func (u *questUsecase) GetQuestHistory(ctx context.Context, userID string, limit, offset int) ([]domain.Quest, int64, error) {
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, 0, err
	}

	// Default pagination
	if limit <= 0 {
		limit = 20
	}
	if offset < 0 {
		offset = 0
	}

	quests, err := u.questRepo.FindByUserID(ctx, userUUID, limit, offset)
	if err != nil {
		return nil, 0, err
	}

	total, err := u.questRepo.CountByUserID(ctx, userUUID)
	if err != nil {
		return nil, 0, err
	}

	return quests, total, nil
}

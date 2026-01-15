package usecase

import (
	"context"
	"log"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
)

type AchievementUseCase interface {
	CheckAchievements(ctx context.Context, userID uuid.UUID, eventType domain.EventType, achCtx domain.AchievementContext) ([]domain.Achievement, error)
	GetAchievements(ctx context.Context, userID uuid.UUID) ([]domain.UserAchievementComposite, error)
}

type achievementUseCase struct {
	achievementRepo repository.AchievementRepository
}

func NewAchievementUseCase(ar repository.AchievementRepository) AchievementUseCase {
	return &achievementUseCase{
		achievementRepo: ar,
	}
}

func (u *achievementUseCase) CheckAchievements(ctx context.Context, userID uuid.UUID, eventType domain.EventType, achCtx domain.AchievementContext) ([]domain.Achievement, error) {
	// 1. Get all achievements
	allAchievements, err := u.achievementRepo.GetAll(ctx)
	if err != nil {
		return nil, err
	}

	// 2. Get user current progress
	userProgressList, err := u.achievementRepo.GetUserProgress(ctx, userID)
	if err != nil {
		return nil, err
	}
	progressMap := make(map[string]*domain.UserAchievement)
	for i := range userProgressList {
		progressMap[userProgressList[i].AchievementID] = &userProgressList[i]
	}

	var unlocked []domain.Achievement

	// 3. Evaluate each achievement
	var progressToSave []*domain.UserAchievement
	for _, ach := range allAchievements {
		// Skip if already unlocked
		if p, exists := progressMap[ach.ID]; exists && p.IsUnlocked {
			continue
		}

		// Initialize progress if not exists
		currentProg := progressMap[ach.ID]
		if currentProg == nil {
			currentProg = &domain.UserAchievement{
				UserID:        userID,
				AchievementID: ach.ID,
				CurrentValue:  0,
				IsUnlocked:    false,
			}
		}

		// LOGIC: Evaluate based on type
		if ach.Evaluate(currentProg, eventType, achCtx) {
			currentProg.IsUnlocked = true
			now := time.Now()
			currentProg.UnlockedAt = &now
			unlocked = append(unlocked, ach)
		}

		// Add to batch
		progressToSave = append(progressToSave, currentProg)
	}

	// 4. Batch Save
	if len(progressToSave) > 0 {
		if err := u.achievementRepo.SaveUserProgressBatch(ctx, progressToSave); err != nil {
			log.Printf("Failed to save user progress batch: %v", err)
		}
	}

	return unlocked, nil
}

func (u *achievementUseCase) GetAchievements(ctx context.Context, userID uuid.UUID) ([]domain.UserAchievementComposite, error) {
	// 1. Get all achievements
	allAchievements, err := u.achievementRepo.GetAll(ctx)
	if err != nil {
		return nil, err
	}

	// 2. Get user current progress
	userProgressList, err := u.achievementRepo.GetUserProgress(ctx, userID)
	if err != nil {
		return nil, err
	}
	progressMap := make(map[string]*domain.UserAchievement)
	for i := range userProgressList {
		progressMap[userProgressList[i].AchievementID] = &userProgressList[i]
	}

	// 3. Merge
	var result []domain.UserAchievementComposite
	for _, ach := range allAchievements {
		result = append(result, domain.UserAchievementComposite{
			Achievement: ach,
			Progress:    progressMap[ach.ID],
		})
	}

	return result, nil
}

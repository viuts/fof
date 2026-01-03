package usecase

import (
	"context"
	"encoding/json"
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
)

type AchievementUseCase interface {
	CheckAchievements(ctx context.Context, userID uuid.UUID, eventType string, contextData map[string]interface{}) ([]domain.Achievement, error)
	GetAchievements(ctx context.Context, userID uuid.UUID) ([]domain.UserAchievementComposite, error)
}

type achievementUseCase struct {
	achievementRepo repository.AchievementRepository
	flavorRepo      repository.FlavorRepository
}

func NewAchievementUseCase(ar repository.AchievementRepository, fr repository.FlavorRepository) AchievementUseCase {
	return &achievementUseCase{
		achievementRepo: ar,
		flavorRepo:      fr,
	}
}

func (u *achievementUseCase) CheckAchievements(ctx context.Context, userID uuid.UUID, eventType string, contextData map[string]interface{}) ([]domain.Achievement, error) {
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
		isNowUnlocked := false

		switch ach.Type {
		case domain.AchievementTypeCount:
			// Simple counter check.
			// For "Visit" events, we might just increment if condition matches.
			// E.g. "Visit 10 Ramen shops"
			if eventType == "VISIT" {
				// Check condition config
				var config map[string]interface{}
				if len(ach.ConditionConfig) > 0 {
					_ = json.Unmarshal(ach.ConditionConfig, &config)
				}

				// Verify conditions (category, etc.)
				match := true
				if targetCat, ok := config["category"].(string); ok && targetCat != "" {
					if visitedCat, has := contextData["category"].(string); !has || !strings.EqualFold(visitedCat, targetCat) {
						match = false
					}
				}

				// Indie filter
				if onlyIndie, ok := config["indie"].(bool); ok && onlyIndie {
					if isChain, has := contextData["is_chain"].(bool); has && isChain {
						match = false
					}
				}

				if match {
					currentProg.CurrentValue++
					if currentProg.CurrentValue >= ach.TargetValue {
						isNowUnlocked = true
					}
				}
			}

		case domain.AchievementTypeCollection:
			if eventType == "VISIT" {
				var config map[string]interface{}
				if len(ach.ConditionConfig) > 0 {
					_ = json.Unmarshal(ach.ConditionConfig, &config)
				}

				if uniqueCatTab, ok := config["unique_category"].(bool); ok && uniqueCatTab {
					visitedCat, has := contextData["category"].(string)
					if has && visitedCat != "" {
						// Load tracked categories from metadata
						var tracked []string
						if len(currentProg.Metadata) > 0 {
							_ = json.Unmarshal(currentProg.Metadata, &tracked)
						}

						// Check if this category is new
						isNew := true
						for _, t := range tracked {
							if strings.EqualFold(t, visitedCat) {
								isNew = false
								break
							}
						}

						if isNew {
							tracked = append(tracked, visitedCat)
							currentProg.Metadata, _ = json.Marshal(tracked)
							currentProg.CurrentValue = len(tracked)
							if currentProg.CurrentValue >= ach.TargetValue {
								isNowUnlocked = true
							}
						}
					}
				}
			}

		case domain.AchievementTypeCondition:
			if eventType == "VISIT" {
				var config map[string]interface{}
				if len(ach.ConditionConfig) > 0 {
					_ = json.Unmarshal(ach.ConditionConfig, &config)
				}

				match := true
				// Time window check
				timeStart, hasStart := config["time_start"].(string) // "HH:MM"
				timeEnd, hasEnd := config["time_end"].(string)       // "HH:MM"

				if hasStart && hasEnd {
					now := time.Now()
					// Simplistic time check for "HH:MM" format
					currentStr := now.Format("15:04")
					if currentStr < timeStart || currentStr > timeEnd {
						match = false
					}
				}

				if match {
					currentProg.CurrentValue++
					if currentProg.CurrentValue >= ach.TargetValue {
						isNowUnlocked = true
					}
				}
			}
		}

		if isNowUnlocked {
			currentProg.IsUnlocked = true
			now := time.Now()
			currentProg.UnlockedAt = &now
			unlocked = append(unlocked, ach)
		}

		// Save progress (even if not unlocked, to track count)
		_ = u.achievementRepo.SaveUserProgress(ctx, currentProg)
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

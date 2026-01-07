package handler

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type AchievementHandler struct {
	fofv1.UnimplementedAchievementServiceServer
	achievementUC usecase.AchievementUseCase
}

func NewAchievementHandler(u usecase.AchievementUseCase) *AchievementHandler {
	return &AchievementHandler{
		achievementUC: u,
	}
}

func MapTierToProto(tier domain.AchievementTier) fofv1.AchievementTier {
	switch tier {
	case domain.AchievementTierBronze:
		return fofv1.AchievementTier_ACHIEVEMENT_TIER_BRONZE
	case domain.AchievementTierSilver:
		return fofv1.AchievementTier_ACHIEVEMENT_TIER_SILVER
	case domain.AchievementTierGold:
		return fofv1.AchievementTier_ACHIEVEMENT_TIER_GOLD
	case domain.AchievementTierPlatinum:
		return fofv1.AchievementTier_ACHIEVEMENT_TIER_PLATINUM
	default:
		return fofv1.AchievementTier_ACHIEVEMENT_TIER_UNSPECIFIED
	}
}

func (h *AchievementHandler) GetAchievements(ctx context.Context, req *fofv1.GetAchievementsRequest) (*fofv1.GetAchievementsResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return nil, status.Error(codes.InvalidArgument, "invalid user id")
	}

	achievements, err := h.achievementUC.GetAchievements(ctx, uid)
	if err != nil {
		return nil, err
	}

	pbAchievements := make([]*fofv1.UserAchievementStatus, len(achievements))
	for i, a := range achievements {
		unlockedAt := ""
		if a.Progress != nil && a.Progress.UnlockedAt != nil {
			unlockedAt = a.Progress.UnlockedAt.Format(time.RFC3339)
		}

		currentValue := int32(0)
		isUnlocked := false
		if a.Progress != nil {
			currentValue = int32(a.Progress.CurrentValue)
			isUnlocked = a.Progress.IsUnlocked
		}

		pbAchievements[i] = &fofv1.UserAchievementStatus{
			Achievement: &fofv1.Achievement{
				Id:          a.Achievement.ID,
				Name:        a.Achievement.Name,
				Description: a.Achievement.Description,
				Category:    a.Achievement.Category,
				ExpReward:   int32(a.Achievement.ExpReward),
				TitleReward: a.Achievement.TitleReward,
				Tier:        MapTierToProto(a.Achievement.Tier),
			},
			IsUnlocked:   isUnlocked,
			CurrentValue: currentValue,
			TargetValue:  int32(a.Achievement.TargetValue),
			UnlockedAt:   unlockedAt,
		}
	}

	return &fofv1.GetAchievementsResponse{
		Achievements: pbAchievements,
	}, nil
}

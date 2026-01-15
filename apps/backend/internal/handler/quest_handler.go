package handler

import (
	"context"
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"gorm.io/gorm"
)

type QuestHandler struct {
	fofv1.UnimplementedQuestServiceServer
	questUC usecase.QuestUsecase
}

func NewQuestHandler(u usecase.QuestUsecase) *QuestHandler {
	return &QuestHandler{
		questUC: u,
	}
}

func (h *QuestHandler) StartQuest(ctx context.Context, req *fofv1.StartQuestRequest) (*fofv1.StartQuestResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	// Map rating filter to min/max rating
	var minRating, maxRating float64
	switch req.RatingFilter {
	case fofv1.QuestRatingFilter_QUEST_RATING_FILTER_EXCELLENT:
		minRating = 3.51 // > 3.5
	case fofv1.QuestRatingFilter_QUEST_RATING_FILTER_AVERAGE:
		minRating = 3.0
		maxRating = 3.5
	case fofv1.QuestRatingFilter_QUEST_RATING_FILTER_MIXED:
		maxRating = 2.99 // < 3.0
	}

	// Parse open_at_time
	var targetTime time.Time
	if req.OpenAtTime > 0 {
		// Assume JST for shops
		jst, err := time.LoadLocation("Asia/Tokyo")
		if err != nil {
			// Fallback to FixedZone if LoadLocation fails
			jst = time.FixedZone("Asia/Tokyo", 9*60*60)
		}
		targetTime = time.Unix(req.OpenAtTime, 0).In(jst)
	}

	quest, err := h.questUC.StartQuest(ctx, userID, req.ShopId, req.Lat, req.Lng, req.RadiusMeters, req.Categories, req.Keyword, minRating, maxRating, targetTime)
	if err != nil {
		if err.Error() == "no quest shop found matching criteria" {
			return nil, status.Error(codes.NotFound, err.Error())
		}
		if err.Error() == "user already has an active quest" {
			return nil, status.Error(codes.AlreadyExists, err.Error())
		}
		return nil, status.Error(codes.Internal, err.Error())
	}

	return &fofv1.StartQuestResponse{
		Quest: questToProto(quest),
	}, nil
}

func (h *QuestHandler) CompleteQuest(ctx context.Context, req *fofv1.CompleteQuestRequest) (*fofv1.CompleteQuestResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	quest, err := h.questUC.CompleteQuest(ctx, userID, req.QuestId)
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}

	return &fofv1.CompleteQuestResponse{
		Success: true,
		Quest:   questToProto(quest),
	}, nil
}

func (h *QuestHandler) CancelQuest(ctx context.Context, req *fofv1.CancelQuestRequest) (*fofv1.CancelQuestResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	quest, err := h.questUC.CancelQuest(ctx, userID, req.QuestId)
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}

	return &fofv1.CancelQuestResponse{
		Success: true,
		Quest:   questToProto(quest),
	}, nil
}

func (h *QuestHandler) GetActiveQuest(ctx context.Context, req *fofv1.GetActiveQuestRequest) (*fofv1.GetActiveQuestResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	quest, err := h.questUC.GetActiveQuest(ctx, userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return &fofv1.GetActiveQuestResponse{
				Quest:          nil,
				HasActiveQuest: false,
			}, nil
		}
		return nil, status.Error(codes.Internal, err.Error())
	}

	if quest == nil {
		return &fofv1.GetActiveQuestResponse{
			Quest:          nil,
			HasActiveQuest: false,
		}, nil
	}

	return &fofv1.GetActiveQuestResponse{
		Quest:          questToProto(quest),
		HasActiveQuest: true,
	}, nil
}

func (h *QuestHandler) GetQuestHistory(ctx context.Context, req *fofv1.GetQuestHistoryRequest) (*fofv1.GetQuestHistoryResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	quests, total, err := h.questUC.GetQuestHistory(ctx, userID, int(req.Limit), int(req.Offset))
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}

	pbQuests := make([]*fofv1.Quest, len(quests))
	for i, q := range quests {
		pbQuests[i] = questToProto(&q)
	}

	return &fofv1.GetQuestHistoryResponse{
		Quests: pbQuests,
		Total:  int32(total),
	}, nil
}

// Helper function to convert domain Quest to proto Quest
func questToProto(q *domain.Quest) *fofv1.Quest {
	if q == nil {
		return nil
	}

	pbQuest := &fofv1.Quest{
		Id:        q.ID.String(),
		UserId:    q.UserID.String(),
		Status:    questStatusToProto(q.Status),
		CreatedAt: q.CreatedAt.Format(time.RFC3339),
		UpdatedAt: q.UpdatedAt.Format(time.RFC3339),
	}

	// Add shop if preloaded
	if q.Shop.ID != uuid.Nil {
		pbQuest.Shop = &fofv1.Shop{
			Id:              q.Shop.ID.String(),
			Name:            q.Shop.Name,
			Lat:             q.Shop.Lat,
			Lng:             q.Shop.Lng,
			Category:        q.Shop.Category,
			IsChain:         q.Shop.IsChain,
			Address:         q.Shop.Address,
			Phone:           q.Shop.Phone,
			ImageUrls:       q.Shop.ImageURLs,
			Rating:          q.Shop.Rating,
			SourceUrl:       q.Shop.SourceURL,
			ClearanceRadius: q.Shop.GetClearanceRadius(),
		}
	}

	if q.CompletedAt != nil {
		pbQuest.CompletedAt = q.CompletedAt.Format(time.RFC3339)
	}

	return pbQuest
}

func questStatusToProto(status domain.QuestStatus) fofv1.QuestStatus {
	switch status {
	case domain.QuestStatusActive:
		return fofv1.QuestStatus_QUEST_STATUS_ACTIVE
	case domain.QuestStatusCompleted:
		return fofv1.QuestStatus_QUEST_STATUS_COMPLETED
	case domain.QuestStatusCancelled:
		return fofv1.QuestStatus_QUEST_STATUS_CANCELLED
	default:
		return fofv1.QuestStatus_QUEST_STATUS_UNSPECIFIED
	}
}

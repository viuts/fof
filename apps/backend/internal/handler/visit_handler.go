package handler

import (
	"context"
	"time"

	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type VisitHandler struct {
	fofv1.UnimplementedVisitServiceServer
	visitUC usecase.VisitUsecase
}

func NewVisitHandler(u usecase.VisitUsecase) *VisitHandler {
	return &VisitHandler{
		visitUC: u,
	}
}

func (h *VisitHandler) GetVisitedShops(ctx context.Context, req *fofv1.GetVisitedShopsRequest) (*fofv1.GetVisitedShopsResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	visits, err := h.visitUC.GetVisitedShops(ctx, userID)
	if err != nil {
		return nil, err
	}

	pbVisitedShops := make([]*fofv1.VisitedShop, len(visits))
	for i, v := range visits {
		s := v.Shop
		pbVisitedShops[i] = &fofv1.VisitedShop{
			Shop: &fofv1.Shop{
				Id:              s.ID.String(),
				Name:            s.Name,
				Lat:             s.Lat,
				Lng:             s.Lng,
				Category:        s.Category,
				IsChain:         s.IsChain,
				Address:         s.Address,
				Phone:           s.Phone,
				ImageUrls:       s.ImageURLs,
				Rating:          s.Rating,
				SourceUrl:       s.SourceURL,
				ClearanceRadius: s.GetClearanceRadius(),
				IsVisited:       true,
			},
			VisitedAt: v.VisitedAt.Format(time.RFC3339),
			Rating:    int32(v.Rating),
			Comment:   v.Comment,
			ImageUrls: v.ImageURLs,
		}
	}

	return &fofv1.GetVisitedShopsResponse{
		VisitedShops: pbVisitedShops,
	}, nil
}

func (h *VisitHandler) CreateVisit(ctx context.Context, req *fofv1.CreateVisitRequest) (*fofv1.CreateVisitResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	level, currentExp, expGained, unlocked, err := h.visitUC.CreateVisit(ctx, userID, req.ShopId, int(req.Rating), req.Comment)
	if err != nil {
		return nil, err
	}

	pbAchievements := make([]*fofv1.Achievement, len(unlocked))
	for i, ach := range unlocked {
		pbAchievements[i] = &fofv1.Achievement{
			Id:          ach.ID,
			Name:        ach.Name,
			Description: ach.Description,
			Category:    string(ach.Category),
			ExpReward:   int32(ach.ExpReward),
			Tier:        MapTierToProto(ach.Tier),
		}
	}

	return &fofv1.CreateVisitResponse{
		Success:              true,
		ExpGained:            int32(expGained),
		CurrentExp:           int32(currentExp),
		CurrentLevel:         int32(level),
		UnlockedAchievements: pbAchievements,
	}, nil
}

func (h *VisitHandler) UpdateVisit(ctx context.Context, req *fofv1.UpdateVisitRequest) (*fofv1.UpdateVisitResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	if err := h.visitUC.UpdateVisit(ctx, userID, req.ShopId, int(req.Rating), req.Comment, req.ImageUrls); err != nil {
		return nil, err
	}

	return &fofv1.UpdateVisitResponse{
		Success: true,
	}, nil
}

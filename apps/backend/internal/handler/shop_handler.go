package handler

import (
	"context"
	"encoding/json"
	"time"

	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type ShopHandler struct {
	fofv1.UnimplementedShopServiceServer
	shopUC  usecase.ShopUsecase
	visitUC usecase.VisitUsecase
}

func NewShopHandler(suc usecase.ShopUsecase, vuc usecase.VisitUsecase) *ShopHandler {
	return &ShopHandler{
		shopUC:  suc,
		visitUC: vuc,
	}
}

func (h *ShopHandler) GetNearbyShops(ctx context.Context, req *fofv1.GetNearbyShopsRequest) (*fofv1.GetNearbyShopsResponse, error) {
	shops, err := h.shopUC.GetNearbyShops(ctx, req.Lat, req.Lng, req.RadiusMeters, req.ExclusiveIndependent)
	if err != nil {
		return nil, err
	}

	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	visitedShops, _ := h.visitUC.GetVisitedShops(ctx, userID)
	visitedMap := make(map[string]bool)
	for _, vs := range visitedShops {
		visitedMap[vs.ShopID.String()] = true
	}

	pbShops := make([]*fofv1.Shop, len(shops))
	for i, s := range shops {
		ohJSON, _ := json.Marshal(s.OpeningHours)
		pbShops[i] = &fofv1.Shop{
			Id:              s.ID.String(),
			Name:            s.Name,
			Lat:             s.Lat,
			Lng:             s.Lng,
			Category:        s.Category,
			IsChain:         s.IsChain,
			Address:         s.Address,
			Phone:           s.Phone,
			OpeningHours:    string(ohJSON),
			ImageUrls:       s.ImageURLs,
			Rating:          s.Rating,
			SourceUrl:       s.SourceURL,
			ClearanceRadius: s.ClearanceRadius,
			IsVisited:       visitedMap[s.ID.String()],
		}
	}

	return &fofv1.GetNearbyShopsResponse{
		Shops: pbShops,
	}, nil
}

func (h *ShopHandler) GetQuestShop(ctx context.Context, req *fofv1.GetQuestShopRequest) (*fofv1.GetQuestShopResponse, error) {
	// Map Rating Filter
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

	// Parse OpenAtTime
	var targetTime time.Time
	if req.OpenAtTime > 0 {
		// Assume JST for shops
		jst, err := time.LoadLocation("Asia/Tokyo")
		if err != nil {
			// Fallback to FixedZone if LoadLocation fails (e.g. absent zoneinfo)
			jst = time.FixedZone("Asia/Tokyo", 9*60*60)
		}
		targetTime = time.Unix(req.OpenAtTime, 0).In(jst)
	}

	shop, err := h.shopUC.GetQuestShop(
		ctx,
		req.Lat,
		req.Lng,
		req.RadiusMeters,
		req.Categories,
		req.Keyword,
		minRating,
		maxRating,
		targetTime,
	)
	if err != nil {
		return nil, err
	}
	if shop == nil {
		// Return empty response if not found (or error?)
		// Usually empty response or specific "not found" error.
		// For Quest, maybe NOT_FOUND is appropriate.
		return nil, status.Error(codes.NotFound, "no quest shop found matching criteria")
	}

	// Helper to convert domain to proto
	ohJSON, _ := json.Marshal(shop.OpeningHours)

	// Check visited status
	// Ideally we should use visitUC to check if THIS shop is visited.
	// Optimization: Batch check? No, straightforward GetVisitedShops or specific check.
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	isVisited := false
	if ok && userID != "" {
		// Just check all visited for now (simplest given existing UseCase)
		// Or assume client handles it. But we want "is_visited" field.
		visitedShops, _ := h.visitUC.GetVisitedShops(ctx, userID)
		for _, vs := range visitedShops {
			if vs.ShopID == shop.ID {
				isVisited = true
				break
			}
		}
	}

	return &fofv1.GetQuestShopResponse{
		Shop: &fofv1.Shop{
			Id:              shop.ID.String(),
			Name:            shop.Name,
			Lat:             shop.Lat,
			Lng:             shop.Lng,
			Category:        shop.Category,
			IsChain:         shop.IsChain,
			Address:         shop.Address,
			Phone:           shop.Phone,
			OpeningHours:    string(ohJSON),
			ImageUrls:       shop.ImageURLs,
			Rating:          shop.Rating,
			SourceUrl:       shop.SourceURL,
			ClearanceRadius: shop.ClearanceRadius,
			IsVisited:       isVisited,
		},
	}, nil
}

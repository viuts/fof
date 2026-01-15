package handler

import (
	"context"
	"encoding/json"

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
			ClearanceRadius: s.GetClearanceRadius(),
			IsVisited:       visitedMap[s.ID.String()],
			AveragePrice:    int32(s.AveragePrice),
			Reservable:      s.Reservable,
		}
	}

	return &fofv1.GetNearbyShopsResponse{
		Shops: pbShops,
	}, nil
}

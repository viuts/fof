package handler

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

type FlavorHandler struct {
	fofv1.UnimplementedFlavorServiceServer
	flavorUsecase usecase.FlavorUsecase
}

func NewFlavorHandler(u usecase.FlavorUsecase) *FlavorHandler {
	return &FlavorHandler{
		flavorUsecase: u,
	}
}

func (h *FlavorHandler) UpdateLocation(ctx context.Context, req *fofv1.UpdateLocationRequest) (*fofv1.UpdateLocationResponse, error) {
	// For now, hardcode a user ID for MVP
	userID := "24e7e8ae-c205-4dba-b42d-f6294db20e9e"
	newlyCleared, geoJSON, err := h.flavorUsecase.UpdateLocation(ctx, userID, req.Path)
	if err != nil {
		return nil, err
	}

	return &fofv1.UpdateLocationResponse{
		NewlyCleared:       newlyCleared,
		ClearedAreaGeojson: geoJSON,
	}, nil
}

func (h *FlavorHandler) GetNearbyShops(ctx context.Context, req *fofv1.GetNearbyShopsRequest) (*fofv1.GetNearbyShopsResponse, error) {
	shops, err := h.flavorUsecase.GetNearbyShops(ctx, req.Lat, req.Lng, req.RadiusMeters, req.ExclusiveIndependent)
	if err != nil {
		return nil, err
	}

	// For MVP, hardcode user ID
	userID := "24e7e8ae-c205-4dba-b42d-f6294db20e9e"
	visitedShops, _ := h.flavorUsecase.GetVisitedShops(ctx, userID)
	visitedMap := make(map[string]bool)
	for _, vs := range visitedShops {
		visitedMap[vs.ID.String()] = true
	}

	pbShops := make([]*fofv1.Shop, len(shops))
	for i, s := range shops {
		pbShops[i] = &fofv1.Shop{
			Id:           s.ID.String(),
			Name:         s.Name,
			Lat:          s.Lat,
			Lng:          s.Lng,
			Category:     s.Category,
			IsChain:      s.IsChain,
			Address:      s.Address,
			Phone:        s.Phone,
			OpeningHours: s.OpeningHours,
			ImageUrls:    s.ImageURLs,
			Rating:       s.Rating,
			SourceUrl:    s.SourceURL,
			IsVisited:    visitedMap[s.ID.String()],
		}
	}

	return &fofv1.GetNearbyShopsResponse{
		Shops: pbShops,
	}, nil
}

func (h *FlavorHandler) GetVisitedShops(ctx context.Context, req *fofv1.GetVisitedShopsRequest) (*fofv1.GetVisitedShopsResponse, error) {
	userID := "24e7e8ae-c205-4dba-b42d-f6294db20e9e"
	shops, err := h.flavorUsecase.GetVisitedShops(ctx, userID)
	if err != nil {
		return nil, err
	}

	pbShops := make([]*fofv1.Shop, len(shops))
	for i, s := range shops {
		pbShops[i] = &fofv1.Shop{
			Id:           s.ID.String(),
			Name:         s.Name,
			Lat:          s.Lat,
			Lng:          s.Lng,
			Category:     s.Category,
			IsChain:      s.IsChain,
			Address:      s.Address,
			Phone:        s.Phone,
			OpeningHours: s.OpeningHours,
			ImageUrls:    s.ImageURLs,
			Rating:       s.Rating,
			SourceUrl:    s.SourceURL,
			IsVisited:    true,
		}
	}

	return &fofv1.GetVisitedShopsResponse{
		Shops: pbShops,
	}, nil
}

func (h *FlavorHandler) CreateVisit(ctx context.Context, req *fofv1.CreateVisitRequest) (*fofv1.CreateVisitResponse, error) {
	userID := "24e7e8ae-c205-4dba-b42d-f6294db20e9e"
	geoJSON, expGained, currentExp, currentLevel, err := h.flavorUsecase.CreateVisit(ctx, userID, req.ShopId, int(req.Rating), req.Comment)
	if err != nil {
		return nil, err
	}

	return &fofv1.CreateVisitResponse{
		Success:            true,
		ClearedAreaGeojson: geoJSON,
		ExpGained:          int32(expGained),
		CurrentExp:         int32(currentExp),
		CurrentLevel:       int32(currentLevel),
	}, nil
}

func (h *FlavorHandler) GetClearedArea(ctx context.Context, req *fofv1.GetClearedAreaRequest) (*fofv1.GetClearedAreaResponse, error) {
	userID := "24e7e8ae-c205-4dba-b42d-f6294db20e9e"
	geoJSON, err := h.flavorUsecase.GetClearedArea(ctx, userID)
	if err != nil {
		return nil, err
	}

	return &fofv1.GetClearedAreaResponse{
		ClearedAreaGeojson: geoJSON,
	}, nil
}

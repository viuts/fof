package handler

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type LocationHandler struct {
	fofv1.UnimplementedLocationServiceServer
	locationUC usecase.LocationUsecase
}

func NewLocationHandler(u usecase.LocationUsecase) *LocationHandler {
	return &LocationHandler{
		locationUC: u,
	}
}

func (h *LocationHandler) UpdateLocation(ctx context.Context, req *fofv1.UpdateLocationRequest) (*fofv1.UpdateLocationResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	err := h.locationUC.UpdateLocation(ctx, userID, req.Path)
	if err != nil {
		return nil, err
	}

	return &fofv1.UpdateLocationResponse{}, nil
}

func (h *LocationHandler) GetClearedArea(ctx context.Context, req *fofv1.GetClearedAreaRequest) (*fofv1.GetClearedAreaResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	geoJSON, area, worldCoverage, err := h.locationUC.GetClearedArea(ctx, userID, req.MinLat, req.MinLng, req.MaxLat, req.MaxLng)
	if err != nil {
		return nil, err
	}

	return &fofv1.GetClearedAreaResponse{
		ClearedAreaGeojson:      geoJSON,
		ClearedAreaMeters:       area,
		WorldCoveragePercentage: worldCoverage,
	}, nil
}

func (h *LocationHandler) GetFogStats(ctx context.Context, req *fofv1.GetFogStatsRequest) (*fofv1.GetFogStatsResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	_, area, worldCoverage, err := h.locationUC.GetClearedArea(ctx, userID, 0, 0, 0, 0)
	if err != nil {
		return nil, err
	}

	return &fofv1.GetFogStatsResponse{
		ClearedAreaMeters:       area,
		WorldCoveragePercentage: worldCoverage,
	}, nil
}

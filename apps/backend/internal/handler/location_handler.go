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

	newlyCleared, geoJSON, err := h.locationUC.UpdateLocation(ctx, userID, req.Path)
	if err != nil {
		return nil, err
	}

	return &fofv1.UpdateLocationResponse{
		NewlyCleared:       newlyCleared,
		ClearedAreaGeojson: geoJSON,
	}, nil
}

func (h *LocationHandler) GetClearedArea(ctx context.Context, req *fofv1.GetClearedAreaRequest) (*fofv1.GetClearedAreaResponse, error) {
	userID, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	geoJSON, err := h.locationUC.GetClearedArea(ctx, userID)
	if err != nil {
		return nil, err
	}

	return &fofv1.GetClearedAreaResponse{
		ClearedAreaGeojson: geoJSON,
	}, nil
}

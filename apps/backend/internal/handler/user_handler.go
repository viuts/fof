package handler

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/middleware"
	"github.com/viuts/fof/apps/backend/internal/repository"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type UserHandler struct {
	fofv1.UnimplementedUserServiceServer
	repo repository.UserRepository
}

func NewUserHandler(repo repository.UserRepository) *UserHandler {
	return &UserHandler{repo: repo}
}

func (h *UserHandler) GetProfile(ctx context.Context, req *fofv1.GetProfileRequest) (*fofv1.GetProfileResponse, error) {
	userIDStr, ok := ctx.Value(middleware.ContextKeyUserID).(string)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "user not authenticated")
	}

	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		return nil, status.Error(codes.InvalidArgument, "invalid user id")
	}

	user, err := h.repo.GetByID(ctx, userID)
	if err != nil {
		return nil, err
	}

	return &fofv1.GetProfileResponse{
		User: &fofv1.User{
			Id:           user.ID.String(),
			Username:     user.Username,
			Email:        user.Email,
			Level:        int32(user.Level),
			Exp:          int32(user.Exp),
			DisplayName:  user.DisplayName,
			ProfileImage: user.ProfileImage,
		},
	}, nil
}

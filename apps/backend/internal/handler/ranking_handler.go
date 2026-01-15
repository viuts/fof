package handler

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/usecase"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type RankingHandler struct {
	fofv1.UnimplementedRankingServiceServer
	rankingUC usecase.RankingUsecase
}

func NewRankingHandler(rankingUC usecase.RankingUsecase) *RankingHandler {
	return &RankingHandler{
		rankingUC: rankingUC,
	}
}

func (h *RankingHandler) GetAreaCoverageRanking(ctx context.Context, req *fofv1.GetRankingRequest) (*fofv1.GetRankingResponse, error) {
	entries, err := h.rankingUC.GetAreaCoverageRanking(ctx, int(req.Limit))
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}
	return toRankingResponse(entries), nil
}

func (h *RankingHandler) GetLevelRanking(ctx context.Context, req *fofv1.GetRankingRequest) (*fofv1.GetRankingResponse, error) {
	entries, err := h.rankingUC.GetLevelRanking(ctx, int(req.Limit))
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}
	return toRankingResponse(entries), nil
}

func (h *RankingHandler) GetVisitCountRanking(ctx context.Context, req *fofv1.GetRankingRequest) (*fofv1.GetRankingResponse, error) {
	entries, err := h.rankingUC.GetVisitCountRanking(ctx, int(req.Limit))
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}
	return toRankingResponse(entries), nil
}

func (h *RankingHandler) GetCategoryVisitRanking(ctx context.Context, req *fofv1.GetCategoryRankingRequest) (*fofv1.GetRankingResponse, error) {
	entries, err := h.rankingUC.GetCategoryVisitRanking(ctx, req.Category, int(req.Limit))
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}
	return toRankingResponse(entries), nil
}

func toRankingResponse(entries []domain.UserRankingEntry) *fofv1.GetRankingResponse {
	respEntries := make([]*fofv1.RankingEntry, len(entries))
	for i, e := range entries {
		respEntries[i] = &fofv1.RankingEntry{
			Rank:         int32(e.Rank),
			UserId:       e.ID.String(),
			Username:     e.Username,
			DisplayName:  e.DisplayName,
			ProfileImage: e.ProfileImage,
			Score:        e.Score,
			Level:        int32(e.Level),
		}
	}
	return &fofv1.GetRankingResponse{
		Entries: respEntries,
	}
}

package usecase

import (
	"context"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/internal/repository"
)

type RankingUsecase interface {
	GetAreaCoverageRanking(ctx context.Context, limit int) ([]domain.UserRankingEntry, error)
	GetLevelRanking(ctx context.Context, limit int) ([]domain.UserRankingEntry, error)
	GetVisitCountRanking(ctx context.Context, limit int) ([]domain.UserRankingEntry, error)
	GetCategoryVisitRanking(ctx context.Context, category string, limit int) ([]domain.UserRankingEntry, error)
}

type rankingUsecase struct {
	userRepo  repository.UserRepository
	visitRepo repository.VisitRepository
}

func NewRankingUsecase(u repository.UserRepository, v repository.VisitRepository) RankingUsecase {
	return &rankingUsecase{
		userRepo:  u,
		visitRepo: v,
	}
}

func (u *rankingUsecase) GetAreaCoverageRanking(ctx context.Context, limit int) ([]domain.UserRankingEntry, error) {
	if limit <= 0 {
		limit = 100
	}
	entries, err := u.userRepo.GetAreaCoverageRanking(ctx, limit)
	if err != nil {
		return nil, err
	}
	return assignRanks(entries), nil
}

func (u *rankingUsecase) GetLevelRanking(ctx context.Context, limit int) ([]domain.UserRankingEntry, error) {
	if limit <= 0 {
		limit = 100
	}
	entries, err := u.userRepo.GetLevelRanking(ctx, limit)
	if err != nil {
		return nil, err
	}
	// Level ranking is purely based on Level/Exp.
	// We might want to handle tie-breaking or just rely on SQL order.
	return assignRanks(entries), nil
}

func (u *rankingUsecase) GetVisitCountRanking(ctx context.Context, limit int) ([]domain.UserRankingEntry, error) {
	if limit <= 0 {
		limit = 100
	}
	entries, err := u.userRepo.GetVisitCountRanking(ctx, limit)
	if err != nil {
		return nil, err
	}
	return assignRanks(entries), nil
}

func (u *rankingUsecase) GetCategoryVisitRanking(ctx context.Context, category string, limit int) ([]domain.UserRankingEntry, error) {
	if limit <= 0 {
		limit = 100
	}
	entries, err := u.visitRepo.GetCategoryVisitRanking(ctx, category, limit)
	if err != nil {
		return nil, err
	}
	return assignRanks(entries), nil
}

func assignRanks(entries []domain.UserRankingEntry) []domain.UserRankingEntry {
	for i := range entries {
		entries[i].Rank = i + 1
	}
	return entries
}

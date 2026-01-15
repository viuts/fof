package repository

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

type VisitRepository interface {
	GetByUserID(ctx context.Context, userID uuid.UUID) ([]domain.Visit, error)
	GetByUserIDAndShopID(ctx context.Context, userID uuid.UUID, shopID uuid.UUID) (*domain.Visit, error)
	CreateWithTx(ctx context.Context, tx *gorm.DB, visit *domain.Visit) error
	Save(ctx context.Context, visit *domain.Visit) error
	GetDB() *gorm.DB
	GetCategoryVisitRanking(ctx context.Context, category string, limit int) ([]domain.UserRankingEntry, error)
}

type visitRepository struct {
	db *gorm.DB
}

func NewVisitRepository(db *gorm.DB) VisitRepository {
	return &visitRepository{db: db}
}

func (r *visitRepository) GetByUserID(ctx context.Context, userID uuid.UUID) ([]domain.Visit, error) {
	var visits []domain.Visit
	err := r.db.WithContext(ctx).Preload("Shop").
		Where("user_id = ?", userID).
		Order("visited_at DESC").
		Find(&visits).Error
	return visits, err
}

func (r *visitRepository) GetByUserIDAndShopID(ctx context.Context, userID uuid.UUID, shopID uuid.UUID) (*domain.Visit, error) {
	var visit domain.Visit
	err := r.db.WithContext(ctx).
		Where("user_id = ? AND shop_id = ?", userID, shopID).
		First(&visit).Error
	if err != nil {
		return nil, err
	}
	return &visit, nil
}

func (r *visitRepository) CreateWithTx(ctx context.Context, tx *gorm.DB, visit *domain.Visit) error {
	return tx.WithContext(ctx).Create(visit).Error
}

func (r *visitRepository) Save(ctx context.Context, visit *domain.Visit) error {
	return r.db.WithContext(ctx).Save(visit).Error
}

func (r *visitRepository) GetDB() *gorm.DB {
	return r.db
}

func (r *visitRepository) GetCategoryVisitRanking(ctx context.Context, category string, limit int) ([]domain.UserRankingEntry, error) {
	var results []domain.UserRankingEntry
	err := r.db.WithContext(ctx).
		Table("users").
		Select("users.*, COUNT(DISTINCT visits.shop_id) as score").
		Joins("JOIN visits ON users.id = visits.user_id").
		Joins("JOIN shops ON visits.shop_id = shops.id").
		Where("users.deleted_at IS NULL AND shops.category = ?", category).
		Group("users.id").
		Order("score DESC").
		Limit(limit).
		Scan(&results).Error
	return results, err
}

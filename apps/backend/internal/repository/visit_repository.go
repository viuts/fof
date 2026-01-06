package repository

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

type VisitRepository interface {
	GetByUserID(ctx context.Context, userID uuid.UUID) ([]domain.Visit, error)
	CreateWithTx(ctx context.Context, tx *gorm.DB, visit *domain.Visit) error
	GetDB() *gorm.DB
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

func (r *visitRepository) CreateWithTx(ctx context.Context, tx *gorm.DB, visit *domain.Visit) error {
	return tx.WithContext(ctx).Create(visit).Error
}

func (r *visitRepository) GetDB() *gorm.DB {
	return r.db
}

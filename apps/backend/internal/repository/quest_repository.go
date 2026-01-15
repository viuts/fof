package repository

import (
	"context"
	"errors"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
)

type QuestRepository interface {
	Create(ctx context.Context, quest *domain.Quest) error
	Update(ctx context.Context, quest *domain.Quest) error
	FindByID(ctx context.Context, questID uuid.UUID) (*domain.Quest, error)
	FindActiveByUserID(ctx context.Context, userID uuid.UUID) (*domain.Quest, error)
	FindByUserID(ctx context.Context, userID uuid.UUID, limit, offset int) ([]domain.Quest, error)
	CountByUserID(ctx context.Context, userID uuid.UUID) (int64, error)
}

type questRepository struct {
	db *gorm.DB
}

func NewQuestRepository(db *gorm.DB) QuestRepository {
	return &questRepository{db: db}
}

func (r *questRepository) Create(ctx context.Context, quest *domain.Quest) error {
	return r.db.WithContext(ctx).Create(quest).Error
}

func (r *questRepository) Update(ctx context.Context, quest *domain.Quest) error {
	return r.db.WithContext(ctx).Save(quest).Error
}

func (r *questRepository) FindByID(ctx context.Context, questID uuid.UUID) (*domain.Quest, error) {
	var quest domain.Quest
	err := r.db.WithContext(ctx).
		Preload("Shop").
		Preload("User").
		Where("id = ?", questID).
		First(&quest).Error
	if err != nil {
		return nil, err
	}
	return &quest, nil
}

func (r *questRepository) FindActiveByUserID(ctx context.Context, userID uuid.UUID) (*domain.Quest, error) {
	var quest domain.Quest
	err := r.db.WithContext(ctx).
		Preload("Shop").
		Preload("User").
		Where("user_id = ? AND status = ?", userID, domain.QuestStatusActive).
		Order("created_at DESC").
		First(&quest).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &quest, nil
}

func (r *questRepository) FindByUserID(ctx context.Context, userID uuid.UUID, limit, offset int) ([]domain.Quest, error) {
	var quests []domain.Quest
	err := r.db.WithContext(ctx).
		Preload("Shop").
		Preload("User").
		Where("user_id = ?", userID).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&quests).Error
	return quests, err
}

func (r *questRepository) CountByUserID(ctx context.Context, userID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.WithContext(ctx).
		Model(&domain.Quest{}).
		Where("user_id = ?", userID).
		Count(&count).Error
	return count, err
}

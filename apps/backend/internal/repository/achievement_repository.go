package repository

import (
	"context"

	"github.com/google/uuid"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type AchievementRepository interface {
	GetAll(ctx context.Context) ([]domain.Achievement, error)
	GetUserProgress(ctx context.Context, userID uuid.UUID) ([]domain.UserAchievement, error)
	SaveUserProgress(ctx context.Context, progress *domain.UserAchievement) error
	GetUnlockedAchievements(ctx context.Context, userID uuid.UUID) ([]domain.Achievement, error)
}

type achievementRepository struct {
	db *gorm.DB
}

func NewAchievementRepository(db *gorm.DB) AchievementRepository {
	return &achievementRepository{db: db}
}

func (r *achievementRepository) GetAll(ctx context.Context) ([]domain.Achievement, error) {
	var achievements []domain.Achievement
	result := r.db.WithContext(ctx).Find(&achievements)
	return achievements, result.Error
}

func (r *achievementRepository) GetUserProgress(ctx context.Context, userID uuid.UUID) ([]domain.UserAchievement, error) {
	var userAchievements []domain.UserAchievement
	result := r.db.WithContext(ctx).Where("user_id = ?", userID).Find(&userAchievements)
	return userAchievements, result.Error
}

func (r *achievementRepository) SaveUserProgress(ctx context.Context, progress *domain.UserAchievement) error {
	return r.db.WithContext(ctx).Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "user_id"}, {Name: "achievement_id"}},
		UpdateAll: true,
	}).Create(progress).Error
}

func (r *achievementRepository) GetUnlockedAchievements(ctx context.Context, userID uuid.UUID) ([]domain.Achievement, error) {
	var achievements []domain.Achievement
	// Join with user_achievements where unlocked = true
	err := r.db.WithContext(ctx).
		Joins("JOIN user_achievements ON user_achievements.achievement_id = achievements.id").
		Where("user_achievements.user_id = ? AND user_achievements.is_unlocked = ?", userID, true).
		Find(&achievements).Error
	return achievements, err
}

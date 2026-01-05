package domain

import (
	"time"

	"github.com/google/uuid"
)

type AchievementType string

const (
	AchievementTypeCount      AchievementType = "COUNT"      // Simple counter (e.g. 10 visits)
	AchievementTypeStreak     AchievementType = "STREAK"     // Consecutive actions
	AchievementTypeCollection AchievementType = "COLLECTION" // Set of unique items (e.g. 5 categories)
	AchievementTypeCondition  AchievementType = "CONDITION"  // Complex logic (e.g. specific radius, time)
)

type Achievement struct {
	ID          string `gorm:"primaryKey"` // e.g. "ramen_lover_1"
	Name        string `gorm:"not null"`
	Description string
	Category    string // "EXPLORATION", "FOODIE", "QUEST", "SOCIAL"

	// Logic
	Type            AchievementType
	TargetValue     int    // e.g. 10
	ConditionConfig []byte `gorm:"type:jsonb"` // Flexible params: {"category": "RAMEN", "time_start": "00:00"}

	// Rewards
	ExpReward   int
	TitleReward string

	CreatedAt time.Time
	UpdatedAt time.Time
}

type UserAchievement struct {
	UserID        uuid.UUID `gorm:"type:uuid;primaryKey"`
	AchievementID string    `gorm:"primaryKey"`

	CurrentValue int // Current progress
	IsUnlocked   bool
	UnlockedAt   *time.Time

	Metadata []byte `gorm:"type:jsonb"` // Store state like {"last_streak_date": "..."}

	CreatedAt time.Time
	UpdatedAt time.Time
}

type UserAchievementComposite struct {
	Achievement Achievement
	Progress    *UserAchievement
}

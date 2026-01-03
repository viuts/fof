package domain

import (
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
	"gorm.io/gorm"
)

type User struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	Username  string    `gorm:"uniqueIndex;not null"`
	Email     string    `gorm:"uniqueIndex;not null"`
	Level     int       `gorm:"default:1"`
	Exp       int       `gorm:"default:0"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt `gorm:"index"`
}

type Shop struct {
	ID           uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	Name         string    `gorm:"not null"`
	Category     string
	Lat          float64 `gorm:"not null"`
	Lng          float64 `gorm:"not null"`
	IsChain      bool    `gorm:"default:false"`
	SourceID     string  `gorm:"index"`
	Geom         *string `gorm:"type:geometry(Point,4326)"` // PostGIS Point
	Address      string
	Phone        string
	OpeningHours string
	ImageURLs    pq.StringArray `gorm:"type:text[];column:image_urls"`
	Rating       float64
	SourceURL    string  `gorm:"uniqueIndex;column:source_url"`
	ClearanceRadius float64 `gorm:"column:clearance_radius"`
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

type Visit struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	UserID    uuid.UUID `gorm:"type:uuid;index;not null"`
	ShopID    uuid.UUID `gorm:"type:uuid;index;not null"`
	VisitedAt time.Time `gorm:"not null"`
	Rating    int
	Comment   string
	Exp       int
	User      User `gorm:"foreignKey:UserID"`
	Shop      Shop `gorm:"foreignKey:ShopID"`
}

type UserFog struct {
	UserID      uuid.UUID `gorm:"type:uuid;primaryKey"`
	ClearedArea *string   `gorm:"type:geometry(MultiPolygon,4326)"`
	UpdatedAt   time.Time
}

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

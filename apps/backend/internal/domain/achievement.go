package domain

import (
	"encoding/json"
	"strings"
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

type AchievementTier string

const (
	AchievementTierBronze   AchievementTier = "BRONZE"
	AchievementTierSilver   AchievementTier = "SILVER"
	AchievementTierGold     AchievementTier = "GOLD"
	AchievementTierPlatinum AchievementTier = "PLATINUM"
)

type EventType string

const (
	EventTypeVisit EventType = "VISIT"
)

type AchievementContext struct {
	ShopID    string
	Rating    int
	Category  string
	IsChain   bool
	DayOfWeek int
	Hour      int
}

type AchievementCategory string

const (
	AchievementCategoryExploration AchievementCategory = "EXPLORATION"
	AchievementCategoryFoodie      AchievementCategory = "FOODIE"
	AchievementCategoryQuest       AchievementCategory = "QUEST"
)

type Achievement struct {
	ID          string `gorm:"primaryKey"` // e.g. "ramen_lover_1"
	Name        string `gorm:"not null"`
	Description string
	Category    AchievementCategory // "EXPLORATION", "FOODIE", "QUEST", "SOCIAL"
	Tier        AchievementTier

	// Logic
	Type            AchievementType
	TargetValue     int    // e.g. 10
	ConditionConfig []byte `gorm:"type:jsonb"` // Flexible params: {"category": "RAMEN", "time_start": "00:00"}

	// Rewards
	ExpReward int

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

// Typed configuration structs for achievement conditions

// CountAchievementConfig contains filters for count-based achievements
type CountAchievementConfig struct {
	Category  string `json:"category,omitempty"`   // e.g. "RAMEN"
	Indie     bool   `json:"indie,omitempty"`      // Filter for indie shops only
	Chain     bool   `json:"chain,omitempty"`      // Filter for chain shops only
	Days      []int  `json:"days,omitempty"`       // Day of week filter (0=Sunday, 6=Saturday)
	HourStart int    `json:"hour_start,omitempty"` // Hour range start (0-23)
	HourEnd   int    `json:"hour_end,omitempty"`   // Hour range end (0-23)
}

// CollectionAchievementConfig contains filters for collection-based achievements
type CollectionAchievementConfig struct {
	UniqueCategory bool `json:"unique_category,omitempty"` // Track unique categories
}

// ConditionAchievementConfig contains filters for condition-based achievements
type ConditionAchievementConfig struct {
	Days      []int `json:"days,omitempty"`       // Day of week filter (0=Sunday, 6=Saturday)
	HourStart int   `json:"hour_start,omitempty"` // Hour range start (0-23)
	HourEnd   int   `json:"hour_end,omitempty"`   // Hour range end (0-23)
}

// Evaluate checks conditions and updates progress. Returns true if the achievement is now unlocked.
func (a *Achievement) Evaluate(p *UserAchievement, eventType EventType, achCtx AchievementContext) bool {
	if eventType != EventTypeVisit {
		return false
	}

	isNowUnlocked := false

	switch a.Type {
	case AchievementTypeCount:
		if a.checkCountConditions(achCtx) {
			p.CurrentValue++
			if p.CurrentValue >= a.TargetValue {
				isNowUnlocked = true
			}
		}

	case AchievementTypeCollection:
		var config CollectionAchievementConfig
		if len(a.ConditionConfig) > 0 {
			_ = json.Unmarshal(a.ConditionConfig, &config)
		}

		if config.UniqueCategory {
			if achCtx.Category != "" {
				var tracked []string
				if len(p.Metadata) > 0 {
					_ = json.Unmarshal(p.Metadata, &tracked)
				}

				isNew := true
				for _, t := range tracked {
					if strings.EqualFold(t, achCtx.Category) {
						isNew = false
						break
					}
				}

				if isNew {
					tracked = append(tracked, achCtx.Category)
					p.Metadata, _ = json.Marshal(tracked)
					p.CurrentValue = len(tracked)
					if p.CurrentValue >= a.TargetValue {
						isNowUnlocked = true
					}
				}
			}
		}

	case AchievementTypeCondition:
		if a.checkConditionConditions(achCtx) {
			p.CurrentValue++
			if p.CurrentValue >= a.TargetValue {
				isNowUnlocked = true
			}
		}
	}

	return isNowUnlocked
}

func (a *Achievement) checkCountConditions(achCtx AchievementContext) bool {
	var config CountAchievementConfig
	if len(a.ConditionConfig) > 0 {
		_ = json.Unmarshal(a.ConditionConfig, &config)
	}

	// Category filter
	if config.Category != "" {
		if !strings.EqualFold(achCtx.Category, config.Category) {
			return false
		}
	}

	// Indie filter
	if config.Indie {
		if achCtx.IsChain {
			return false
		}
	}

	// Chain filter
	if config.Chain {
		if !achCtx.IsChain {
			return false
		}
	}

	// Day of week filter
	if len(config.Days) > 0 {
		dayMatch := false
		for _, d := range config.Days {
			if d == achCtx.DayOfWeek {
				dayMatch = true
				break
			}
		}
		if !dayMatch {
			return false
		}
	}

	// Hour range filter
	if config.HourStart != 0 || config.HourEnd != 0 {
		if achCtx.Hour < config.HourStart || achCtx.Hour > config.HourEnd {
			return false
		}
	}

	return true
}

func (a *Achievement) checkConditionConditions(achCtx AchievementContext) bool {
	var config ConditionAchievementConfig
	if len(a.ConditionConfig) > 0 {
		_ = json.Unmarshal(a.ConditionConfig, &config)
	}

	// Day of week filter
	if len(config.Days) > 0 {
		dayMatch := false
		for _, d := range config.Days {
			if d == achCtx.DayOfWeek {
				dayMatch = true
				break
			}
		}
		if !dayMatch {
			return false
		}
	}

	// Hour range filter
	if config.HourStart != 0 || config.HourEnd != 0 {
		if achCtx.Hour < config.HourStart || achCtx.Hour > config.HourEnd {
			return false
		}
	}

	return true
}

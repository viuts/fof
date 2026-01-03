package seeds

import (
	"log"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func SeedAchievements(db *gorm.DB) {
	achievements := []domain.Achievement{
		{
			ID:          "first_steps",
			Name:        "First Steps",
			Description: "Visit your first shop.",
			Category:    "EXPLORATION",
			Type:        domain.AchievementTypeCount,
			TargetValue: 1,
			ConditionConfig: []byte(`{}`), 
			ExpReward:   50,
			TitleReward: "Beginner Explorer",
		},
		{
			ID:          "ramen_fan",
			Name:        "Ramen Fan",
			Description: "Visit 3 Ramen shops.",
			Category:    "FOODIE",
			Type:        domain.AchievementTypeCount,
			TargetValue: 3,
			ConditionConfig: []byte(`{"category": "RAMEN"}`),
			ExpReward:   150,
			TitleReward: "Noodle Lover",
		},
		{
			ID:          "chain_breaker",
			Name:        "Chain-Breaker",
			Description: "Visit 10 Independent (non-chain) shops.", 
			Category:    "FOODIE",
			Type:        domain.AchievementTypeCount, // Simplified from Streak for now
			TargetValue: 10,
			ConditionConfig: []byte(`{"indie": true}`),
			ExpReward:   300,
			TitleReward: "Local Hero",
		},
		{
			ID:          "light_bringer",
			Name:        "Light-Bringer",
			Description: "Trigger 50 'Dining Blasts' (Shop visits).",
			Category:    "EXPLORATION",
			Type:        domain.AchievementTypeCount,
			TargetValue: 50,
			ConditionConfig: []byte(`{}`),
			ExpReward:   1000,
			TitleReward: "The Beacon",
		},
		{
			ID:          "cuisine_alchemist",
			Name:        "Cuisine Alchemist",
			Description: "Visit one shop from 5 different categories.",
			Category:    "FOODIE",
			Type:        domain.AchievementTypeCollection,
			TargetValue: 5,
			ConditionConfig: []byte(`{"unique_category": true}`),
			ExpReward:   500,
			TitleReward: "Tastemaker",
		},
		{
			ID:          "night_owl",
			Name:        "Midnight Snack",
			Description: "Visit a shop between 12:00 AM and 4:00 AM.",
			Category:    "QUEST",
			Type:        domain.AchievementTypeCondition,
			TargetValue: 1,
			ConditionConfig: []byte(`{"time_start": "00:00", "time_end": "04:00"}`),
			ExpReward:   200,
			TitleReward: "Night Walker",
		},
	}

	for _, a := range achievements {
		// Use OnConflict to update existing definitions if they change
		if err := db.Clauses(clause.OnConflict{
			Columns:   []clause.Column{{Name: "id"}},
			UpdateAll: true,
		}).Create(&a).Error; err != nil {
			log.Printf("Failed to seed achievement %s: %v", a.ID, err)
		}
	}
	log.Println("Seeded achievements successfully")
}

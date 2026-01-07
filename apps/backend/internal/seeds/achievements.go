package seeds

import (
	"log"

	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func SeedAchievements(db *gorm.DB) {
	achievements := []domain.Achievement{
		// --- EXPLORATION ---
		{
			ID:              "first_steps",
			Name:            "First Steps",
			Description:     "Visit your first shop.",
			Category:        "EXPLORATION",
			Tier:            domain.AchievementTierBronze,
			Type:            domain.AchievementTypeCount,
			TargetValue:     1,
			ConditionConfig: []byte(`{}`),
			ExpReward:       100,
			TitleReward:     "Beginner Explorer",
		},
		{
			ID:              "light_bringer",
			Name:            "Light-Bringer",
			Description:     "Trigger 50 'Dining Blasts' (Shop visits).",
			Category:        "EXPLORATION",
			Tier:            domain.AchievementTierGold,
			Type:            domain.AchievementTypeCount,
			TargetValue:     50,
			ConditionConfig: []byte(`{}`),
			ExpReward:       1500,
			TitleReward:     "The Beacon",
		},
		{
			ID:              "fog_runner",
			Name:            "Fog Runner",
			Description:     "Visit 10 different shops.",
			Category:        "EXPLORATION",
			Tier:            domain.AchievementTierSilver,
			Type:            domain.AchievementTypeCount,
			TargetValue:     10,
			ConditionConfig: []byte(`{}`),
			ExpReward:       500,
			TitleReward:     "Pathfinder",
		},
		{
			ID:              "legendary_explorer",
			Name:            "Legendary Explorer",
			Description:     "Visit 200 different shops.",
			Category:        "EXPLORATION",
			Tier:            domain.AchievementTierPlatinum,
			Type:            domain.AchievementTypeCount,
			TargetValue:     200,
			ConditionConfig: []byte(`{}`),
			ExpReward:       5000,
			TitleReward:     "World Wanderer",
		},

		// --- FOODIE ---
		{
			ID:              "ramen_fan",
			Name:            "Ramen Fan",
			Description:     "Visit 3 Ramen shops.",
			Category:        "FOODIE",
			Tier:            domain.AchievementTierBronze,
			Type:            domain.AchievementTypeCount,
			TargetValue:     3,
			ConditionConfig: []byte(`{"category": "RAMEN"}`),
			ExpReward:       200,
			TitleReward:     "Noodle Lover",
		},
		{
			ID:              "ramen_master",
			Name:            "Ramen Master",
			Description:     "Visit 15 Ramen shops.",
			Category:        "FOODIE",
			Tier:            domain.AchievementTierGold,
			Type:            domain.AchievementTypeCount,
			TargetValue:     15,
			ConditionConfig: []byte(`{"category": "RAMEN"}`),
			ExpReward:       1500,
			TitleReward:     "Ramen Senpei",
		},
		{
			ID:              "cuisine_alchemist",
			Name:            "Cuisine Alchemist",
			Description:     "Visit one shop from 5 different categories.",
			Category:        "FOODIE",
			Tier:            domain.AchievementTierSilver,
			Type:            domain.AchievementTypeCollection,
			TargetValue:     5,
			ConditionConfig: []byte(`{"unique_category": true}`),
			ExpReward:       600,
			TitleReward:     "Tastemaker",
		},
		{
			ID:              "gourmet_king",
			Name:            "Gourmet King",
			Description:     "Visit one shop from 15 different categories.",
			Category:        "FOODIE",
			Tier:            domain.AchievementTierGold,
			Type:            domain.AchievementTypeCollection,
			TargetValue:     15,
			ConditionConfig: []byte(`{"unique_category": true}`),
			ExpReward:       2000,
			TitleReward:     "Connoisseur",
		},
		{
			ID:              "chain_breaker",
			Name:            "Chain-Breaker",
			Description:     "Visit 10 Independent (non-chain) shops.",
			Category:        "FOODIE",
			Tier:            domain.AchievementTierSilver,
			Type:            domain.AchievementTypeCount,
			TargetValue:     10,
			ConditionConfig: []byte(`{"indie": true}`),
			ExpReward:       800,
			TitleReward:     "Local Hero",
		},

		// --- QUEST / SPECIAL ---
		{
			ID:              "midnight_snack",
			Name:            "Midnight Snack",
			Description:     "Visit a shop between 12:00 AM and 4:00 AM.",
			Category:        "QUEST",
			Tier:            domain.AchievementTierBronze,
			Type:            domain.AchievementTypeCondition,
			TargetValue:     1,
			ConditionConfig: []byte(`{"hour_start": 0, "hour_end": 4}`),
			ExpReward:       300,
			TitleReward:     "Night Walker",
		},
		{
			ID:              "morning_bird",
			Name:            "Morning Bird",
			Description:     "Visit a shop between 6:00 AM and 9:00 AM.",
			Category:        "QUEST",
			Tier:            domain.AchievementTierBronze,
			Type:            domain.AchievementTypeCondition,
			TargetValue:     1,
			ConditionConfig: []byte(`{"hour_start": 6, "hour_end": 9}`),
			ExpReward:       300,
			TitleReward:     "Early Riser",
		},
		{
			ID:              "weekend_warrior",
			Name:            "Weekend Warrior",
			Description:     "Visit 5 shops on weekends.",
			Category:        "QUEST",
			Tier:            domain.AchievementTierSilver,
			Type:            domain.AchievementTypeCount,
			TargetValue:     5,
			ConditionConfig: []byte(`{"days": [0, 6]}`), // Sunday, Saturday
			ExpReward:       700,
			TitleReward:     "Holiday Hobbyist",
		},
	}

	for _, a := range achievements {
		if err := db.Clauses(clause.OnConflict{
			Columns:   []clause.Column{{Name: "id"}},
			UpdateAll: true,
		}).Create(&a).Error; err != nil {
			log.Printf("Failed to seed achievement %s: %v", a.ID, err)
		}
	}
	log.Println("Seeded achievements successfully")
}

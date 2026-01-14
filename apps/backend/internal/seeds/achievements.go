package seeds

import (
	"encoding/json"
	"log"

	"github.com/viuts/fof/apps/backend/internal/domain"
	pb "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func mustMarshal(v any) []byte {
	b, err := json.Marshal(v)
	if err != nil {
		panic(err)
	}
	return b
}

func SeedAchievements(db *gorm.DB) {
	achievements := []domain.Achievement{
		// --- EXPLORATION (Total Visits) ---
		{ID: "first_steps", Name: "First Steps", Description: "Visit your first shop.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 1, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 100},
		{ID: "explorer_lv1", Name: "Explorer Lv.1", Description: "Visit 5 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 5, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 300},
		{ID: "fog_runner", Name: "Fog Runner", Description: "Visit 10 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 500},
		{ID: "explorer_lv2", Name: "Explorer Lv.2", Description: "Visit 25 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 25, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 1000},
		{ID: "light_bringer", Name: "Light-Bringer", Description: "Visit 50 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 50, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 1500},
		{ID: "explorer_lv3", Name: "Explorer Lv.3", Description: "Visit 100 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 100, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 2500},
		{ID: "legendary_explorer", Name: "Legendary Explorer", Description: "Visit 200 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierPlatinum, Type: domain.AchievementTypeCount, TargetValue: 200, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 5000},
		{ID: "master_explorer", Name: "Master Explorer", Description: "Visit 500 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierPlatinum, Type: domain.AchievementTypeCount, TargetValue: 500, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 10000},
		{ID: "god_of_walk", Name: "God of Walk", Description: "Visit 1000 different shops.", Category: domain.AchievementCategoryExploration, Tier: domain.AchievementTierPlatinum, Type: domain.AchievementTypeCount, TargetValue: 1000, ConditionConfig: mustMarshal(domain.CountAchievementConfig{}), ExpReward: 25000},

		// --- FOODIE: RAMEN ---
		{ID: "ramen_fan", Name: "Ramen Fan", Description: "Visit 3 Ramen shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_RAMEN.String()}), ExpReward: 200},
		{ID: "ramen_lover", Name: "Ramen Lover", Description: "Visit 10 Ramen shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_RAMEN.String()}), ExpReward: 600},
		{ID: "ramen_master", Name: "Ramen Master", Description: "Visit 30 Ramen shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_RAMEN.String()}), ExpReward: 2000},
		{ID: "ramen_god", Name: "Ramen God", Description: "Visit 50 Ramen shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierPlatinum, Type: domain.AchievementTypeCount, TargetValue: 50, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_RAMEN.String()}), ExpReward: 5000},

		// --- FOODIE: CAFE ---
		{ID: "cafe_fan", Name: "Cafe Fan", Description: "Visit 3 Cafes.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CAFE.String()}), ExpReward: 150},
		{ID: "cafe_lover", Name: "Cafe Lover", Description: "Visit 10 Cafes.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CAFE.String()}), ExpReward: 500},
		{ID: "cafe_master", Name: "Cafe Master", Description: "Visit 30 Cafes.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CAFE.String()}), ExpReward: 1500},

		// --- FOODIE: SUSHI ---
		{ID: "sushi_fan", Name: "Sushi Fan", Description: "Visit 3 Sushi shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_SUSHI.String()}), ExpReward: 250},
		{ID: "sushi_lover", Name: "Sushi Lover", Description: "Visit 10 Sushi shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_SUSHI.String()}), ExpReward: 800},
		{ID: "sushi_master", Name: "Sushi Master", Description: "Visit 30 Sushi shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_SUSHI.String()}), ExpReward: 2500},

		// --- FOODIE: YAKINIKU (BBQ) ---
		{ID: "yakiniku_fan", Name: "Yakiniku Fan", Description: "Visit 3 Yakiniku shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_YAKINIKU.String()}), ExpReward: 250},
		{ID: "yakiniku_lover", Name: "Yakiniku Lover", Description: "Visit 10 Yakiniku shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_YAKINIKU.String()}), ExpReward: 800},
		{ID: "yakiniku_master", Name: "Yakiniku Master", Description: "Visit 30 Yakiniku shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_YAKINIKU.String()}), ExpReward: 2500},

		// --- FOODIE: IZAKAYA (Pub) ---
		{ID: "izakaya_fan", Name: "Izakaya Fan", Description: "Visit 3 Izakayas.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_IZAKAYA.String()}), ExpReward: 200},
		{ID: "izakaya_lover", Name: "Izakaya Lover", Description: "Visit 10 Izakayas.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_IZAKAYA.String()}), ExpReward: 600},
		{ID: "izakaya_master", Name: "Izakaya Master", Description: "Visit 30 Izakayas.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_IZAKAYA.String()}), ExpReward: 2000},

		// --- FOODIE: BAR ---
		{ID: "bar_fan", Name: "Bar Fan", Description: "Visit 3 Bars.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_BAR.String()}), ExpReward: 200},
		{ID: "bar_lover", Name: "Bar Lover", Description: "Visit 10 Bars.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_BAR.String()}), ExpReward: 600},
		{ID: "bar_master", Name: "Bar Master", Description: "Visit 30 Bars.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_BAR.String()}), ExpReward: 2000},

		// --- FOODIE: SWEETS ---
		{ID: "sweets_fan", Name: "Sweets Fan", Description: "Visit 3 Sweets shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_SWEETS.String()}), ExpReward: 150},
		{ID: "sweets_lover", Name: "Sweets Lover", Description: "Visit 10 Sweets shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_SWEETS.String()}), ExpReward: 500},
		{ID: "sweets_master", Name: "Sweets Master", Description: "Visit 30 Sweets shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_SWEETS.String()}), ExpReward: 1500},

		// --- FOODIE: CURRY ---
		{ID: "curry_fan", Name: "Curry Fan", Description: "Visit 3 Curry shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CURRY.String()}), ExpReward: 200},
		{ID: "curry_lover", Name: "Curry Lover", Description: "Visit 10 Curry shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CURRY.String()}), ExpReward: 600},
		{ID: "curry_master", Name: "Curry Master", Description: "Visit 30 Curry shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CURRY.String()}), ExpReward: 2000},

		// --- FOODIE: ITALIAN / EUROPEAN ---
		{ID: "euro_fan", Name: "European Fan", Description: "Visit 3 European style shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_EUROPEAN.String()}), ExpReward: 200},
		{ID: "euro_lover", Name: "European Lover", Description: "Visit 10 European style shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_EUROPEAN.String()}), ExpReward: 600},
		{ID: "euro_master", Name: "European Master", Description: "Visit 30 European style shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_EUROPEAN.String()}), ExpReward: 2000},

		// --- FOODIE: CHINESE ---
		{ID: "chinese_fan", Name: "Chinese Fan", Description: "Visit 3 Chinese shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CHINESE.String()}), ExpReward: 200},
		{ID: "chinese_lover", Name: "Chinese Lover", Description: "Visit 10 Chinese shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CHINESE.String()}), ExpReward: 600},
		{ID: "chinese_master", Name: "Chinese Master", Description: "Visit 30 Chinese shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_CHINESE.String()}), ExpReward: 2000},

		// --- FOODIE: DON (Rice Bowl) ---
		{ID: "don_fan", Name: "Donburi Fan", Description: "Visit 3 Donburi (Rice Bowl) shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_DON.String()}), ExpReward: 150},
		{ID: "don_lover", Name: "Donburi Lover", Description: "Visit 10 Donburi shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_DON.String()}), ExpReward: 500},
		{ID: "don_master", Name: "Donburi Master", Description: "Visit 30 Donburi shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_DON.String()}), ExpReward: 1500},

		// --- FOODIE: WASHOKU (Japanese) ---
		{ID: "washoku_fan", Name: "Washoku Fan", Description: "Visit 3 Washoku shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_WASHOKU.String()}), ExpReward: 200},
		{ID: "washoku_lover", Name: "Washoku Lover", Description: "Visit 10 Washoku shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_WASHOKU.String()}), ExpReward: 600},
		{ID: "washoku_master", Name: "Washoku Master", Description: "Visit 30 Washoku shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_WASHOKU.String()}), ExpReward: 2000},

		// --- FOODIE: YAKITORI ---
		{ID: "yakitori_fan", Name: "Yakitori Fan", Description: "Visit 3 Yakitori shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 3, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_YAKITORI.String()}), ExpReward: 200},
		{ID: "yakitori_lover", Name: "Yakitori Lover", Description: "Visit 10 Yakitori shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_YAKITORI.String()}), ExpReward: 600},
		{ID: "yakitori_master", Name: "Yakitori Master", Description: "Visit 30 Yakitori shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 30, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Category: pb.FoodCategory_FOOD_CATEGORY_YAKITORI.String()}), ExpReward: 2000},

		// --- DIVERSITY ---
		{ID: "cuisine_alchemist", Name: "Cuisine Alchemist", Description: "Visit one shop from 5 different categories.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCollection, TargetValue: 5, ConditionConfig: mustMarshal(domain.CollectionAchievementConfig{UniqueCategory: true}), ExpReward: 600},
		{ID: "gourmet_king", Name: "Gourmet King", Description: "Visit one shop from 15 different categories.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCollection, TargetValue: 15, ConditionConfig: mustMarshal(domain.CollectionAchievementConfig{UniqueCategory: true}), ExpReward: 2000},
		{ID: "omnivore", Name: "Omnivore", Description: "Visit one shop from 20 different categories.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierPlatinum, Type: domain.AchievementTypeCollection, TargetValue: 20, ConditionConfig: mustMarshal(domain.CollectionAchievementConfig{UniqueCategory: true}), ExpReward: 5000},

		// --- CHAIN vs INDIE ---
		{ID: "chain_breaker", Name: "Chain-Breaker", Description: "Visit 10 Independent (non-chain) shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Indie: true}), ExpReward: 800},
		{ID: "indie_spirit", Name: "Indie Spirit", Description: "Visit 50 Independent shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierGold, Type: domain.AchievementTypeCount, TargetValue: 50, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Indie: true}), ExpReward: 2500},
		{ID: "chain_lover", Name: "Chain Lover", Description: "Visit 10 Chain shops.", Category: domain.AchievementCategoryFoodie, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Chain: true}), ExpReward: 300},

		// --- QUEST / TIME BASED ---
		{ID: "morning_bird", Name: "Morning Bird", Description: "Visit a shop between 6:00 AM and 9:00 AM.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCondition, TargetValue: 1, ConditionConfig: mustMarshal(domain.ConditionAchievementConfig{HourStart: 6, HourEnd: 9}), ExpReward: 300},
		{ID: "lunch_rush", Name: "Lunch Rush", Description: "Visit a shop between 11:30 AM and 1:30 PM.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCondition, TargetValue: 1, ConditionConfig: mustMarshal(domain.ConditionAchievementConfig{HourStart: 11, HourEnd: 13}), ExpReward: 300},
		{ID: "afternoon_tea", Name: "Afternoon Tea", Description: "Visit a shop between 3:00 PM and 5:00 PM.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCondition, TargetValue: 1, ConditionConfig: mustMarshal(domain.ConditionAchievementConfig{HourStart: 15, HourEnd: 17}), ExpReward: 300},
		{ID: "dinner_time", Name: "Dinner Time", Description: "Visit a shop between 6:00 PM and 9:00 PM.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCondition, TargetValue: 1, ConditionConfig: mustMarshal(domain.ConditionAchievementConfig{HourStart: 18, HourEnd: 21}), ExpReward: 300},
		{ID: "midnight_snack", Name: "Midnight Snack", Description: "Visit a shop between 12:00 AM and 4:00 AM.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCondition, TargetValue: 1, ConditionConfig: mustMarshal(domain.ConditionAchievementConfig{HourStart: 0, HourEnd: 4}), ExpReward: 300},

		// --- DAYS ---
		{ID: "weekend_warrior", Name: "Weekend Warrior", Description: "Visit 5 shops on weekends.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 5, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Days: []int{0, 6}}), ExpReward: 700},
		{ID: "weekday_worker", Name: "Weekday Worker", Description: "Visit 10 shops on weekdays.", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierSilver, Type: domain.AchievementTypeCount, TargetValue: 10, ConditionConfig: mustMarshal(domain.CountAchievementConfig{Days: []int{1, 2, 3, 4, 5}}), ExpReward: 700},
		{ID: "friday_night", Name: "TGIF", Description: "Visit a shop on Friday night (after 6 PM).", Category: domain.AchievementCategoryQuest, Tier: domain.AchievementTierBronze, Type: domain.AchievementTypeCondition, TargetValue: 1, ConditionConfig: mustMarshal(domain.ConditionAchievementConfig{Days: []int{5}, HourStart: 18, HourEnd: 24}), ExpReward: 400},
	}

	if err := db.Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "id"}},
		UpdateAll: true,
	}).Create(achievements).Error; err != nil {
		log.Printf("Failed to seed achievements: %v", err)
	}
	log.Println("Seeded achievements successfully")
}

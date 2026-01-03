package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"

	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

func main() {
	conn, err := grpc.Dial("localhost:8080", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := fofv1.NewFlavorServiceClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), time.Second*30)
	defer cancel()

	// 1. Get initial state
	fmt.Println("Checking initial achievement status...")
	initialRes, _ := c.GetAchievements(ctx, &fofv1.GetAchievementsRequest{})
	
	getProgress := func(achID string) int32 {
		for _, a := range initialRes.Achievements {
			if a.Achievement.Id == achID {
				return a.CurrentValue
			}
		}
		return 0
	}

	chainBreakerInitial := getProgress("chain_breaker")
	cuisineAlchemistInitial := getProgress("cuisine_alchemist")
	
	fmt.Printf("Initial Chain-Breaker: %d, Cuisine Alchemist: %d\n", chainBreakerInitial, cuisineAlchemistInitial)

	// 2. Find a Chain shop and an Indie shop
	shops, _ := c.GetNearbyShops(ctx, &fofv1.GetNearbyShopsRequest{Lat: 35.6812, Lng: 139.7671, RadiusMeters: 5000})
	var chainShop, indieShop *fofv1.Shop
	for _, s := range shops.Shops {
		if s.IsChain && chainShop == nil {
			chainShop = s
		}
		if !s.IsChain && indieShop == nil {
			indieShop = s
		}
	}

	if chainShop != nil {
		fmt.Printf("\n[TEST] Visiting Chain Shop: %s. Chain-Breaker should NOT increment.\n", chainShop.Name)
		_, _ = c.CreateVisit(ctx, &fofv1.CreateVisitRequest{ShopId: chainShop.Id, Rating: 5})
	}
	if indieShop != nil {
		fmt.Printf("[TEST] Visiting Indie Shop: %s. Chain-Breaker SHOULD increment.\n", indieShop.Name)
		_, _ = c.CreateVisit(ctx, &fofv1.CreateVisitRequest{ShopId: indieShop.Id, Rating: 5})
	}

	// 3. Test Cuisine Alchemist with a new category
	// Find a shop with a category NOT in the current collection if possible
	// (Hard to do without knowing metadata from here, so we just visit a few different ones)
    fmt.Println("\n[TEST] Visiting 2 different categories for Cuisine Alchemist...")
	catCount := 0
	seenCats := make(map[string]bool)
	for _, s := range shops.Shops {
		if !seenCats[s.Category] {
			fmt.Printf("Visiting %s (%s)\n", s.Name, s.Category)
			_, _ = c.CreateVisit(ctx, &fofv1.CreateVisitRequest{ShopId: s.Id, Rating: 5})
			seenCats[s.Category] = true
			catCount++
			if catCount >= 2 { break }
		}
	}

	// 4. Final verification
	fmt.Println("\n--- FINAL VERIFICATION ---")
	finalRes, _ := c.GetAchievements(ctx, &fofv1.GetAchievementsRequest{})
	
	for _, a := range finalRes.Achievements {
		if a.Achievement.Id == "chain_breaker" {
			diff := a.CurrentValue - chainBreakerInitial
			fmt.Printf("Chain-Breaker: %d -> %d (Diff: %d). Expected diff: 1 if Indie visited.\n", chainBreakerInitial, a.CurrentValue, diff)
		}
		if a.Achievement.Id == "cuisine_alchemist" {
			diff := a.CurrentValue - cuisineAlchemistInitial
			fmt.Printf("Cuisine Alchemist: %d -> %d (Diff: %d). Expected diff: incremental based on unique categories visited.\n", cuisineAlchemistInitial, a.CurrentValue, diff)
		}
	}
}

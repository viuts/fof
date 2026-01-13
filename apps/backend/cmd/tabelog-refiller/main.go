package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"sync"

	"github.com/joho/godotenv"
	"github.com/playwright-community/playwright-go"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/pkg/crawler"
	"github.com/viuts/fof/apps/backend/pkg/crawler/tabelog"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const WorkerCount = 10

func main() {
	flag.Parse()

	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found, relying on environment variables")
	}

	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		log.Fatalf("DATABASE_URL is not set")
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("failed to connect database: %v", err)
	}

	pw, err := playwright.Run()
	if err != nil {
		log.Fatalf("could not start playwright: %v", err)
	}
	browser, err := pw.Chromium.Launch(playwright.BrowserTypeLaunchOptions{
		Headless: playwright.Bool(true),
	})
	if err != nil {
		log.Fatalf("could not launch browser: %v", err)
	}
	defer browser.Close()

	// Initialize Workers
	jobs := make(chan crawler.Job, 1000)
	shopsChan := make(chan *domain.Shop, 1000)
	var wg sync.WaitGroup

	for i := 0; i < WorkerCount; i++ {
		log.Printf("Initializing Worker %d...", i+1)
		context, err := browser.NewContext(playwright.BrowserNewContextOptions{
			Locale: playwright.String("ja-JP"),
			ExtraHttpHeaders: map[string]string{
				"Accept-Language": "ja-JP,ja;q=0.9",
			},
			UserAgent: playwright.String(fmt.Sprintf("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Worker/%d", i)),
		})
		if err != nil {
			log.Fatalf("could not create context for worker %d: %v", i, err)
		}

		context.Route("**/*", crawler.AdBlockRouteHandler)

		wg.Add(1)
		go worker(i+1, context, jobs, shopsChan, &wg)
	}

	// Batch Writer Goroutine
	writerDone := make(chan struct{})
	go func() {
		defer close(writerDone)
		var batch []*domain.Shop
		const batchSize = 50

		saveBatch := func() {
			if len(batch) == 0 {
				return
			}
			result := db.Clauses(clause.OnConflict{
				Columns:   []clause.Column{{Name: "source_url"}},
				DoUpdates: clause.AssignmentColumns([]string{"opening_hours", "rating", "review_count", "average_price", "reservable", "updated_at"}),
			}).Create(batch)
			if result.Error != nil {
				log.Printf("[Writer] Error saving batch: %v", result.Error)
			} else {
				log.Printf("[Writer] Successfully updated batch of %d shops", len(batch))
			}
			batch = nil
		}

		for shop := range shopsChan {
			batch = append(batch, shop)
			if len(batch) >= batchSize {
				saveBatch()
			}
		}
		saveBatch() // Save final batch
	}()

	// Manager Loop (Producer)
	go func() {
		defer close(jobs)

		log.Printf("[Producer] Fetching shops with missing opening hours from DB...")
		var shops []*domain.Shop
		// Find shops where opening_hours is null or empty JSON '{}'
		if err := db.Select("source_url").Where("opening_hours IS NULL OR opening_hours = '{}' OR opening_hours = 'null'::jsonb OR rating = 0 OR review_count = 0 OR average_price = 0").Find(&shops).Error; err != nil {
			log.Printf("[Producer] Error querying DB: %v", err)
			return
		}

		log.Printf("[Producer] Found %d shops to refill", len(shops))
		for _, s := range shops {
			if s.SourceURL != "" {
				jobs <- crawler.Job{URL: s.SourceURL}
			}
		}
	}()

	// Wait for workers to finish
	wg.Wait()
	close(shopsChan)
	<-writerDone

	log.Println("All jobs completed. Exiting.")
}

func worker(id int, ctx playwright.BrowserContext, jobs <-chan crawler.Job, shopsChan chan<- *domain.Shop, wg *sync.WaitGroup) {
	defer wg.Done()
	for job := range jobs {
		log.Printf("[Worker %d] Processing: %s", id, job.URL)
		shop, err := tabelog.CrawlShopDetail(ctx, job.URL)
		if err != nil {
			log.Printf("[Worker %d] Error crawling shop %s: %v", id, job.URL, err)
		} else {
			shopsChan <- shop
		}
	}
}

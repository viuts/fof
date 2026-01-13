package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
	"sync"
	"time"

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

var (
	categories = map[string]string{
		"japanese":     "japanese",
		"sushi":        "sushi",
		"seafood":      "seafood",
		"eel_anago":    "RC0105",
		"tempura":      "tempura",
		"tonkatsu_fry": "RC0125",
		"yakitori":     "RC0106",
		"sukiyaki":     "RC0107",
		"shabu_shabu":  "RC0121",
		"soba":         "RC0104",
		"udon":         "RC0123",
		"noodles":      "RC0124",
		"okonomiyaki":  "RC0109",
		"donburi":      "RC0111",
		"oden":         "RC0108",
		// "other":                "ZZ9999",
		"western":              "RC0209",
		"steak_teppanyaki":     "RC0201",
		"french":               "french",
		"italian":              "italian",
		"spain":                "spain",
		"european":             "RC0219",
		"american":             "RC0220",
		"chinese":              "RC0301",
		"sichuan":              "RC0305",
		"taiwanese":            "RC0306",
		"dim_sum":              "RC0307",
		"gyoza":                "gyouza",
		"meat_bun":             "RC0309",
		"xiao_long_bao":        "RC0310",
		"chinese_congee":       "RC0303",
		"asian_ethnic":         "RC0499",
		"korean":               "korea",
		"southeast_asian":      "RC0402",
		"south_asian":          "RC0403",
		"middle_eastern":       "RC0404",
		"latin_american":       "RC0411",
		"african":              "RC0412",
		"curry":                "RC1201",
		"indian_curry":         "RC1203",
		"soup_curry":           "RC1205",
		"yakiniku":             "yakiniku",
		"horumon":              "horumon",
		"genghis_khan":         "RC1302",
		"hot_pot":              "RC1408",
		"motsunabe":            "motsu",
		"mizutaki":             "RC1404",
		"chankonabe":           "RC1401",
		"huoguo":               "RC1406",
		"udonski":              "RC1402",
		"izakaya":              "izakaya",
		"dining_bar":           "RC2102",
		"standing_bar":         "RC2105",
		"bal":                  "RC2103",
		"beer_garden":          "RC2104",
		"restaurant":           "RC9801",
		"creative":             "RC9802",
		"organic":              "RC9803",
		"bento":                "RC9804",
		"meat_dishes":          "RC9805",
		"seafood_dishes":       "RC9806",
		"salad":                "RC9807",
		"cheese":               "RC9808",
		"garlic":               "RC9809",
		"buffet":               "viking",
		"bbq":                  "RC9811",
		"cruising":             "RC9812",
		"ramen":                "MC0101",
		"tsukemen":             "MC0130",
		"abura_soba":           "MC0131",
		"taiwan_mazesoba":      "MC0132",
		"dandan_noodles":       "MC0133",
		"soupless_dandan":      "MC0134",
		"knife_cut_noodles":    "MC0135",
		"cafe":                 "SC1001",
		"kissaten":             "kissaten",
		"kanmidokoro":          "SC1003",
		"fruit_parlor":         "SC1004",
		"pancakes":             "SC1005",
		"coffee_stand":         "SC1006",
		"tea_stand":            "SC1007",
		"juice_stand":          "SC1008",
		"tapioca":              "tapioca",
		"sweets":               "SC0210",
		"western_sweets":       "SC0201",
		"cake":                 "cake",
		"cream_puff":           "SC0213",
		"chocolate":            "SC0214",
		"doughnut":             "SC0215",
		"macaron":              "SC0216",
		"baumkuchen":           "SC0217",
		"pudding":              "SC0218",
		"crepe":                "SC0219",
		"japanese_sweets":      "SC0202",
		"daifuku":              "SC0221",
		"taiyaki":              "SC0222",
		"dorayaki":             "SC0223",
		"castella":             "SC0224",
		"roasted_sweet_potato": "SC0225",
		"rice_cracker":         "SC0226",
		"chinese_sweets":       "SC0203",
		"gelato":               "SC0228",
		"soft_serve":           "SC0229",
		"shaved_ice":           "SC0230",
		"bread":                "SC0101",
		"sandwich":             "SC0102",
		"bagel":                "SC0103",
		"bar":                  "BC0101",
		"pub":                  "BC0102",
		"wine_bar":             "BC0103",
		"beer_bar":             "BC0104",
		"sports_bar":           "BC0105",
		"sake_bar":             "BC0106",
		"shochu_bar":           "BC0107",
		"ryokan":               "ryokan",
		"auberge":              "YC0102",
	}
)

func main() {
	preference := flag.String("preference", "tokyo", "Preference (e.g. tokyo)")
	category := flag.String("category", "all", "Category (e.g. ramen)")
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
		const batchSize = 100

		saveBatch := func() {
			if len(batch) == 0 {
				return
			}
			result := db.Clauses(clause.OnConflict{
				Columns:   []clause.Column{{Name: "source_url"}},
				DoUpdates: clause.AssignmentColumns([]string{"name", "category", "lat", "lng", "geom", "address", "phone", "opening_hours", "image_urls", "rating", "review_count", "average_price", "reservable", "updated_at"}),
			}).Create(batch)
			if result.Error != nil {
				log.Printf("[Writer] Error saving batch: %v", result.Error)
			} else {
				log.Printf("[Writer] Successfully saved batch of %d shops", len(batch))
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

	// Determine categories to crawl
	var categoriesToCrawl []string
	if *category == "all" {
		for k := range categories {
			categoriesToCrawl = append(categoriesToCrawl, k)
		}
	} else {
		if _, ok := categories[*category]; !ok {
			log.Fatalf("Invalid category: %s", *category)
		}
		categoriesToCrawl = []string{*category}
	}

	producerPage, err := browser.NewPage(playwright.BrowserNewPageOptions{
		Locale: playwright.String("ja-JP"),
		ExtraHttpHeaders: map[string]string{
			"Accept-Language": "ja-JP,ja;q=0.9",
		},
		UserAgent: playwright.String("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Producer"),
	})
	if err != nil {
		log.Fatalf("could not create producer page: %v", err)
	}

	// Manager Loop (Producer)
	go func() {
		defer close(jobs)

		for _, catKey := range categoriesToCrawl {
			categoryBaseURL := fmt.Sprintf("https://tabelog.com/%s/rstLst/%s/?SrtT=nod&Srt=D", *preference, categories[catKey])

			log.Printf("[Producer] Starting category: %s (%s)", catKey, categoryBaseURL)

			if _, err := producerPage.Goto(categoryBaseURL, playwright.PageGotoOptions{
				WaitUntil: playwright.WaitUntilStateCommit,
				Timeout:   playwright.Float(60000),
			}); err != nil {
				log.Printf("[Producer] Error going to base URL %s: %v", categoryBaseURL, err)
				continue
			}

			// Handle language modal
			modalClose := producerPage.Locator(".js-modal-close, .p-lang-modal__btn-ja").First()
			if visible, _ := modalClose.IsVisible(); visible {
				modalClose.Click()
				time.Sleep(500 * time.Millisecond)
			}

			// Add a small delay till the page is fully loaded
			time.Sleep(1 * time.Second)

			// Extract sub-area URLs
			subAreaLinks, _ := producerPage.Locator("#tabs-panel-balloon-pref-area .list-balloon__list-item a").All()
			var areaURLs []string
			for _, link := range subAreaLinks {
				href, _ := link.GetAttribute("href")
				if href != "" && !strings.Contains(href, "javascript:") {
					if !strings.HasPrefix(href, "http") {
						href = "https://tabelog.com" + href
					}
					areaURLs = append(areaURLs, href)
				}
			}

			if len(areaURLs) == 0 {
				log.Printf("[Producer] No sub-areas found for %s, processing base URL only.", catKey)
				areaURLs = []string{categoryBaseURL}
			} else {
				log.Printf("[Producer] Found %d sub-areas for %s. Starting crawl loop...", len(areaURLs), catKey)
			}

			for _, areaURL := range areaURLs {
				currentPageURL := areaURL
				for {
					log.Printf("[Producer] [%s] Fetching page: %s", catKey, currentPageURL)
					if _, err := producerPage.Goto(currentPageURL, playwright.PageGotoOptions{
						WaitUntil: playwright.WaitUntilStateCommit,
						Timeout:   playwright.Float(60000),
					}); err != nil {
						log.Printf("[Producer] [%s] Error going to page %s: %v", catKey, currentPageURL, err)
						break
					}

					// Wait for results
					if _, err := producerPage.WaitForSelector(".list-rst__rst-name-target, .c-pagination", playwright.PageWaitForSelectorOptions{
						Timeout: playwright.Float(10000),
					}); err != nil {
						log.Printf("[Producer] [%s] Warning: selector not found on %s", catKey, currentPageURL)
					}

					// Extract shop URLs
					links, err := producerPage.Locator(".list-rst__rst-name-target").All()
					if err != nil {
						log.Printf("[Producer] [%s] Error getting links: %v", catKey, err)
						break
					}

					foundCount := 0
					for _, link := range links {
						href, _ := link.GetAttribute("href")
						if href != "" {
							jobs <- crawler.Job{URL: href}
							foundCount++
						}
					}
					log.Printf("[Producer] [%s] Queued %d shops from %s", catKey, foundCount, currentPageURL)

					// Find next page
					nextPage := producerPage.Locator(".c-pagination__arrow--next").First()
					if nextPage == nil {
						break
					}
					isVisible, _ := nextPage.IsVisible()
					if !isVisible {
						break
					}
					nextURL, err := nextPage.GetAttribute("href")
					if err != nil || nextURL == "" {
						break
					}
					currentPageURL = nextURL
					if !strings.HasPrefix(currentPageURL, "http") {
						currentPageURL = "https://tabelog.com" + currentPageURL
					}
					time.Sleep(1 * time.Second) // Anti-bot delay
				}
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


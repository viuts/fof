package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	"github.com/joho/godotenv"
	"github.com/playwright-community/playwright-go"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func main() {
	preference := flag.String("preference", "tokyo", "Preference (e.g. tokyo)")
	category := flag.String("category", "ramen", "Category (e.g. ramen)")
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

	context, err := browser.NewContext(playwright.BrowserNewContextOptions{
		Locale: playwright.String("ja-JP"),
		ExtraHttpHeaders: map[string]string{
			"Accept-Language": "ja-JP,ja;q=0.9",
		},
		UserAgent: playwright.String("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"),
	})
	if err != nil {
		log.Fatalf("could not create context: %v", err)
	}

	// Block ads, analytics and non-essential resources at context level
	context.Route("**/*", func(route playwright.Route) {
		request := route.Request()
		resourceType := request.ResourceType()
		url := request.URL()

		// Abort if it's an ad/tracker or a heavy secondary resource
		if resourceType == "image" || resourceType == "stylesheet" || resourceType == "font" || resourceType == "media" ||
			strings.Contains(url, "google-analytics") ||
			strings.Contains(url, "googletagmanager") ||
			strings.Contains(url, "doubleclick") ||
			strings.Contains(url, "amazon-adsystem") ||
			strings.Contains(url, "facebook.net") ||
			strings.Contains(url, "criteo") ||
			strings.Contains(url, "adnxs") ||
			strings.Contains(url, "yadirect") ||
			strings.Contains(url, "log.tabelog.com") ||
			strings.Contains(url, "smartadserver") {
			route.Abort()
		} else {
			route.Continue()
		}
	})

	page, err := context.NewPage()
	if err != nil {
		log.Fatalf("could not create page: %v", err)
	}

	// URL for Tabelog
	// Format: https://tabelog.com/{preference}/rstLst/{category}/?SrtT=nod&Srt=D
	baseURL := fmt.Sprintf("https://tabelog.com/%s/rstLst/%s/?SrtT=nod&Srt=D", *preference, *category)
	log.Printf("Starting crawl for: %s", baseURL)

	currentPageURL := baseURL
	for {
		log.Printf("Crawling page: %s", currentPageURL)
		if _, err = page.Goto(currentPageURL, playwright.PageGotoOptions{
			WaitUntil: playwright.WaitUntilStateCommit,
			Timeout:   playwright.Float(60000),
		}); err != nil {
			log.Printf("could not goto page %s: %v", currentPageURL, err)
			break
		}

		// Wait for pagination or results
		if _, err := page.WaitForSelector(".list-rst__rst-name-target, .c-pagination", playwright.PageWaitForSelectorOptions{
			Timeout: playwright.Float(10000),
		}); err != nil {
			log.Printf("Warning: search results not found within timeout for %s", currentPageURL)
		}

		// Handle language modal if any
		// Try to click "Japanese" or the close button
		modalClose := page.Locator(".js-modal-close, .p-lang-modal__btn-ja").First()
		if visible, _ := modalClose.IsVisible(); visible {
			modalClose.Click()
			time.Sleep(500 * time.Millisecond) // Wait for state to be saved
		}

		// Get all restaurant links on the page
		restaurantLinks, err := page.Locator(".list-rst__rst-name-target").All()
		if err != nil {
			log.Printf("could not get restaurant links: %v", err)
			break
		}

		var shopURLs []string
		for _, link := range restaurantLinks {
			href, _ := link.GetAttribute("href")
			if href != "" {
				shopURLs = append(shopURLs, href)
			}
		}

		log.Printf("Found %d shops on page", len(shopURLs))

		for i, url := range shopURLs {
			loopStart := time.Now()
			log.Printf("[Loop] Starting shop %d/%d: %s", i+1, len(shopURLs), url)
			shop, err := crawlShopDetail(context, url)
			if err != nil {
				log.Printf("Error crawling shop %s: %v", url, err)
				continue
			}

			// Save to DB (Upsert)
			dbStart := time.Now()
			result := db.Clauses(clause.OnConflict{
				Columns:   []clause.Column{{Name: "source_url"}},
				DoUpdates: clause.AssignmentColumns([]string{"name", "category", "lat", "lng", "geom", "address", "phone", "opening_hours", "image_urls", "rating", "updated_at"}),
			}).Create(shop)
			log.Printf("[Timing] DB Upsert: %v", time.Since(dbStart))
			log.Printf("Shop Detail: %v", shop)

			if result.Error != nil {
				log.Printf("Error saving shop to DB: %v", result.Error)
			} else {
				log.Printf("Saved/Updated shop: %s", shop.Name)
			}
			log.Printf("[Timing] Shop total: %v", time.Since(loopStart))
		}

		// Find next page
		nextPage := page.Locator(".c-pagination__arrow--next").First()
		if nextPage == nil {
			log.Printf("No more pages found.")
			break
		}

		isVisible, _ := nextPage.IsVisible()
		if !isVisible {
			log.Printf("Next page button not visible.")
			break
		}

		nextURL, err := nextPage.GetAttribute("href")
		if err != nil || nextURL == "" {
			break
		}
		currentPageURL = nextURL

		// Anti-bot measure
		fmt.Println("Sleeping for 500ms...")
		time.Sleep(500 * time.Millisecond)
	}
}

func crawlShopDetail(ctx playwright.BrowserContext, url string) (*domain.Shop, error) {
	start := time.Now()
	page, err := ctx.NewPage()
	if err != nil {
		return nil, err
	}
	defer page.Close()
	log.Printf("[Timing] Page creation: %v", time.Since(start))

	navStart := time.Now()
	if _, err := page.Goto(url, playwright.PageGotoOptions{
		WaitUntil: playwright.WaitUntilStateLoad,
		Timeout:   playwright.Float(10000),
	}); err != nil {
		return nil, err
	}
	log.Printf("[Timing] Goto: %v", time.Since(navStart))

	// Wait for the script tag to be present
	page.WaitForSelector("script[type='application/ld+json']", playwright.PageWaitForSelectorOptions{
		State:   playwright.WaitForSelectorStateAttached,
		Timeout: playwright.Float(2000),
	})

	extractStart := time.Now()

	// DEBUG: Check full page content length
	content, _ := page.Content()
	log.Printf("[Debug] Page content length: %d", len(content))
	if len(content) < 1000 {
		log.Printf("[Debug] Page content suspicious: %s", content)
	}

	// Extract JSON-LD scripts using Evaluate to avoid Playwright locator timeouts
	var scripts interface{}
	for i := 0; i < 3; i++ {
		scripts, err = page.Evaluate(`() => {
			const result = [];
			const nodes = document.querySelectorAll("script[type='application/ld+json']");
			for (const node of nodes) {
				result.push(node.innerText);
			}
			return result;
		}`)
		if err == nil {
			if sc, ok := scripts.([]interface{}); ok && len(sc) > 0 {
				log.Printf("[Debug] Found %d scripts on attempt %d", len(sc), i+1)
				break
			}
		}
		time.Sleep(200 * time.Millisecond)
	}
	var shop domain.Shop
	shop.SourceURL = url

	if err == nil {
		if scriptContents, ok := scripts.([]interface{}); ok {
			for _, contentObj := range scriptContents {
				content, ok := contentObj.(string)
				if !ok {
					continue
				}
				log.Printf("[Debug] JSON-LD Content (first 100 chars): %s", content[:min(100, len(content))])
				var data map[string]interface{}
				if err := json.Unmarshal([]byte(content), &data); err != nil {
					continue
				}

				// Check @type or other markers - broaden to include LocalBusiness
				if strings.Contains(content, "Restaurant") || strings.Contains(content, "LocalBusiness") {
					if name, ok := data["name"].(string); ok {
						shop.Name = name
					}
					if genre, ok := data["genre"].(string); ok {
						shop.Category = genre
					} else if genres, ok := data["genre"].([]interface{}); ok && len(genres) > 0 {
						var gs []string
						for _, g := range genres {
							if s, ok := g.(string); ok {
								gs = append(gs, s)
							}
						}
						shop.Category = strings.Join(gs, ", ")
					}

					if geo, ok := data["geo"].(map[string]interface{}); ok {
						if lat, ok := geo["latitude"].(float64); ok {
							shop.Lat = lat
						}
						if lng, ok := geo["longitude"].(float64); ok {
							shop.Lng = lng
						}
					}

					if address, ok := data["address"].(map[string]interface{}); ok {
						if street, ok := address["streetAddress"].(string); ok {
							shop.Address = street
						}
					}

					if telephone, ok := data["telephone"].(string); ok {
						shop.Phone = telephone
					}

					if openingHours, ok := data["openingHours"].(string); ok {
						shop.OpeningHours = openingHours
					} else if ohs, ok := data["openingHours"].([]interface{}); ok {
						var hours []string
						for _, h := range ohs {
							if hs, ok := h.(string); ok {
								hours = append(hours, hs)
							}
						}
						shop.OpeningHours = strings.Join(hours, "\n")
					}

					if image, ok := data["image"].(string); ok {
						shop.ImageURLs = append(shop.ImageURLs, image)
					} else if images, ok := data["image"].([]interface{}); ok {
						for _, img := range images {
							if is, ok := img.(string); ok {
								shop.ImageURLs = append(shop.ImageURLs, is)
							}
						}
					}

					if aggregateRating, ok := data["aggregateRating"].(map[string]interface{}); ok {
						if ratingValue, ok := aggregateRating["ratingValue"]; ok {
							switch v := ratingValue.(type) {
							case float64:
								shop.Rating = v
							case string:
								fmt.Sscanf(v, "%f", &shop.Rating)
							}
						}
					}
					// Found the main data object, can stop searching scripts
					break
				}
			}
		}
	}
	log.Printf("[Timing] JSON-LD extraction: %v", time.Since(extractStart))

	// Calculate Geom for PostGIS
	if shop.Lat != 0 && shop.Lng != 0 {
		geom := fmt.Sprintf("SRID=4326;POINT(%f %f)", shop.Lng, shop.Lat)
		shop.Geom = &geom
	}

	shopStart := time.Now()

	// Data cleanup
	shop.Address = strings.ReplaceAll(shop.Address, "大きな地図を見る", "")
	shop.Address = strings.ReplaceAll(shop.Address, "周辺のお店を探す", "")
	shop.Address = strings.TrimSpace(shop.Address)

	shop.OpeningHours = strings.ReplaceAll(shop.OpeningHours, "営業時間・定休日は変更となる場合がございますので、ご来店前に店舗にご確認ください。", "")
	shop.OpeningHours = strings.TrimSpace(shop.OpeningHours)

	// Clean ImageURLs - remove "nophoto" images
	var filteredImages []string
	for _, img := range shop.ImageURLs {
		if !strings.Contains(img, "nophoto") {
			filteredImages = append(filteredImages, img)
		}
	}
	shop.ImageURLs = filteredImages

	log.Printf("[Timing] Shop extraction: %v", time.Since(shopStart))

	shop.CreatedAt = time.Now()
	shop.UpdatedAt = time.Now()

	return &shop, nil
}

package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
	"regexp"
	"strings"
	"time"

	"github.com/joho/godotenv"
	"github.com/playwright-community/playwright-go"
	"github.com/viuts/fof/apps/backend/internal/domain"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const WorkerCount = 5

type Job struct {
	URL string
}

type Result struct {
	URL   string
	Error error
}

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

	// Initialize Workers
	jobs := make(chan Job, 1000)
	results := make(chan Result, 1000)

	// Create common ad-block handler
	routeHandler := func(route playwright.Route) {
		request := route.Request()
		resourceType := request.ResourceType()
		url := request.URL()

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
	}

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

		context.Route("**/*", routeHandler)

		go worker(i+1, context, db, jobs, results)
	}

	baseURL := fmt.Sprintf("https://tabelog.com/%s/rstLst/%s/?SrtT=nod&Srt=D", *preference, *category)

	// Manager Loop (Producer)
	log.Printf("Starting producer with initial URL: %s", baseURL)

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

	go func() {
		defer close(jobs)

		log.Printf("[Producer] Initializing: Fetching base URL to extract sub-areas: %s", baseURL)
		if _, err := producerPage.Goto(baseURL, playwright.PageGotoOptions{
			WaitUntil: playwright.WaitUntilStateCommit,
			Timeout:   playwright.Float(60000),
		}); err != nil {
			log.Printf("[Producer] Error going to base URL %s: %v", baseURL, err)
			return
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
		// Selector: #tabs-panel-balloon-pref-area .list-balloon__list-item a
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
			log.Printf("[Producer] No sub-areas found, processing base URL only.")
			areaURLs = []string{baseURL}
		} else {
			log.Printf("[Producer] Found %d sub-areas. Starting crawl loop...", len(areaURLs))
		}

		for _, areaURL := range areaURLs {
			currentPageURL := areaURL
			for {
				log.Printf("[Producer] Fetching page: %s", currentPageURL)
				if _, err := producerPage.Goto(currentPageURL, playwright.PageGotoOptions{
					WaitUntil: playwright.WaitUntilStateCommit,
					Timeout:   playwright.Float(60000),
				}); err != nil {
					log.Printf("[Producer] Error going to page %s: %v", currentPageURL, err)
					break
				}

				// Wait for results
				if _, err := producerPage.WaitForSelector(".list-rst__rst-name-target, .c-pagination", playwright.PageWaitForSelectorOptions{
					Timeout: playwright.Float(10000),
				}); err != nil {
					log.Printf("[Producer] Warning: selector not found on %s", currentPageURL)
				}

				// Extract shop URLs
				links, err := producerPage.Locator(".list-rst__rst-name-target").All()
				if err != nil {
					log.Printf("[Producer] Error getting links: %v", err)
					break
				}

				foundCount := 0
				for _, link := range links {
					href, _ := link.GetAttribute("href")
					if href != "" {
						jobs <- Job{URL: href}
						foundCount++
					}
				}
				log.Printf("[Producer] Queued %d shops from %s", foundCount, currentPageURL)

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
	}()

	// Wait for workers to finish
	for i := 0; i < WorkerCount; i++ {
		<-results
	}

	log.Println("All jobs completed. Exiting.")
}

func worker(id int, ctx playwright.BrowserContext, db *gorm.DB, jobs <-chan Job, results chan<- Result) {
	for job := range jobs {
		log.Printf("[Worker %d] Processing: %s", id, job.URL)
		shop, err := crawlShopDetail(ctx, job.URL)
		if err != nil {
			log.Printf("[Worker %d] Error crawling shop %s: %v", id, job.URL, err)
		} else {
			// Save to DB (Upsert)
			result := db.Clauses(clause.OnConflict{
				Columns:   []clause.Column{{Name: "source_url"}},
				DoUpdates: clause.AssignmentColumns([]string{"name", "category", "lat", "lng", "geom", "address", "phone", "opening_hours", "image_urls", "rating", "reservable", "updated_at"}),
			}).Create(shop)

			if result.Error != nil {
				log.Printf("[Worker %d] Error saving shop %s to DB: %v", id, shop.Name, result.Error)
			} else {
				log.Printf("[Worker %d] Saved/Updated shop: %s", id, shop.Name)
			}
		}

		// results is used to signal worker completion in the main loop refactor
		// Wait, I need a better way to signaling completion since workers process many jobs.
		// I'll use a WaitGroup or just have workers signal 'nil' when done with the channel.
	}
	results <- Result{} // Signal one worker finished
}

func getShopCategory(cuisine string) fofv1.FoodCategory {
	// Priority 1: Izakaya
	if strings.Contains(cuisine, "居酒屋") {
		return fofv1.FoodCategory_FOOD_CATEGORY_IZAKAYA
	}
	// Priority 2: Chinese
	if strings.Contains(cuisine, "中華料理") {
		return fofv1.FoodCategory_FOOD_CATEGORY_CHINESE
	}

	// Priority 3: First match in list
	cuisines := strings.Split(cuisine, "、")
	for _, c := range cuisines {
		cat := mapSubCategoryToMajor(c)
		if cat != fofv1.FoodCategory_FOOD_CATEGORY_UNSPECIFIED {
			return cat
		}
	}

	return fofv1.FoodCategory_FOOD_CATEGORY_UNSPECIFIED
}

func mapSubCategoryToMajor(sub string) fofv1.FoodCategory {
	sub = strings.TrimSpace(sub)
	switch sub {
	// 和食
	case "郷土料理", "豆腐料理", "うなぎ", "あなご", "どじょう", "釜飯", "お茶漬け", "ろばた焼き", "きりたんぽ", "和食":
		return fofv1.FoodCategory_FOOD_CATEGORY_WASHOKU
	// 寿司
	case "寿司", "回転寿司", "立ち食い寿司", "いなり寿司", "海鮮", "ふぐ", "かに", "かき":
		return fofv1.FoodCategory_FOOD_CATEGORY_SUSHI
	// 揚げ物
	case "天ぷら", "とんかつ", "牛カツ", "串揚げ", "からあげ", "コロッケ", "揚げ物":
		return fofv1.FoodCategory_FOOD_CATEGORY_AGEMONO
	// 焼き鳥
	case "焼き鳥", "串焼き", "もつ焼き", "鳥料理", "手羽先":
		return fofv1.FoodCategory_FOOD_CATEGORY_YAKITORI
	// 焼肉
	case "焼肉", "ホルモン", "ジンギスカン", "牛タン", "バーベキュー":
		return fofv1.FoodCategory_FOOD_CATEGORY_YAKINIKU
	// 肉料理
	case "ステーキ", "鉄板焼き", "牛料理", "豚料理", "馬肉料理", "ジビエ料理", "肉料理":
		return fofv1.FoodCategory_FOOD_CATEGORY_NIKURYOURI
	// 鍋
	case "鍋", "しゃぶしゃぶ", "すき焼き", "もつ鍋", "水炊き", "ちゃんこ鍋", "火鍋", "おでん":
		return fofv1.FoodCategory_FOOD_CATEGORY_NABE
	// 丼
	case "丼", "牛丼", "親子丼", "天丼", "かつ丼", "海鮮丼", "豚丼":
		return fofv1.FoodCategory_FOOD_CATEGORY_DON
	// 麺
	case "そば", "うどん", "カレーうどん", "焼きそば", "沖縄そば", "ほうとう", "ちゃんぽん", "麺":
		return fofv1.FoodCategory_FOOD_CATEGORY_MEN
	// ラーメン
	case "ラーメン", "つけ麺", "油そば", "まぜそば", "担々麺", "刀削麺":
		return fofv1.FoodCategory_FOOD_CATEGORY_RAMEN
	// 粉もの
	case "お好み焼き", "もんじゃ焼き", "たこ焼き", "明石焼き", "粉もの":
		return fofv1.FoodCategory_FOOD_CATEGORY_KONAMONO
	// 洋食
	case "洋食", "ハンバーグ", "オムライス", "ハンバーガー", "ホットドッグ", "スープ":
		return fofv1.FoodCategory_FOOD_CATEGORY_YOSHOKU
	// 欧州
	case "イタリアン", "フレンチ", "ビストロ", "パスタ", "ピザ", "スペイン料理", "ドイツ料理", "ロシア料理", "欧州カレー", "欧州": // Added 欧州
		return fofv1.FoodCategory_FOOD_CATEGORY_EUROPEAN
	// 中華
	case "四川料理", "台湾料理", "飲茶", "点心", "餃子", "小籠包", "中華粥", "中華": // 中華料理 handled by Priority 2
		return fofv1.FoodCategory_FOOD_CATEGORY_CHINESE
	// 韓国
	case "韓国料理", "冷麺", "韓国":
		return fofv1.FoodCategory_FOOD_CATEGORY_KOREAN
	// エスニック
	case "タイ料理", "ベトナム料理", "インドネシア料理", "メキシコ料理", "トルコ料理", "アフリカ料理", "エスニック":
		return fofv1.FoodCategory_FOOD_CATEGORY_ETHNIC
	// カレー
	case "カレー", "インドカレー", "スープカレー", "欧風カレー":
		return fofv1.FoodCategory_FOOD_CATEGORY_CURRY
	// 居酒屋
	case "ダイニングバー", "バル", "立ち飲み", "ビアガーデン", "ビアホール": // 居酒屋 handled by Priority 1
		return fofv1.FoodCategory_FOOD_CATEGORY_IZAKAYA
	// バー
	case "バー", "パブ", "ワインバー", "ビアバー", "スポーツバー", "日本酒バー", "焼酎バー":
		return fofv1.FoodCategory_FOOD_CATEGORY_BAR
	// カフェ
	case "カフェ", "喫茶店", "パン", "サンドイッチ", "ベーグル", "コーヒースタンド", "甘味処":
		return fofv1.FoodCategory_FOOD_CATEGORY_CAFE
	// スイーツ
	case "ケーキ", "チョコレート", "和菓子", "ジェラート", "かき氷", "パンケーキ", "クレープ", "ドーナツ", "スイーツ":
		return fofv1.FoodCategory_FOOD_CATEGORY_SWEETS
	}
	return fofv1.FoodCategory_FOOD_CATEGORY_UNSPECIFIED
}

func crawlShopDetail(ctx playwright.BrowserContext, url string) (*domain.Shop, error) {
	// start := time.Now()
	page, err := ctx.NewPage()
	if err != nil {
		return nil, err
	}
	defer page.Close()
	// log.Printf("[Timing] Page creation: %v", time.Since(start))

	// navStart := time.Now()
	if _, err := page.Goto(url, playwright.PageGotoOptions{
		WaitUntil: playwright.WaitUntilStateLoad,
		Timeout:   playwright.Float(30000),
	}); err != nil {
		return nil, err
	}
	// log.Printf("[Timing] Goto: %v", time.Since(navStart))

	// Wait for the script tag to be present
	page.WaitForSelector("script[type='application/ld+json']", playwright.PageWaitForSelectorOptions{
		State:   playwright.WaitForSelectorStateAttached,
		Timeout: playwright.Float(2000),
	})

	// extractStart := time.Now()

	// Extract JSON-LD scripts
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
				var data map[string]interface{}
				if err := json.Unmarshal([]byte(content), &data); err != nil {
					continue
				}

				if strings.Contains(content, "Restaurant") || strings.Contains(content, "LocalBusiness") {
					if name, ok := data["name"].(string); ok {
						shop.Name = name
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
						fullAddress := ""
						if region, ok := address["addressRegion"].(string); ok {
							fullAddress += region
						}

						if locality, ok := address["addressLocality"].(string); ok {
							fullAddress += locality
						}

						if street, ok := address["streetAddress"].(string); ok {
							fullAddress += street
						}

						shop.Address = fullAddress
					}

					// serve cusine
					if cusine, ok := data["servesCuisine"].(string); ok {
						shop.Category = getShopCategory(cusine).String()
						// log.Printf("Mapped cuisine '%s' to category '%s'", cusine, shop.Category)
					}

					// Check for potentialAction (ReserveAction)
					if potentialAction, ok := data["potentialAction"].(map[string]interface{}); ok {
						if typeStr, ok := potentialAction["@type"].(string); ok && typeStr == "ReserveAction" {
							shop.Reservable = true
						}
					} else if potentialActions, ok := data["potentialAction"].([]interface{}); ok {
						for _, action := range potentialActions {
							if actionMap, ok := action.(map[string]interface{}); ok {
								if typeStr, ok := actionMap["@type"].(string); ok && typeStr == "ReserveAction" {
									shop.Reservable = true
									log.Printf("Found reservable shop: %s", shop.Name)
									break
								}
							}
						}
					}

					if telephone, ok := data["telephone"].(string); ok {
						if !strings.Contains(telephone, "情報") {
							shop.Phone = telephone
						}
					}

					// Skip openingHours string from JSON-LD for now, as we prefer the FAQ structured data
					// if openingHours, ok := data["openingHours"].(string); ok { ... }

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
				}

				if data["@type"].(string) == "FAQPage" {
					if faq, ok := data["mainEntity"].([]interface{}); ok {
						for _, f := range faq {
							if faqMap, ok := f.(map[string]interface{}); ok {
								if name, ok := faqMap["name"].(string); ok && name == "営業時間・定休日を教えてください" {
									if answer, ok := faqMap["acceptedAnswer"].(map[string]interface{}); ok {
										if text, ok := answer["text"].(string); ok {
											parsedHours := parseOpeningHours(text)
											if len(parsedHours) > 0 {
												shop.OpeningHours = parsedHours
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	// log.Printf("[Timing] JSON-LD extraction: %v", time.Since(extractStart))

	if shop.Lat != 0 && shop.Lng != 0 {
		geom := fmt.Sprintf("SRID=4326;POINT(%f %f)", shop.Lng, shop.Lat)
		shop.Geom = &geom
	}

	// shopStart := time.Now()

	shop.Address = strings.ReplaceAll(shop.Address, "大きな地図を見る", "")
	shop.Address = strings.ReplaceAll(shop.Address, "周辺のお店を探す", "")
	shop.Address = strings.TrimSpace(shop.Address)

	var filteredImages []string
	for _, img := range shop.ImageURLs {
		if !strings.Contains(img, "nophoto") {
			filteredImages = append(filteredImages, img)
		}
	}
	shop.ImageURLs = filteredImages

	// log.Printf("[Timing] Shop extraction: %v", time.Since(shopStart))

	shop.CreatedAt = time.Now()
	shop.UpdatedAt = time.Now()

	return &shop, nil
}

func parseOpeningHours(htmlContent string) domain.BusinessHours {
	// 1. Strip HTML tags
	reTags := regexp.MustCompile(`<[^>]*>`)
	text := reTags.ReplaceAllString(htmlContent, "\n")

	// 2. Normalize whitespace and split by lines
	text = strings.ReplaceAll(text, "　", " ")
	lines := strings.Split(text, "\n")

	dayToIntervals := make(domain.BusinessHours)
	var lastDays []string

	dayRe := regexp.MustCompile(`^\[(.*?)\]$`)
	timeRe := regexp.MustCompile(`(\d{1,2}:\d{2})\s*-\s*(\d{1,2}:\d{2})`)

	dayMap := map[string]domain.BusinessDay{
		"月":  domain.BusinessDayMonday,
		"火":  domain.BusinessDayTuesday,
		"水":  domain.BusinessDayWednesday,
		"木":  domain.BusinessDayThursday,
		"金":  domain.BusinessDayFriday,
		"土":  domain.BusinessDaySaturday,
		"日":  domain.BusinessDaySunday,
		"祝":  domain.BusinessDayHoliday,
		"祝日": domain.BusinessDayHoliday,
	}

	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}

		if matches := dayRe.FindStringSubmatch(line); len(matches) > 1 {
			dayStr := matches[1]
			// Handle groupings like [月・火・水]
			dayParts := strings.Split(dayStr, "・")
			lastDays = nil
			for _, part := range dayParts {
				if eng, ok := dayMap[part]; ok {
					lastDays = append(lastDays, string(eng))
				} else {
					// Default to using the part as is if not in map
					lastDays = append(lastDays, part)
				}
			}
			continue
		}

		if len(lastDays) > 0 && timeRe.MatchString(line) {
			matches := timeRe.FindStringSubmatch(line)
			if len(matches) > 2 {
				interval := domain.TimeInterval{
					Open:  matches[1],
					Close: matches[2],
				}
				for _, d := range lastDays {
					day := domain.BusinessDay(d)
					dayToIntervals[day] = append(dayToIntervals[day], interval)
				}
			}
		}
	}

	return dayToIntervals
}

package tabelog

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/playwright-community/playwright-go"
	"github.com/viuts/fof/apps/backend/internal/domain"
	"github.com/viuts/fof/apps/backend/pkg/crawler"
)

func CrawlShopDetail(ctx playwright.BrowserContext, url string) (*domain.Shop, error) {
	page, err := ctx.NewPage()
	if err != nil {
		return nil, err
	}
	defer page.Close()

	if _, err := page.Goto(url, playwright.PageGotoOptions{
		WaitUntil: playwright.WaitUntilStateLoad,
		Timeout:   playwright.Float(30000),
	}); err != nil {
		return nil, err
	}

	page.WaitForSelector("script[type='application/ld+json']", playwright.PageWaitForSelectorOptions{
		State:   playwright.WaitForSelectorStateAttached,
		Timeout: playwright.Float(2000),
	})

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
						shop.IsChain = crawler.IsChain(name)
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

					if cusine, ok := data["servesCuisine"].(string); ok {
						shop.Category = GetShopCategory(cusine).String()
					}

					if potentialAction, ok := data["potentialAction"].(map[string]interface{}); ok {
						if typeStr, ok := potentialAction["@type"].(string); ok && typeStr == "ReserveAction" {
							shop.Reservable = true
						}
					} else if potentialActions, ok := data["potentialAction"].([]interface{}); ok {
						for _, action := range potentialActions {
							if actionMap, ok := action.(map[string]interface{}); ok {
								if typeStr, ok := actionMap["@type"].(string); ok && typeStr == "ReserveAction" {
									shop.Reservable = true
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

					if image, ok := data["image"].(string); ok {
						shop.ImageURLs = append(shop.ImageURLs, image)
					} else if images, ok := data["image"].([]interface{}); ok {
						for _, img := range images {
							if is, ok := img.(string); ok {
								shop.ImageURLs = append(shop.ImageURLs, is)
							}
						}
					}

					if priceRange, ok := data["priceRange"].(string); ok {
						shop.AveragePrice = ParsePrice(priceRange)
					}

					// Fallback if price is still 0
					if shop.AveragePrice == 0 {
						budget, err := page.Evaluate(`() => {
							const budgetNode = document.querySelector(".rstinfo-table__budget");
							if (!budgetNode) return "";
							return budgetNode.innerText;
						}`)
						if err == nil {
							if budgetStr, ok := budget.(string); ok && budgetStr != "" {
								shop.AveragePrice = ParsePrice(budgetStr)
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
						if reviewCount, ok := aggregateRating["ratingCount"]; ok {
							switch v := reviewCount.(type) {
							case float64:
								shop.ReviewCount = int(v)
							case string:
								fmt.Sscanf(v, "%d", &shop.ReviewCount)
							}
						}
					}

					// Fallback for Rating and ReviewCount if still 0
					if shop.Rating == 0 || shop.ReviewCount == 0 {
						stats, err := page.Evaluate(`() => {
							const results = { rating: "", reviewCount: "" };
							const scoreNode = document.querySelector(".rdheader-rating__score-val");
							if (scoreNode) results.rating = scoreNode.innerText.trim();
							
							const reviewNode = document.querySelector(".rdheader-rating__review .num");
							if (reviewNode) results.reviewCount = reviewNode.innerText.trim();
							
							return results;
						}`)
						if err == nil {
							if statsMap, ok := stats.(map[string]interface{}); ok {
								if shop.Rating == 0 {
									if rStr, ok := statsMap["rating"].(string); ok && rStr != "" {
										fmt.Sscanf(rStr, "%f", &shop.Rating)
									}
								}
								if shop.ReviewCount == 0 {
									if cStr, ok := statsMap["reviewCount"].(string); ok && cStr != "" {
										fmt.Sscanf(cStr, "%d", &shop.ReviewCount)
									}
								}
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
											parsedHours := ParseOpeningHours(text)
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

	if shop.Lat != 0 && shop.Lng != 0 {
		geom := fmt.Sprintf("SRID=4326;POINT(%f %f)", shop.Lng, shop.Lat)
		shop.Geom = &geom
	}

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

	shop.CreatedAt = time.Now()
	shop.UpdatedAt = time.Now()

	return &shop, nil
}

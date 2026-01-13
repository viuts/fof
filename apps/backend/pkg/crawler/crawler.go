package crawler

import (
	"strings"

	"github.com/playwright-community/playwright-go"
	"github.com/viuts/fof/apps/backend/internal/domain"
)

type Job struct {
	URL string
}

func AdBlockRouteHandler(route playwright.Route) {
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

type Provider interface {
	CrawlShopDetail(ctx playwright.BrowserContext, url string) (*domain.Shop, error)
}

package tabelog

import (
	"regexp"
	"strconv"
	"strings"

	"github.com/viuts/fof/apps/backend/internal/domain"
	fofv1 "github.com/viuts/fof/apps/backend/pkg/api/fof/v1"
)

func GetShopCategory(cuisine string) fofv1.FoodCategory {
	if strings.Contains(cuisine, "居酒屋") {
		return fofv1.FoodCategory_FOOD_CATEGORY_IZAKAYA
	}
	if strings.Contains(cuisine, "中華料理") {
		return fofv1.FoodCategory_FOOD_CATEGORY_CHINESE
	}

	cuisines := strings.Split(cuisine, "、")
	for _, c := range cuisines {
		cat := MapSubCategoryToMajor(c)
		if cat != fofv1.FoodCategory_FOOD_CATEGORY_UNSPECIFIED {
			return cat
		}
	}

	return fofv1.FoodCategory_FOOD_CATEGORY_UNSPECIFIED
}

func MapSubCategoryToMajor(sub string) fofv1.FoodCategory {
	sub = strings.TrimSpace(sub)
	switch sub {
	case "郷土料理", "豆腐料理", "うなぎ", "あなご", "どじょう", "釜飯", "お茶漬け", "ろばた焼き", "きりたんぽ", "和食":
		return fofv1.FoodCategory_FOOD_CATEGORY_WASHOKU
	case "寿司", "回転寿司", "立ち食い寿司", "いなり寿司", "海鮮", "ふぐ", "かに", "かき":
		return fofv1.FoodCategory_FOOD_CATEGORY_SUSHI
	case "天ぷら", "とんかつ", "牛カツ", "串揚げ", "からあげ", "コロッケ", "揚げ物":
		return fofv1.FoodCategory_FOOD_CATEGORY_AGEMONO
	case "焼き鳥", "串焼き", "もつ焼き", "鳥料理", "手羽先":
		return fofv1.FoodCategory_FOOD_CATEGORY_YAKITORI
	case "焼肉", "ホルモン", "ジンギスカン", "牛タン", "バーベキュー":
		return fofv1.FoodCategory_FOOD_CATEGORY_YAKINIKU
	case "ステーキ", "鉄板焼き", "牛料理", "豚料理", "馬肉料理", "ジビエ料理", "肉料理":
		return fofv1.FoodCategory_FOOD_CATEGORY_NIKURYOURI
	case "鍋", "しゃぶしゃぶ", "すき焼き", "もつ鍋", "水炊き", "ちゃんこ鍋", "火鍋", "おでん":
		return fofv1.FoodCategory_FOOD_CATEGORY_NABE
	case "丼", "牛丼", "親子丼", "天丼", "かつ丼", "海鮮丼", "豚丼":
		return fofv1.FoodCategory_FOOD_CATEGORY_DON
	case "そば", "うどん", "カレーうどん", "焼きそば", "沖縄そば", "ほうとう", "ちゃんぽん", "麺":
		return fofv1.FoodCategory_FOOD_CATEGORY_MEN
	case "ラーメン", "つけ麺", "油そば", "まぜそば", "担々麺", "刀削麺":
		return fofv1.FoodCategory_FOOD_CATEGORY_RAMEN
	case "お好み焼き", "もんじゃ焼き", "たこ焼き", "明石焼き", "粉もの":
		return fofv1.FoodCategory_FOOD_CATEGORY_KONAMONO
	case "洋食", "ハンバーグ", "オムライス", "ハンバーガー", "ホットドッグ", "スープ":
		return fofv1.FoodCategory_FOOD_CATEGORY_YOSHOKU
	case "イタリアン", "フレンチ", "ビストロ", "パスタ", "ピザ", "スペイン料理", "ドイツ料理", "ロシア料理", "欧州カレー", "欧州":
		return fofv1.FoodCategory_FOOD_CATEGORY_EUROPEAN
	case "四川料理", "台湾料理", "飲茶", "点心", "餃子", "小籠包", "中華粥", "中華":
		return fofv1.FoodCategory_FOOD_CATEGORY_CHINESE
	case "韓国料理", "冷麺", "韓国":
		return fofv1.FoodCategory_FOOD_CATEGORY_KOREAN
	case "タイ料理", "ベトナム料理", "インドネシア料理", "メキシコ料理", "トルコ料理", "アフリカ料理", "エスニック":
		return fofv1.FoodCategory_FOOD_CATEGORY_ETHNIC
	case "カレー", "インドカレー", "スープカレー", "欧風カレー":
		return fofv1.FoodCategory_FOOD_CATEGORY_CURRY
	case "ダイニングバー", "バル", "立ち飲み", "ビアガーデン", "ビアホール":
		return fofv1.FoodCategory_FOOD_CATEGORY_IZAKAYA
	case "バー", "パブ", "ワインバー", "ビアバー", "スポーツバー", "日本酒バー", "焼酎バー":
		return fofv1.FoodCategory_FOOD_CATEGORY_BAR
	case "カフェ", "喫茶店", "パン", "サンドイッチ", "ベーグル", "コーヒースタンド", "甘味処":
		return fofv1.FoodCategory_FOOD_CATEGORY_CAFE
	case "ケーキ", "チョコレート", "和菓子", "ジェラート", "かき氷", "パンケーキ", "クレープ", "ドーナツ", "スイーツ":
		return fofv1.FoodCategory_FOOD_CATEGORY_SWEETS
	}
	return fofv1.FoodCategory_FOOD_CATEGORY_UNSPECIFIED
}

func ParseOpeningHours(htmlContent string) domain.BusinessHours {
	reTags := regexp.MustCompile(`<[^>]*>`)
	text := reTags.ReplaceAllString(htmlContent, "\n")

	text = strings.ReplaceAll(text, "　", " ")
	text = strings.ReplaceAll(text, "～", "-")
	text = strings.ReplaceAll(text, "－", "-")
	text = strings.ReplaceAll(text, "‐", "-")

	lines := strings.Split(text, "\n")

	dayToIntervals := make(domain.BusinessHours)
	var lastDays []string

	rangeRe := regexp.MustCompile(`([月火水木金土日祝])\s*-\s*([月火水木金土日祝])`)
	singleDayRe := regexp.MustCompile(`[月火水木金土日祝]`)
	timeRe := regexp.MustCompile(`(\d{1,2}:\d{2})\s*-\s*(\d{1,2}:\d{2})`)
	allDayRe := regexp.MustCompile(`24時間営業`)

	dayMap := map[string]domain.BusinessDay{
		"月": domain.BusinessDayMonday,
		"火": domain.BusinessDayTuesday,
		"水": domain.BusinessDayWednesday,
		"木": domain.BusinessDayThursday,
		"金": domain.BusinessDayFriday,
		"土": domain.BusinessDaySaturday,
		"日": domain.BusinessDaySunday,
		"祝": domain.BusinessDayHoliday,
	}
	orderedDays := []string{"月", "火", "水", "木", "金", "土", "日"}

	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}

		var currentLineDays []string
		rangeMatches := rangeRe.FindAllStringSubmatch(line, -1)
		for _, m := range rangeMatches {
			startDay, endDay := m[1], m[2]
			startIdx, endIdx := -1, -1
			for i, d := range orderedDays {
				if d == startDay { startIdx = i }
				if d == endDay { endIdx = i }
			}
			if startIdx != -1 && endIdx != -1 {
				if startIdx <= endIdx {
					for i := startIdx; i <= endIdx; i++ {
						if d, ok := dayMap[orderedDays[i]]; ok {
							currentLineDays = append(currentLineDays, string(d))
						}
					}
				}
			}
		}

		if len(currentLineDays) == 0 {
			dayMatches := singleDayRe.FindAllString(line, -1)
			for _, dStr := range dayMatches {
				if d, ok := dayMap[dStr]; ok {
					currentLineDays = append(currentLineDays, string(d))
				}
			}
		}

		var lineIntervals []domain.TimeInterval
		timeMatches := timeRe.FindAllStringSubmatch(line, -1)
		for _, m := range timeMatches {
			lineIntervals = append(lineIntervals, domain.TimeInterval{
				Open:  m[1],
				Close: m[2],
			})
		}

		if allDayRe.MatchString(line) {
			lineIntervals = append(lineIntervals, domain.TimeInterval{
				Open:  "00:00",
				Close: "23:59",
			})
		}

		if len(currentLineDays) > 0 {
			lastDays = currentLineDays
			if len(lineIntervals) > 0 {
				for _, d := range lastDays {
					day := domain.BusinessDay(d)
					dayToIntervals[day] = append(dayToIntervals[day], lineIntervals...)
				}
			}
		} else if len(lineIntervals) > 0 {
			if len(lastDays) > 0 {
				for _, d := range lastDays {
					day := domain.BusinessDay(d)
					dayToIntervals[day] = append(dayToIntervals[day], lineIntervals...)
				}
			} else {
				// No days specified yet, assume 24/7 (or applies to all days)
				allDays := []domain.BusinessDay{
					domain.BusinessDayMonday,
					domain.BusinessDayTuesday,
					domain.BusinessDayWednesday,
					domain.BusinessDayThursday,
					domain.BusinessDayFriday,
					domain.BusinessDaySaturday,
					domain.BusinessDaySunday,
					domain.BusinessDayHoliday,
				}
				for _, day := range allDays {
					dayToIntervals[day] = append(dayToIntervals[day], lineIntervals...)
				}
			}
		}
	}

	return dayToIntervals
}

func ParsePrice(priceStr string) int {
	priceStr = strings.ReplaceAll(priceStr, ",", "")
	priceStr = strings.ReplaceAll(priceStr, "￥", "")
	priceStr = strings.ReplaceAll(priceStr, " ", "")

	re := regexp.MustCompile(`\d+`)
	matches := re.FindAllString(priceStr, -1)
	if len(matches) == 0 {
		return 0
	}

	total := 0
	count := len(matches)
	for _, m := range matches {
		val, _ := strconv.Atoi(m)
		total += val
	}
	return (total + count - 1) / count
}

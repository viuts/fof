package crawler

import (
	"strings"
)

// Major restaurant chains in Japan
var majorChains = []string{
	// Fast Food & Burgers
	"マクドナルド", "McDonald's", "McDonalds",
	"モスバーガー", "MOS Burger",
	"ケンタッキー", "KFC", "Kentucky Fried Chicken",
	"フレッシュネスバーガー", "Freshness Burger",
	"バーガーキング", "Burger King",
	"ロッテリア", "Lotteria",
	"ファーストキッチン", "First Kitchen",
	"ウェンディーズ", "Wendy's",
	"サブウェイ", "Subway",
	"ドムドムハンバーガー",

	// Gyudon (Beef Bowls)
	"吉野家", "Yoshinoya",
	"すき家", "Sukiya",
	"松屋", "Matsuya",
	"なか卯", "Nakau",

	// Family Restaurants
	"ガスト", "Gusto",
	"サイゼリヤ", "Saizeriya",
	"ジョナサン", "Jonathan's",
	"デニーズ", "Denny's",
	"ロイヤルホスト", "Royal Host",
	"バーミヤン", "Bamiyan",
	"ココス", "COCO'S", "Cocos",
	"びっくりドンキー", "Bikkuri Donkey",
	"やよい軒", "Yayoi Ken",
	"大戸屋", "Ootoya",
	"ジョイフル", "Joyfull",
	"和食さと", "Washoku Sato",
	"夢庵", "ゆめあん",
	"藍屋", "あいや",

	// Cafe & Sweets
	"スターバックス", "Starbucks",
	"ドトール", "Doutor",
	"タリーズ", "Tully's", "Tullys",
	"コメダ珈琲", "Komeda's Coffee",
	"サンマルクカフェ", "St. Marc Cafe",
	"星乃珈琲", "Hoshino Coffee",
	"プロント", "Pronto",
	"ベローチェ", "Veloce",
	"上島珈琲", "Ueshima Coffee",
	"ミスタードーナツ", "Mister Donut",
	"カフェ・ド・クリエ", "Cafe de Crie",
	"サーティワン", "Baskin Robbins", "Thirty One",
	"貢茶", "Gong Cha", "ゴンチャ",
	"ナナズグリーンティー", "nana's green tea",
	"エクセルシオール", "Excelsior",

	// Ramen & Soba/Udon
	"一蘭", "Ichiran",
	"一風堂", "Ippudo",
	"天下一品", "Tenkaippin",
	"幸楽苑", "Kourakuen",
	"日高屋", "Hidakaya",
	"蒙古タンメン中本", "Mouko Tanmen Nakamoto",
	"喜多方ラーメン坂内", "Bannai",
	"丸亀製麺", "Marugame Seimen", "Marugame Udon",
	"はなまるうどん", "Hanamaru Udon",
	"富士そば", "Fuji Soba",
	"小諸そば", "Komoro Soba",
	"ゆで太郎", "Yudetaro",
	"リンガーハット", "Ringer Hut",
	"来来亭", "Rairaiten",
	"山岡家", "Yamaokaya",

	// Sushi
	"スシロー", "Sushiro",
	"くら寿司", "Kura Sushi",
	"はま寿司", "Hama Sushi",
	"かっぱ寿司", "Kappa Sushi",
	"魚べい", "Uobei",
	"すしざんまい", "Sushi Zanmai",
	"板前寿司", "Itamae Sushi",

	// Izakaya
	"鳥貴族", "Torikizoku",
	"魚民", "Uotami",
	"笑笑", "Warawara",
	"白木屋", "Shirokiya",
	"和民", "Watami",
	"つぼ八", "Tsubohachi",
	"庄や", "Shoya",
	"串カツ田中", "Kushikatsu Tanaka",
	"磯丸水産", "Isomaru Suisan",
	"土間土間", "Domadoma",
	"金の蔵", "Kinnokura",

	// Steak & Curry & Others
	"いきなりステーキ", "Ikinari Steak",
	"カレーハウスCoCo壱番屋", "CoCo壱番屋", "CoCo Ichibanya",
	"ゴーゴーカレー", "Go Go Curry",
	"餃子の王将", "Gyoza no Ohsho",
	"大阪王将", "Osaka Ohsho",
	"築地銀だこ", "Gindaco",
}

// IsChain returns true if the name matches a known major restaurant chain in Japan.
func IsChain(name string) bool {
	for _, chain := range majorChains {
		if strings.Contains(name, chain) {
			return true
		}
	}
	return false
}

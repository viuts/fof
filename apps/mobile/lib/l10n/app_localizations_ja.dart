// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'フォグ・オブ・フレーバー';

  @override
  String get loadingMap => '食材を収穫中...';

  @override
  String errorLabel(String error) {
    return 'エラー: $error';
  }

  @override
  String get retry => '再試行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get submit => '送信';

  @override
  String get skip => 'スキップ';

  @override
  String get delete => '削除';

  @override
  String levelLabel(int level) {
    return 'LV. $level';
  }

  @override
  String nextExp(int exp) {
    return '次まで: $exp EXP';
  }

  @override
  String get discoverTaste => 'あなたの「味」を見つけよう';

  @override
  String get googleSignIn => 'Googleでサインイン';

  @override
  String failedToSignIn(String error) {
    return 'サインインに失敗しました: $error';
  }

  @override
  String unexpectedError(String error) {
    return '予期しないエラーが発生しました: $error';
  }

  @override
  String signInFailed(String error) {
    return 'サインイン失敗: $error';
  }

  @override
  String get questTitle => '冒険を始めよう';

  @override
  String get questCraving => '何を食べたい？';

  @override
  String get questDistance => '距離';

  @override
  String get questSpecific => 'こだわり条件';

  @override
  String get questHint => '例: \"家系\", \"静か\", \"辛い\"';

  @override
  String get questButton => 'クエストを探す';

  @override
  String get tabQuest => 'クエスト';

  @override
  String get tabJournal => '記録';

  @override
  String get tabMap => 'マップ';

  @override
  String get tabAwards => '実績';

  @override
  String get tabAccount => 'アカウント';

  @override
  String get statsTiles => 'タイルをクリア';

  @override
  String get statsShops => '訪問した店舗';

  @override
  String get statsIndie => 'インディーズ店舗';

  @override
  String get statsArea => '探索済みエリア';

  @override
  String get accountTitle => 'アカウントとプライバシー';

  @override
  String get privacySettings => 'プライバシー設定';

  @override
  String get freezeTracking => 'ログを一時停止';

  @override
  String get freezeSubtitle => 'GPS追跡を一時的に停止します';

  @override
  String get deleteHistory => '移動履歴を消去';

  @override
  String get deleteSubtitle => 'マップの霧をリセットします';

  @override
  String get preferences => '設定';

  @override
  String get language => '言語';

  @override
  String get languageName => '日本語';

  @override
  String get soundEffects => '効果音';

  @override
  String get logout => 'ログアウト';

  @override
  String get logoutConfirm => '本当にログアウトしますか？';

  @override
  String get selectCuisine => '料理カテゴリーを選択';

  @override
  String get journalTitle => '探索ジャーナル';

  @override
  String get neighborExplorer => '近隣の探索者';

  @override
  String arriveWithin(Object distance) {
    return 'あと${distance}mで到着です！';
  }

  @override
  String tilesClearedMsg(int count) {
    return '$count 個の新しいタイルをクリアしました。';
  }

  @override
  String get categoryWashoku => '和食';

  @override
  String get categorySushi => '寿司';

  @override
  String get categoryAgemono => '揚げ物';

  @override
  String get categoryYakitori => '焼き鳥';

  @override
  String get categoryYakiniku => '焼肉';

  @override
  String get categoryNikuryouri => '肉料理';

  @override
  String get categoryNabe => '鍋';

  @override
  String get categoryDon => '丼';

  @override
  String get categoryMen => 'うどん・そば他';

  @override
  String get categoryRamen => 'ラーメン';

  @override
  String get categoryKonamono => '粉もの';

  @override
  String get categoryYoshoku => '洋食';

  @override
  String get categoryEuropean => '欧州料理';

  @override
  String get categoryChinese => '中華料理';

  @override
  String get categoryKorean => '韓国料理';

  @override
  String get categoryEthnic => 'エスニック';

  @override
  String get categoryCurry => 'カレー';

  @override
  String get categoryIzakaya => '居酒屋';

  @override
  String get categoryBar => 'バー';

  @override
  String get categoryCafe => 'カフェ';

  @override
  String get categorySweets => 'スイーツ';

  @override
  String get categoryOther => 'その他';

  @override
  String get groupJapanese => '和食料理';

  @override
  String get groupNoodles => '麺類';

  @override
  String get groupWestern => '西洋・欧州料理';

  @override
  String get groupAsian => 'アジア・エスニック';

  @override
  String get groupDrinks => '居酒屋・バー';

  @override
  String get groupCafe => 'カフェ・スイーツ';

  @override
  String get groupOthers => 'その他';

  @override
  String get errorLocationUnavailable => '位置情報が利用できません';

  @override
  String get errorNoShopsFound => '対象のお店はありませんでした';

  @override
  String get errorQuestAlreadyActive => '既に進行中のクエストがあります';

  @override
  String get close => '閉じる';

  @override
  String get exploreAreaMsg => 'この地域を探索してください。お店の詳細を確認するには、フォグをクリアする必要があります。';

  @override
  String get locationLabel => '場所';

  @override
  String get explorationRadius => '探索半径';

  @override
  String get statusLabel => 'ステータス';

  @override
  String get visitedLabel => '訪問済み';

  @override
  String get visitRecordedMsg => '訪問を記録しました！フォグが晴れました。';

  @override
  String errorVisitFailed(String error) {
    return '訪問の記録に失敗しました: $error';
  }

  @override
  String visitRecordedExp(int exp) {
    return '訪問を記録しました！ $exp EXPを獲得';
  }

  @override
  String get visitThisShop => 'このお店に訪問する';

  @override
  String get away => ' 離れています';

  @override
  String get arrived => '到着！';

  @override
  String get enterShop => '入店';

  @override
  String get entering => '入店中...';

  @override
  String get verificationInProgress => '入店確認中';

  @override
  String get tooFarToEnter => '離れすぎています (25m以内に近づいてください)';

  @override
  String remainingTime(int minutes, int seconds) {
    return '残り $minutes分 $seconds秒';
  }

  @override
  String get howWasExperience => 'いかがでしたか？';

  @override
  String get visitReviewTitle => '訪問レビュー';

  @override
  String get visitedOn => '訪問日';

  @override
  String get yourReview => '自分のレビュー';

  @override
  String get noCommentProvided => 'コメントはありません。';

  @override
  String get commentOptional => 'コメント（任意）';

  @override
  String get shareThoughts => '感想を共有しましょう...';

  @override
  String levelUp(int level) {
    return 'レベルアップ！ 現在レベル $level';
  }

  @override
  String unlockedAchievement(String name) {
    return '🏆 実績解除: $name!';
  }

  @override
  String get noVisitsYet => 'まだ訪問履歴がありません。';

  @override
  String get mapStyle => 'マップスタイル';

  @override
  String get selectMapStyle => 'マップスタイルを選択';

  @override
  String get deleteHistoryTitle => '履歴を削除しますか？';

  @override
  String get deleteHistoryConfirm => 'これにより、マップ上のすべての霧がリセットされます。この操作は取り消せません。';

  @override
  String get pathHistoryDeleted => '移動履歴を削除しました。';

  @override
  String get openingHours => '営業時間';

  @override
  String get openStatus => '営業中';

  @override
  String get closedStatus => '営業時間外';

  @override
  String get closedToEnter => '現在は営業時間外です';

  @override
  String get hoursUnknown => '不明';

  @override
  String get questMode => 'クエストモード';

  @override
  String get cancelQuest => 'クエストをキャンセル';

  @override
  String get noHiddenGems => 'このカテゴリーの隠れた名店は近くに見つかりませんでした。';

  @override
  String get chooseCuisineQuest => '料理クエストを選択';

  @override
  String get selectCategoryHint => 'カテゴリーを選択して、隠れた名店を見つけましょう';

  @override
  String get questActive => 'クエスト実施中';

  @override
  String get toDestination => '目的地まで';

  @override
  String get revealOnArrival => 'お店の詳細は到着してからのお楽しみ！';

  @override
  String get noAchievementsYet => 'まだ実績がありません。';

  @override
  String get independentShop => '個人経営店';

  @override
  String hiddenGem(String name) {
    return '隠れた名店: $name';
  }

  @override
  String get monthJan => '1月';

  @override
  String get monthFeb => '2月';

  @override
  String get monthMar => '3月';

  @override
  String get monthApr => '4月';

  @override
  String get monthMay => '5月';

  @override
  String get monthJun => '6月';

  @override
  String get monthJul => '7月';

  @override
  String get monthAug => '8月';

  @override
  String get monthSep => '9月';

  @override
  String get monthOct => '10月';

  @override
  String get monthNov => '11月';

  @override
  String get monthDec => '12月';

  @override
  String get achNameFirstSteps => 'はじめの一歩';

  @override
  String get achDescFirstSteps => '初めてお店を訪問する。';

  @override
  String get achNameRamenFan => 'ラーメンファン';

  @override
  String get achDescRamenFan => 'ラーメン店を3軒訪問する。';

  @override
  String get achNameChainBreaker => 'チェーン・ブレイカー';

  @override
  String get achDescChainBreaker => '個人経営（非チェーン）の店を10軒訪問する。';

  @override
  String get achNameLightBringer => 'ライト・ブリンガー';

  @override
  String get achDescLightBringer => '「ダイニング・ブラスト」（店舗訪問）を50回発生させる。';

  @override
  String get achNameCuisineAlchemist => '料理の錬金術師';

  @override
  String get achDescCuisineAlchemist => '5つの異なるカテゴリーの店を訪問する。';

  @override
  String get achNameNightOwl => 'ミッドナイト・スナック';

  @override
  String get achDescNightOwl => '午前0時から午前4時の間にお店を訪問する。';

  @override
  String get achNameFogRunner => 'フォグランナー';

  @override
  String get achDescFogRunner => '10軒の異なるお店を訪問する。';

  @override
  String get achNameLegendaryExplorer => 'レジェンダリー・エクスプローラー';

  @override
  String get achDescLegendaryExplorer => '200軒の異なるお店を訪問する。';

  @override
  String get achNameRamenMaster => 'ラーメンマスター';

  @override
  String get achDescRamenMaster => 'ラーメン店を15軒訪問する。';

  @override
  String get achNameGourmetKing => 'グルメキング';

  @override
  String get achDescGourmetKing => '15種類の異なるカテゴリーのお店を訪問する。';

  @override
  String get achNameMorningBird => 'モーニングバード';

  @override
  String get achDescMorningBird => '午前6時から9時の間に店舗を訪問する。';

  @override
  String get achNameWeekendWarrior => 'ウィークエンド・ウォーリアー';

  @override
  String get achDescWeekendWarrior => '週末に5回店舗を訪問する。';

  @override
  String get achCategoryAll => 'すべて';

  @override
  String get achCategoryExploration => '探索';

  @override
  String get achCategoryFoodie => '食通';

  @override
  String get achCategoryQuest => 'クエスト';

  @override
  String get achCategorySocial => '社交';

  @override
  String get achievementTabTitle => '実績';

  @override
  String get deselectAll => '全てクリア';

  @override
  String get selectAll => '全て選択';

  @override
  String journalDate(String day, String month) {
    return '$month$day日';
  }

  @override
  String get editProfile => 'プロフィールを編集';

  @override
  String get changeName => '名前を変更';

  @override
  String get changePhoto => '写真を変更';

  @override
  String get displayName => '表示名';

  @override
  String get editReview => 'レビューを編集';

  @override
  String get save => '保存';

  @override
  String get addPhoto => '写真を追加';

  @override
  String get questRating => '評価';

  @override
  String get questOpenNow => '営業中のみ';

  @override
  String get questRatingExcellent => '最高 🔥';

  @override
  String get questRatingAverage => '良店 👍';

  @override
  String get questRatingMixed => '賛否両論 🎲';

  @override
  String get visitComplete => '到着しました！ 🎉';

  @override
  String get photosLabel => '写真';

  @override
  String get viewReview => 'レビューを見る';

  @override
  String get reservable => '予約可';

  @override
  String get notReservable => '予約不可';

  @override
  String get website => 'ウェブサイト';

  @override
  String get achNameExplorerLv1 => 'エクスプローラー Lv.1';

  @override
  String get achDescExplorerLv1 => '5軒の異なるお店を訪問する。';

  @override
  String get achNameExplorerLv2 => 'エクスプローラー Lv.2';

  @override
  String get achDescExplorerLv2 => '25軒の異なるお店を訪問する。';

  @override
  String get achNameExplorerLv3 => 'エクスプローラー Lv.3';

  @override
  String get achDescExplorerLv3 => '100軒の異なるお店を訪問する。';

  @override
  String get achNameMasterExplorer => 'マスター・エクスプローラー';

  @override
  String get achDescMasterExplorer => '500軒の異なるお店を訪問する。';

  @override
  String get achNameGodOfWalk => '散歩の神';

  @override
  String get achDescGodOfWalk => '1000軒の異なるお店を訪問する。';

  @override
  String get achNameRamenLover => 'ラーメン通';

  @override
  String get achDescRamenLover => 'ラーメン店を10軒訪問する。';

  @override
  String get achNameRamenGod => 'ラーメン神';

  @override
  String get achDescRamenGod => 'ラーメン店を50軒訪問する。';

  @override
  String get achNameCafeFan => 'カフェファン';

  @override
  String get achDescCafeFan => 'カフェを3軒訪問する。';

  @override
  String get achNameCafeLover => 'カフェ好き';

  @override
  String get achDescCafeLover => 'カフェを10軒訪問する。';

  @override
  String get achNameCafeMaster => 'カフェマスター';

  @override
  String get achDescCafeMaster => 'カフェを30軒訪問する。';

  @override
  String get achNameSushiFan => '寿司ファン';

  @override
  String get achDescSushiFan => '寿司屋を3軒訪問する。';

  @override
  String get achNameSushiLover => '寿司好き';

  @override
  String get achDescSushiLover => '寿司屋を10軒訪問する。';

  @override
  String get achNameSushiMaster => '寿司マスター';

  @override
  String get achDescSushiMaster => '寿司屋を30軒訪問する。';

  @override
  String get achNameYakinikuFan => '焼肉ファン';

  @override
  String get achDescYakinikuFan => '焼肉屋を3軒訪問する。';

  @override
  String get achNameYakinikuLover => '焼肉好き';

  @override
  String get achDescYakinikuLover => '焼肉屋を10軒訪問する。';

  @override
  String get achNameYakinikuMaster => '焼肉マスター';

  @override
  String get achDescYakinikuMaster => '焼肉屋を30軒訪問する。';

  @override
  String get achNameIzakayaFan => '居酒屋ファン';

  @override
  String get achDescIzakayaFan => '居酒屋を3軒訪問する。';

  @override
  String get achNameIzakayaLover => '居酒屋好き';

  @override
  String get achDescIzakayaLover => '居酒屋を10軒訪問する。';

  @override
  String get achNameIzakayaMaster => '居酒屋マスター';

  @override
  String get achDescIzakayaMaster => '居酒屋を30軒訪問する。';

  @override
  String get achNameBarFan => 'バーファン';

  @override
  String get achDescBarFan => 'バーを3軒訪問する。';

  @override
  String get achNameBarLover => 'バー好き';

  @override
  String get achDescBarLover => 'バーを10軒訪問する。';

  @override
  String get achNameBarMaster => 'バーマスター';

  @override
  String get achDescBarMaster => 'バーを30軒訪問する。';

  @override
  String get achNameSweetsFan => 'スイーツファン';

  @override
  String get achDescSweetsFan => 'スイーツ店を3軒訪問する。';

  @override
  String get achNameSweetsLover => 'スイーツ好き';

  @override
  String get achDescSweetsLover => 'スイーツ店を10軒訪問する。';

  @override
  String get achNameSweetsMaster => 'スイーツマスター';

  @override
  String get achDescSweetsMaster => 'スイーツ店を30軒訪問する。';

  @override
  String get achNameCurryFan => 'カレーファン';

  @override
  String get achDescCurryFan => 'カレー屋を3軒訪問する。';

  @override
  String get achNameCurryLover => 'カレー好き';

  @override
  String get achDescCurryLover => 'カレー屋を10軒訪問する。';

  @override
  String get achNameCurryMaster => 'カレーマスター';

  @override
  String get achDescCurryMaster => 'カレー屋を30軒訪問する。';

  @override
  String get achNameEuroFan => '洋食ファン';

  @override
  String get achDescEuroFan => '洋食・欧州料理店を3軒訪問する。';

  @override
  String get achNameEuroLover => '洋食好き';

  @override
  String get achDescEuroLover => '洋食・欧州料理店を10軒訪問する。';

  @override
  String get achNameEuroMaster => '洋食マスター';

  @override
  String get achDescEuroMaster => '洋食・欧州料理店を30軒訪問する。';

  @override
  String get achNameChineseFan => '中華ファン';

  @override
  String get achDescChineseFan => '中華料理店を3軒訪問する。';

  @override
  String get achNameChineseLover => '中華好き';

  @override
  String get achDescChineseLover => '中華料理店を10軒訪問する。';

  @override
  String get achNameChineseMaster => '中華マスター';

  @override
  String get achDescChineseMaster => '中華料理店を30軒訪問する。';

  @override
  String get achNameDonFan => '丼ファン';

  @override
  String get achDescDonFan => '丼ものの店を3軒訪問する。';

  @override
  String get achNameDonLover => '丼好き';

  @override
  String get achDescDonLover => '丼ものの店を10軒訪問する。';

  @override
  String get achNameDonMaster => '丼マスター';

  @override
  String get achDescDonMaster => '丼ものの店を30軒訪問する。';

  @override
  String get achNameWashokuFan => '和食ファン';

  @override
  String get achDescWashokuFan => '和食店を3軒訪問する。';

  @override
  String get achNameWashokuLover => '和食好き';

  @override
  String get achDescWashokuLover => '和食店を10軒訪問する。';

  @override
  String get achNameWashokuMaster => '和食マスター';

  @override
  String get achDescWashokuMaster => '和食店を30軒訪問する。';

  @override
  String get achNameYakitoriFan => '焼き鳥ファン';

  @override
  String get achDescYakitoriFan => '焼き鳥屋を3軒訪問する。';

  @override
  String get achNameYakitoriLover => '焼き鳥好き';

  @override
  String get achDescYakitoriLover => '焼き鳥屋を10軒訪問する。';

  @override
  String get achNameYakitoriMaster => '焼き鳥マスター';

  @override
  String get achDescYakitoriMaster => '焼き鳥屋を30軒訪問する。';

  @override
  String get achNameOmnivore => '雑食系';

  @override
  String get achDescOmnivore => '20種類の異なるカテゴリーのお店を訪問する。';

  @override
  String get achNameIndieSpirit => 'インディーズ魂';

  @override
  String get achDescIndieSpirit => '個人経営店を50軒訪問する。';

  @override
  String get achNameChainLover => 'チェーン店好き';

  @override
  String get achDescChainLover => 'チェーン店を10軒訪問する。';

  @override
  String get achNameLunchRush => 'ランチラッシュ';

  @override
  String get achDescLunchRush => '午前11時半から午後1時半の間にお店を訪問する。';

  @override
  String get achNameAfternoonTea => 'アフタヌーンティー';

  @override
  String get achDescAfternoonTea => '午後3時から5時の間にお店を訪問する。';

  @override
  String get achNameDinnerTime => 'ディナータイム';

  @override
  String get achDescDinnerTime => '午後6時から9時の間にお店を訪問する。';

  @override
  String get achNameWeekdayWorker => '平日ワーカー';

  @override
  String get achDescWeekdayWorker => '平日に10軒のお店を訪問する。';

  @override
  String get achNameFridayNight => 'TGIF';

  @override
  String get achDescFridayNight => '金曜日の夜（18時以降）に店を訪問する';

  @override
  String get paywallTitle => 'FOG OF FLAVOR PRO';

  @override
  String get paywallHeroTitle => '試用期間が終了しました';

  @override
  String get paywallHeroSubtitle =>
      '1ヶ月の無料トライアル期間が終了しました。引き続き美食の旅を記録するには、Fog of Flavor Proへのアップグレードが必要です。';

  @override
  String get paywallPlanBestValue => '一番人気';

  @override
  String get paywallPlanPromoted => 'おすすめ';

  @override
  String get paywallPlanAnnualDesc => '多くの探索者が選んでいます';

  @override
  String get paywallPlanLifetimeDesc => '一度の支払いで永久に利用可能';

  @override
  String get paywallContinueButton => '次へ進む';

  @override
  String get paywallRestoreButton => '購入情報を復元';

  @override
  String get paywallSignOutButton => 'ログアウト / アカウント切り替え';

  @override
  String get paywallPlanMonthly => '月間プラン';

  @override
  String get paywallPlanAnnual => '年間プラン';

  @override
  String get paywallPlanLifetime => '買い切りプラン';

  @override
  String get paywallPlanDefault => 'Proプラン';

  @override
  String get accountProMember => 'Proメンバー';

  @override
  String get accountProUpgrade => 'Proにアップグレード';

  @override
  String get accountProActive => 'サポートありがとうございます！';

  @override
  String get accountProUnlock => '限定マップテーマなどの特典を解放';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get signInButton => 'ログイン';

  @override
  String get signUpButton => '新規登録';

  @override
  String get noAccountPrompt => 'アカウントをお持ちでないですか？';

  @override
  String get alreadyHaveAccountPrompt => '既にアカウントをお持ちですか？';

  @override
  String get invalidEmailError => '有効なメールアドレスを入力してください';

  @override
  String get shortPasswordError => 'パスワードは6文字以上で入力してください';

  @override
  String get passwordsDoNotMatchError => 'パスワードが一致しません';

  @override
  String get confirmPasswordLabel => 'パスワード（確認）';

  @override
  String get fogDiscovery => '霧の踏破状況';

  @override
  String get clearedArea => '解除済み面積';

  @override
  String get worldCoverage => '世界踏破率';

  @override
  String get tabRanking => 'ランキング';

  @override
  String get rankingTypeArea => 'エリア';

  @override
  String get rankingTypeLevel => 'レベル';

  @override
  String get rankingTypeVisits => '店舗数';

  @override
  String get rankingTypeCategory => 'カテゴリー';

  @override
  String get rankingLabelClearedArea => '解除済みエリア';

  @override
  String get rankingLabelLevel => 'レベル';

  @override
  String get rankingLabelShopsVisited => '訪問店舗数';

  @override
  String get rankingLabelVisits => '訪問回数';

  @override
  String get rankingLabelPoints => 'ポイント';
}

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
  String get questTitle => '冒険をデザイン';

  @override
  String get questCraving => '何を食べたい？';

  @override
  String get questDistance => '距離';

  @override
  String get questSpecific => 'こだわり条件';

  @override
  String get questHint => '例: \"家系\", \"静か\", \"辛い\"';

  @override
  String get questButton => 'サイコロを振る';

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
  String get categoryMen => '麺';

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
  String get errorLocationUnavailable => '位置情報が利用できません';

  @override
  String get errorNoShopsFound => '条件に一致するショップが見つかりませんでした';

  @override
  String get close => '閉じる';

  @override
  String get exploreAreaMsg => 'この地域を探索してください。ショップの詳細を確認するには、フォグをクリアする必要があります。';

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
  String get visitThisShop => 'このショップに訪問する';

  @override
  String get away => ' 離れています';

  @override
  String get arrived => '到着！';

  @override
  String get enterShop => 'ショップに入る';

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
  String visitComplete(String shopName) {
    return '訪問完了: $shopName';
  }

  @override
  String get howWasExperience => 'いかがでしたか？';

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
  String get revealOnArrival => 'ショップの詳細は到着してからのお楽しみ！';

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
  String get achDescFirstSteps => '初めてショップを訪問する。';

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
  String get achDescNightOwl => '午前0時から午前4時の間にショップを訪問する。';

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
}

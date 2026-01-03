// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

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
  String get appTitle => 'フォグ・オブ・フレーバー';

  @override
  String get categoryRamen => 'ラーメン';

  @override
  String get categoryCafe => 'カフェ';

  @override
  String get categorySushi => '寿司';

  @override
  String get categoryYakiniku => '焼肉';

  @override
  String get categoryIzakaya => '居酒屋';

  @override
  String get categoryBar => 'バー';

  @override
  String get categoryDessert => 'デザート';

  @override
  String get categoryBurger => 'バーガー';

  @override
  String get categoryPub => 'パブ';

  @override
  String get categoryTacos => 'タコス';

  @override
  String get categoryOther => 'その他';

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
  String get visitThisShop => 'このショップに訪問する';

  @override
  String get away => ' 離れています';

  @override
  String get arrived => '到着しました！';

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
}

import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  Locale _currentLocale = const Locale('ja');

  Locale get currentLocale => _currentLocale;

  bool get isJapanese => _currentLocale.languageCode == 'ja';

  void setLocale(Locale locale) {
    if (_currentLocale == locale) return;
    _currentLocale = locale;
    notifyListeners();
  }

  void toggleLanguage() {
    if (isJapanese) {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('ja'));
    }
  }
}

class S {
  final Locale locale;
  S(this.locale);

  static S of(BuildContext context) {
    return _translations[Localizations.localeOf(context).languageCode] ?? _translations['ja']!;
  }

  static final Map<String, S> _translations = {
    'ja': S(const Locale('ja')),
    'en': S(const Locale('en')),
  };

  String get appTitle => isJa ? 'フォグ・オブ・フレーバー' : 'Fog of Flavor';
  
  // Tabs
  String get tabQuest => isJa ? 'クエスト' : 'Quest';
  String get tabJournal => isJa ? 'ジャーナル' : 'Journal';
  String get tabMap => isJa ? 'マップ' : 'Map';
  String get tabAwards => isJa ? 'アワード' : 'Awards';
  String get tabAccount => isJa ? 'アカウント' : 'Account';

  // Map Screen
  String get statsTiles => isJa ? 'タイルをクリア' : 'Tiles Cleared';
  String get statsShops => isJa ? '訪問した店舗' : 'Shops Visited';
  String get statsIndie => isJa ? 'インディーズ店舗' : 'Indie Shops';
  String get statsArea => isJa ? '探索済みエリア' : 'Area Explored';
  
  // Account Screen
  String get accountTitle => isJa ? 'アカウントとプライバシー' : 'Account & Privacy';
  String get privacySettings => isJa ? 'プライバシー設定' : 'Privacy Settings';
  String get freezeTracking => isJa ? 'ログを一時停止' : 'Freeze Tracking';
  String get freezeSubtitle => isJa ? 'GPS追跡を一時的に停止します' : 'Temporarily pause all GPS tracking';
  String get deleteHistory => isJa ? '移動履歴を消去' : 'Delete Path History';
  String get deleteSubtitle => isJa ? 'マップの霧をリセットします' : 'Permanently clear all cleared fog tiles';
  String get preferences => isJa ? '設定' : 'Preferences';
  String get language => isJa ? '言語' : 'Language';
  String get languageName => isJa ? '日本語' : 'English';
  String get soundEffects => isJa ? '効果音' : 'Sound Effects';
  String get logout => isJa ? 'ログアウト' : 'Log Out';

  // Quest Screen
  String get questTitle => isJa ? 'クエストモード' : 'Quest Mode';
  String get selectCuisine => isJa ? '料理カテゴリーを選択' : 'Select a Cuisine';
  String arriveWithin(double distance) => isJa 
      ? 'あと${distance.toInt()}mで到着です！' 
      : 'You are within ${distance.toInt()}m of your destination!';
  
  // Journal Screen
  String get journalTitle => isJa ? '探索ジャーナル' : 'Discovery Journal';
  String get neighborExplorer => isJa ? '近隣の探索者' : 'Neighborhood Explorer';
  String tilesClearedMsg(int count) => isJa 
      ? '$count 個の新しいタイルをクリアしました。' 
      : 'You cleared $count new fog tiles.';

  bool get isJa => locale.languageCode == 'ja';
}

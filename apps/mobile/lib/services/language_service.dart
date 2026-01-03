import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

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
  final AppLocalizations _l10n;

  S(this._l10n);

  static S of(BuildContext context) {
    return S(AppLocalizations.of(context)!);
  }

  String get appTitle => _l10n.appTitle;
  
  // Tabs
  String get tabQuest => _l10n.tabQuest;
  String get tabJournal => _l10n.tabJournal;
  String get tabMap => _l10n.tabMap;
  String get tabAwards => _l10n.tabAwards;
  String get tabAccount => _l10n.tabAccount;

  // Map Screen
  String get statsTiles => _l10n.statsTiles;
  String get statsShops => _l10n.statsShops;
  String get statsIndie => _l10n.statsIndie;
  String get statsArea => _l10n.statsArea;
  
  String get exploreAreaMsg => _l10n.exploreAreaMsg;
  String get locationLabel => _l10n.locationLabel;
  String get explorationRadius => _l10n.explorationRadius;
  String get statusLabel => _l10n.statusLabel;
  String get visitedLabel => _l10n.visitedLabel;
  String get visitRecordedMsg => _l10n.visitRecordedMsg;
  String errorVisitFailed(String error) => _l10n.errorVisitFailed(error);
  String get visitThisShop => _l10n.visitThisShop;
  String get close => _l10n.close;
  String get away => _l10n.away;
  String get arrived => _l10n.arrived;
  String get enterShop => _l10n.enterShop;
  String get entering => _l10n.entering;
  String get verificationInProgress => _l10n.verificationInProgress;
  String get tooFarToEnter => _l10n.tooFarToEnter;
  String remainingTime(int minutes, int seconds) => _l10n.remainingTime(minutes, seconds);
  
  // Account Screen
  String get accountTitle => _l10n.accountTitle;
  String get privacySettings => _l10n.privacySettings;
  String get freezeTracking => _l10n.freezeTracking;
  String get freezeSubtitle => _l10n.freezeSubtitle;
  String get deleteHistory => _l10n.deleteHistory;
  String get deleteSubtitle => _l10n.deleteSubtitle;
  String get preferences => _l10n.preferences;
  String get language => _l10n.language;
  String get languageName => _l10n.languageName;
  String get soundEffects => _l10n.soundEffects;
  String get logout => _l10n.logout;

  // Quest Screen
  String get questTitle => _l10n.questTitle;
  String get questCraving => _l10n.questCraving;
  String get questDistance => _l10n.questDistance;
  String get questSpecific => _l10n.questSpecific;
  String get questHint => _l10n.questHint;
  String get questButton => _l10n.questButton;
  String get selectCuisine => _l10n.selectCuisine;

  String get errorLocationUnavailable => _l10n.errorLocationUnavailable;
  String get errorNoShopsFound => _l10n.errorNoShopsFound;

  // Methods with arguments
  String arriveWithin(double distance) => _l10n.arriveWithin(distance.toInt());
  
  // Journal Screen
  String get journalTitle => _l10n.journalTitle;
  String get neighborExplorer => _l10n.neighborExplorer;
  String tilesClearedMsg(int count) => _l10n.tilesClearedMsg(count);

  bool get isJa => _l10n.localeName == 'ja';

  String translateCategory(String category) {
    switch (category.toUpperCase()) {
      case 'RAMEN':
        return _l10n.categoryRamen;
      case 'CAFE':
        return _l10n.categoryCafe;
      case 'SUSHI':
        return _l10n.categorySushi;
      case 'YAKINIKU':
        return _l10n.categoryYakiniku;
      case 'IZAKAYA':
        return _l10n.categoryIzakaya;
      case 'BAR':
        return _l10n.categoryBar;
      case 'DESSERT':
        return _l10n.categoryDessert;
      case 'BURGER':
        return _l10n.categoryBurger;
      case 'PUB':
        return _l10n.categoryPub;
      case 'TACOS':
        return _l10n.categoryTacos;
      default:
        return _l10n.categoryOther;
    }
  }
}

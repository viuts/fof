import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../api/fof/v1/shop.pbenum.dart';

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
  String remainingTime(int minutes, int seconds) =>
      _l10n.remainingTime(minutes, seconds);
  String visitRecordedExp(int exp) => _l10n.visitRecordedExp(exp);

  // Common
  String errorLabel(String error) => _l10n.errorLabel(error);
  String get retry => _l10n.retry;
  String get cancel => _l10n.cancel;
  String get submit => _l10n.submit;
  String get skip => _l10n.skip;
  String get delete => _l10n.delete;
  String levelLabel(int level) => _l10n.levelLabel(level);
  String nextExp(int exp) => _l10n.nextExp(exp);

  // Login Screen
  String get discoverTaste => _l10n.discoverTaste;
  String get googleSignIn => _l10n.googleSignIn;
  String failedToSignIn(String error) => _l10n.failedToSignIn(error);
  String unexpectedError(String error) => _l10n.unexpectedError(error);
  String signInFailed(String error) => _l10n.signInFailed(error);

  // Map Screen
  String visitComplete(String shopName) => _l10n.visitComplete(shopName);
  String get howWasExperience => _l10n.howWasExperience;
  String get commentOptional => _l10n.commentOptional;
  String get shareThoughts => _l10n.shareThoughts;
  String levelUp(int level) => _l10n.levelUp(level);
  String unlockedAchievement(String name) => _l10n.unlockedAchievement(name);

  // Journal Screen
  String get noVisitsYet => _l10n.noVisitsYet;
  String get monthJan => _l10n.monthJan;
  String get monthFeb => _l10n.monthFeb;
  String get monthMar => _l10n.monthMar;
  String get monthApr => _l10n.monthApr;
  String get monthMay => _l10n.monthMay;
  String get monthJun => _l10n.monthJun;
  String get monthJul => _l10n.monthJul;
  String get monthAug => _l10n.monthAug;
  String get monthSep => _l10n.monthSep;
  String get monthOct => _l10n.monthOct;
  String get monthNov => _l10n.monthNov;
  String get monthDec => _l10n.monthDec;

  // Account Screen
  String get mapStyle => _l10n.mapStyle;
  String get selectMapStyle => _l10n.selectMapStyle;
  String get deleteHistoryTitle => _l10n.deleteHistoryTitle;
  String get deleteHistoryConfirm => _l10n.deleteHistoryConfirm;
  String get pathHistoryDeleted => _l10n.pathHistoryDeleted;

  // Quest Screen
  String get questModeLabel => _l10n.questMode;
  String get cancelQuestLabel => _l10n.cancelQuest;
  String get noHiddenGems => _l10n.noHiddenGems;
  String get chooseCuisineQuest => _l10n.chooseCuisineQuest;
  String get selectCategoryHint => _l10n.selectCategoryHint;
  String get questActiveLabel => _l10n.questActive;
  String get toDestination => _l10n.toDestination;
  String get revealOnArrival => _l10n.revealOnArrival;

  // Achievements Screen
  String get noAchievementsYet => _l10n.noAchievementsYet;
  String get independentShop => _l10n.independentShop;
  String hiddenGem(String name) => _l10n.hiddenGem(name);

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
  String get openingHours => _l10n.openingHours;
  String get openStatus => _l10n.openStatus;
  String get closedStatus => _l10n.closedStatus;
  String get closedToEnter => _l10n.closedToEnter;
  String get hoursUnknown => _l10n.hoursUnknown;

  String get errorLocationUnavailable => _l10n.errorLocationUnavailable;
  String get errorNoShopsFound => _l10n.errorNoShopsFound;

  // Group Labels
  String get groupJapanese => _l10n.groupJapanese;
  String get groupNoodles => _l10n.groupNoodles;
  String get groupWestern => _l10n.groupWestern;
  String get groupAsian => _l10n.groupAsian;
  String get groupDrinks => _l10n.groupDrinks;
  String get groupCafe => _l10n.groupCafe;

  // Methods with arguments
  String arriveWithin(double distance) => _l10n.arriveWithin(distance.toInt());

  // Journal Screen
  String get journalTitle => _l10n.journalTitle;
  String get neighborExplorer => _l10n.neighborExplorer;
  String tilesClearedMsg(int count) => _l10n.tilesClearedMsg(count);

  bool get isJa => _l10n.localeName == 'ja';

  String translateCategory(FoodCategory category) {
    switch (category) {
      case FoodCategory.FOOD_CATEGORY_WASHOKU:
        return _l10n.categoryWashoku;
      case FoodCategory.FOOD_CATEGORY_SUSHI:
        return _l10n.categorySushi;
      case FoodCategory.FOOD_CATEGORY_AGEMONO:
        return _l10n.categoryAgemono;
      case FoodCategory.FOOD_CATEGORY_YAKITORI:
        return _l10n.categoryYakitori;
      case FoodCategory.FOOD_CATEGORY_YAKINIKU:
        return _l10n.categoryYakiniku;
      case FoodCategory.FOOD_CATEGORY_NIKURYOURI:
        return _l10n.categoryNikuryouri;
      case FoodCategory.FOOD_CATEGORY_NABE:
        return _l10n.categoryNabe;
      case FoodCategory.FOOD_CATEGORY_DON:
        return _l10n.categoryDon;
      case FoodCategory.FOOD_CATEGORY_MEN:
        return _l10n.categoryMen;
      case FoodCategory.FOOD_CATEGORY_RAMEN:
        return _l10n.categoryRamen;
      case FoodCategory.FOOD_CATEGORY_KONAMONO:
        return _l10n.categoryKonamono;
      case FoodCategory.FOOD_CATEGORY_YOSHOKU:
        return _l10n.categoryYoshoku;
      case FoodCategory.FOOD_CATEGORY_EUROPEAN:
        return _l10n.categoryEuropean;
      case FoodCategory.FOOD_CATEGORY_CHINESE:
        return _l10n.categoryChinese;
      case FoodCategory.FOOD_CATEGORY_KOREAN:
        return _l10n.categoryKorean;
      case FoodCategory.FOOD_CATEGORY_ETHNIC:
        return _l10n.categoryEthnic;
      case FoodCategory.FOOD_CATEGORY_CURRY:
        return _l10n.categoryCurry;
      case FoodCategory.FOOD_CATEGORY_IZAKAYA:
        return _l10n.categoryIzakaya;
      case FoodCategory.FOOD_CATEGORY_BAR:
        return _l10n.categoryBar;
      case FoodCategory.FOOD_CATEGORY_CAFE:
        return _l10n.categoryCafe;
      case FoodCategory.FOOD_CATEGORY_SWEETS:
        return _l10n.categorySweets;
      case FoodCategory.FOOD_CATEGORY_UNSPECIFIED:
      default:
        return _l10n.categoryOther;
    }
  }

  String get achCategoryAll => _l10n.achCategoryAll;
  String get selectAll => _l10n.selectAll;
  String get deselectAll => _l10n.deselectAll;
  String journalDate(String day, String month) => _l10n.journalDate(day, month);
}

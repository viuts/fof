// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get questTitle => 'DESIGN YOUR\nADVENTURE';

  @override
  String get questCraving => 'WHAT ARE YOU CRAVING?';

  @override
  String get questDistance => 'HOW FAR?';

  @override
  String get questSpecific => 'ANYTHING SPECIFIC?';

  @override
  String get questHint => 'e.g. \"Iekei\", \"Quiet\", \"Spicy\"';

  @override
  String get questButton => 'ROLL THE DICE';

  @override
  String get tabQuest => 'Quest';

  @override
  String get tabJournal => 'Journal';

  @override
  String get tabMap => 'Map';

  @override
  String get tabAwards => 'Awards';

  @override
  String get tabAccount => 'Account';

  @override
  String get statsTiles => 'Tiles Cleared';

  @override
  String get statsShops => 'Shops Visited';

  @override
  String get statsIndie => 'Indie Shops';

  @override
  String get statsArea => 'Area Explored';

  @override
  String get accountTitle => 'Account & Privacy';

  @override
  String get privacySettings => 'Privacy Settings';

  @override
  String get freezeTracking => 'Freeze Tracking';

  @override
  String get freezeSubtitle => 'Temporarily pause all GPS tracking';

  @override
  String get deleteHistory => 'Delete Path History';

  @override
  String get deleteSubtitle => 'Permanently clear all cleared fog tiles';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get languageName => 'English';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get logout => 'Log Out';

  @override
  String get selectCuisine => 'Select a Cuisine';

  @override
  String get journalTitle => 'Discovery Journal';

  @override
  String get neighborExplorer => 'Neighborhood Explorer';

  @override
  String arriveWithin(Object distance) {
    return 'You are within ${distance}m of your destination!';
  }

  @override
  String tilesClearedMsg(int count) {
    return 'You cleared $count new fog tiles.';
  }

  @override
  String get appTitle => 'Fog of Flavor';

  @override
  String get categoryRamen => 'RAMEN';

  @override
  String get categoryCafe => 'CAFE';

  @override
  String get categorySushi => 'SUSHI';

  @override
  String get categoryYakiniku => 'YAKINIKU';

  @override
  String get categoryIzakaya => 'IZAKAYA';

  @override
  String get categoryBar => 'BAR';

  @override
  String get categoryDessert => 'DESSERT';

  @override
  String get categoryBurger => 'BURGER';

  @override
  String get categoryPub => 'PUB';

  @override
  String get categoryTacos => 'TACOS';

  @override
  String get categoryOther => 'OTHER';

  @override
  String get errorLocationUnavailable => 'Location not available';

  @override
  String get errorNoShopsFound => 'No shops found matching your criteria';

  @override
  String get close => 'Close';

  @override
  String get exploreAreaMsg =>
      'Please explore this area. You need to clear the fog to see shop details.';

  @override
  String get locationLabel => 'Location';

  @override
  String get explorationRadius => 'Exploration Radius';

  @override
  String get statusLabel => 'Status';

  @override
  String get visitedLabel => 'Visited';

  @override
  String get visitRecordedMsg => 'Visit recorded! Fog cleared.';

  @override
  String errorVisitFailed(String error) {
    return 'Failed to record visit: $error';
  }

  @override
  String get visitThisShop => 'Visit this shop';

  @override
  String get away => 'away';

  @override
  String get arrived => 'ARRIVED!';

  @override
  String get enterShop => 'Enter Shop';

  @override
  String get entering => 'Entering...';

  @override
  String get verificationInProgress => 'Verification in progress';

  @override
  String get tooFarToEnter => 'Too far to enter (Move within 25m)';

  @override
  String remainingTime(int minutes, int seconds) {
    return '${minutes}m ${seconds}s remaining';
  }

  @override
  String get achNameFirstSteps => 'First Steps';

  @override
  String get achDescFirstSteps => 'Visit your first shop.';

  @override
  String get achNameRamenFan => 'Ramen Fan';

  @override
  String get achDescRamenFan => 'Visit 3 Ramen shops.';

  @override
  String get achNameChainBreaker => 'Chain-Breaker';

  @override
  String get achDescChainBreaker => 'Visit 10 Independent (non-chain) shops.';

  @override
  String get achNameLightBringer => 'Light-Bringer';

  @override
  String get achDescLightBringer =>
      'Trigger 50 \'Dining Blasts\' (Shop visits).';

  @override
  String get achNameCuisineAlchemist => 'Cuisine Alchemist';

  @override
  String get achDescCuisineAlchemist =>
      'Visit one shop from 5 different categories.';

  @override
  String get achNameNightOwl => 'Midnight Snack';

  @override
  String get achDescNightOwl => 'Visit a shop between 12:00 AM and 4:00 AM.';

  @override
  String get achCategoryAll => 'ALL';

  @override
  String get achCategoryExploration => 'EXPLORE';

  @override
  String get achCategoryFoodie => 'FOODIE';

  @override
  String get achCategoryQuest => 'QUEST';

  @override
  String get achCategorySocial => 'SOCIAL';

  @override
  String get achievementTabTitle => 'Achievements';
}

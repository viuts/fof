// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fog of Flavor';

  @override
  String get loadingMap => 'Gathering Ingredients...';

  @override
  String errorLabel(String error) {
    return 'Error: $error';
  }

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get submit => 'Submit';

  @override
  String get skip => 'Skip';

  @override
  String get delete => 'Delete';

  @override
  String levelLabel(int level) {
    return 'LV. $level';
  }

  @override
  String nextExp(int exp) {
    return 'Next: $exp EXP';
  }

  @override
  String get discoverTaste => 'Discover your taste.';

  @override
  String get googleSignIn => 'Sign in with Google';

  @override
  String failedToSignIn(String error) {
    return 'Failed to sign in: $error';
  }

  @override
  String unexpectedError(String error) {
    return 'An unexpected error occurred: $error';
  }

  @override
  String signInFailed(String error) {
    return 'Sign in failed: $error';
  }

  @override
  String get questTitle => 'START YOUR\nADVENTURE';

  @override
  String get questCraving => 'WHAT ARE YOU CRAVING?';

  @override
  String get questDistance => 'HOW FAR?';

  @override
  String get questSpecific => 'ANYTHING SPECIFIC?';

  @override
  String get questHint => 'e.g. \"Iekei\", \"Quiet\", \"Spicy\"';

  @override
  String get questButton => 'FIND QUEST';

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
  String get logoutConfirm => 'Are you sure you want to log out?';

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
  String get categoryWashoku => 'Washoku';

  @override
  String get categorySushi => 'Sushi';

  @override
  String get categoryAgemono => 'Fried';

  @override
  String get categoryYakitori => 'Yakitori';

  @override
  String get categoryYakiniku => 'Yakiniku';

  @override
  String get categoryNikuryouri => 'Meat';

  @override
  String get categoryNabe => 'Hot Pot';

  @override
  String get categoryDon => 'Rice Bowl';

  @override
  String get categoryMen => 'Udon, Soba & Others';

  @override
  String get categoryRamen => 'Ramen';

  @override
  String get categoryKonamono => 'Flour-based';

  @override
  String get categoryYoshoku => 'Western';

  @override
  String get categoryEuropean => 'European';

  @override
  String get categoryChinese => 'Chinese';

  @override
  String get categoryKorean => 'Korean';

  @override
  String get categoryEthnic => 'Ethnic';

  @override
  String get categoryCurry => 'Curry';

  @override
  String get categoryIzakaya => 'Izakaya';

  @override
  String get categoryBar => 'Bar';

  @override
  String get categoryCafe => 'Cafe';

  @override
  String get categorySweets => 'Sweets';

  @override
  String get categoryOther => 'Other';

  @override
  String get groupJapanese => 'Japanese Cuisine';

  @override
  String get groupNoodles => 'Noodles';

  @override
  String get groupWestern => 'Western & European';

  @override
  String get groupAsian => 'Asian & International';

  @override
  String get groupDrinks => 'Nightlife & Drinks';

  @override
  String get groupCafe => 'Café & Sweets';

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
  String visitRecordedExp(int exp) {
    return 'Visit recorded! Gained $exp EXP';
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
  String get howWasExperience => 'How was your experience?';

  @override
  String get visitReviewTitle => 'Visit Review';

  @override
  String get visitedOn => 'Visited on';

  @override
  String get yourReview => 'YOUR REVIEW';

  @override
  String get noCommentProvided => 'No comment provided.';

  @override
  String get commentOptional => 'Comment (optional)';

  @override
  String get shareThoughts => 'Share your thoughts...';

  @override
  String levelUp(int level) {
    return 'LEVEL UP! Now at Level $level';
  }

  @override
  String unlockedAchievement(String name) {
    return '🏆 UNLOCKED: $name!';
  }

  @override
  String get noVisitsYet => 'No visits yet.';

  @override
  String get mapStyle => 'Map Style';

  @override
  String get selectMapStyle => 'Select Map Style';

  @override
  String get deleteHistoryTitle => 'Delete History?';

  @override
  String get deleteHistoryConfirm =>
      'This will reset all cleared fog on your map. This action cannot be undone.';

  @override
  String get pathHistoryDeleted => 'Path history deleted.';

  @override
  String get openingHours => 'Opening Hours';

  @override
  String get openStatus => 'Open';

  @override
  String get closedStatus => 'Closed';

  @override
  String get closedToEnter => 'Outside of working hours';

  @override
  String get hoursUnknown => 'Unknown';

  @override
  String get questMode => 'Quest Mode';

  @override
  String get cancelQuest => 'Cancel Quest';

  @override
  String get noHiddenGems => 'No hidden gems found in this category nearby.';

  @override
  String get chooseCuisineQuest => 'Choose Your Cuisine Quest';

  @override
  String get selectCategoryHint =>
      'Select a category to discover a hidden restaurant';

  @override
  String get questActive => 'Quest Active';

  @override
  String get toDestination => 'to destination';

  @override
  String get revealOnArrival =>
      'Restaurant details will be revealed when you arrive';

  @override
  String get noAchievementsYet => 'No achievements yet.';

  @override
  String get independentShop => 'Independent Shop';

  @override
  String hiddenGem(String name) {
    return 'Hidden Gem: $name';
  }

  @override
  String get monthJan => 'JAN';

  @override
  String get monthFeb => 'FEB';

  @override
  String get monthMar => 'MAR';

  @override
  String get monthApr => 'APR';

  @override
  String get monthMay => 'MAY';

  @override
  String get monthJun => 'JUN';

  @override
  String get monthJul => 'JUL';

  @override
  String get monthAug => 'AUG';

  @override
  String get monthSep => 'SEP';

  @override
  String get monthOct => 'OCT';

  @override
  String get monthNov => 'NOV';

  @override
  String get monthDec => 'DEC';

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
  String get achNameFogRunner => 'Fog Runner';

  @override
  String get achDescFogRunner => 'Visit 10 different shops.';

  @override
  String get achNameLegendaryExplorer => 'Legendary Explorer';

  @override
  String get achDescLegendaryExplorer => 'Visit 200 different shops.';

  @override
  String get achNameRamenMaster => 'Ramen Master';

  @override
  String get achDescRamenMaster => 'Visit 15 Ramen shops.';

  @override
  String get achNameGourmetKing => 'Gourmet King';

  @override
  String get achDescGourmetKing =>
      'Visit one shop from 15 different categories.';

  @override
  String get achNameMorningBird => 'Morning Bird';

  @override
  String get achDescMorningBird => 'Visit a shop between 6:00 AM and 9:00 AM.';

  @override
  String get achNameWeekendWarrior => 'Weekend Warrior';

  @override
  String get achDescWeekendWarrior => 'Visit 5 shops on weekends.';

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

  @override
  String get deselectAll => 'Clear All';

  @override
  String get selectAll => 'Select All';

  @override
  String journalDate(String day, String month) {
    return '$day $month';
  }

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changeName => 'Change Name';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get displayName => 'Display Name';

  @override
  String get editReview => 'Edit Review';

  @override
  String get save => 'Save';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get questRating => 'RATING';

  @override
  String get questOpenNow => 'Open Now';

  @override
  String get questRatingExcellent => 'Excellent 🔥';

  @override
  String get questRatingAverage => 'Good 👍';

  @override
  String get questRatingMixed => 'Wildcard 🎲';

  @override
  String get visitComplete => 'ARRIVED! 🎉';

  @override
  String get photosLabel => 'PHOTOS';

  @override
  String get viewReview => 'View Review';
}

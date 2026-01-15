import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Fog of Flavor'**
  String get appTitle;

  /// No description provided for @loadingMap.
  ///
  /// In en, this message translates to:
  /// **'Gathering Ingredients...'**
  String get loadingMap;

  /// No description provided for @errorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorLabel(String error);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'LV. {level}'**
  String levelLabel(int level);

  /// No description provided for @nextExp.
  ///
  /// In en, this message translates to:
  /// **'Next: {exp} EXP'**
  String nextExp(int exp);

  /// No description provided for @discoverTaste.
  ///
  /// In en, this message translates to:
  /// **'Discover your taste.'**
  String get discoverTaste;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get googleSignIn;

  /// No description provided for @failedToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign in: {error}'**
  String failedToSignIn(String error);

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred: {error}'**
  String unexpectedError(String error);

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed: {error}'**
  String signInFailed(String error);

  /// No description provided for @questTitle.
  ///
  /// In en, this message translates to:
  /// **'START YOUR\nADVENTURE'**
  String get questTitle;

  /// No description provided for @questCraving.
  ///
  /// In en, this message translates to:
  /// **'WHAT ARE YOU CRAVING?'**
  String get questCraving;

  /// No description provided for @questDistance.
  ///
  /// In en, this message translates to:
  /// **'HOW FAR?'**
  String get questDistance;

  /// No description provided for @questSpecific.
  ///
  /// In en, this message translates to:
  /// **'ANYTHING SPECIFIC?'**
  String get questSpecific;

  /// No description provided for @questHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. \"Iekei\", \"Quiet\", \"Spicy\"'**
  String get questHint;

  /// No description provided for @questButton.
  ///
  /// In en, this message translates to:
  /// **'FIND QUEST'**
  String get questButton;

  /// No description provided for @tabQuest.
  ///
  /// In en, this message translates to:
  /// **'Quest'**
  String get tabQuest;

  /// No description provided for @tabJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get tabJournal;

  /// No description provided for @tabMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get tabMap;

  /// No description provided for @tabAwards.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get tabAwards;

  /// No description provided for @tabAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get tabAccount;

  /// No description provided for @statsTiles.
  ///
  /// In en, this message translates to:
  /// **'Tiles Cleared'**
  String get statsTiles;

  /// No description provided for @statsShops.
  ///
  /// In en, this message translates to:
  /// **'Shops Visited'**
  String get statsShops;

  /// No description provided for @statsIndie.
  ///
  /// In en, this message translates to:
  /// **'Indie Shops'**
  String get statsIndie;

  /// No description provided for @statsArea.
  ///
  /// In en, this message translates to:
  /// **'Area Explored'**
  String get statsArea;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account & Privacy'**
  String get accountTitle;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @freezeTracking.
  ///
  /// In en, this message translates to:
  /// **'Freeze Tracking'**
  String get freezeTracking;

  /// No description provided for @freezeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Temporarily pause all GPS tracking'**
  String get freezeSubtitle;

  /// No description provided for @deleteHistory.
  ///
  /// In en, this message translates to:
  /// **'Delete Path History'**
  String get deleteHistory;

  /// No description provided for @deleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently clear all cleared fog tiles'**
  String get deleteSubtitle;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @selectCuisine.
  ///
  /// In en, this message translates to:
  /// **'Select a Cuisine'**
  String get selectCuisine;

  /// No description provided for @journalTitle.
  ///
  /// In en, this message translates to:
  /// **'Discovery Journal'**
  String get journalTitle;

  /// No description provided for @neighborExplorer.
  ///
  /// In en, this message translates to:
  /// **'Neighborhood Explorer'**
  String get neighborExplorer;

  /// No description provided for @arriveWithin.
  ///
  /// In en, this message translates to:
  /// **'You are within {distance}m of your destination!'**
  String arriveWithin(Object distance);

  /// No description provided for @tilesClearedMsg.
  ///
  /// In en, this message translates to:
  /// **'You cleared {count} new fog tiles.'**
  String tilesClearedMsg(int count);

  /// No description provided for @categoryWashoku.
  ///
  /// In en, this message translates to:
  /// **'Washoku'**
  String get categoryWashoku;

  /// No description provided for @categorySushi.
  ///
  /// In en, this message translates to:
  /// **'Sushi'**
  String get categorySushi;

  /// No description provided for @categoryAgemono.
  ///
  /// In en, this message translates to:
  /// **'Fried'**
  String get categoryAgemono;

  /// No description provided for @categoryYakitori.
  ///
  /// In en, this message translates to:
  /// **'Yakitori'**
  String get categoryYakitori;

  /// No description provided for @categoryYakiniku.
  ///
  /// In en, this message translates to:
  /// **'Yakiniku'**
  String get categoryYakiniku;

  /// No description provided for @categoryNikuryouri.
  ///
  /// In en, this message translates to:
  /// **'Meat'**
  String get categoryNikuryouri;

  /// No description provided for @categoryNabe.
  ///
  /// In en, this message translates to:
  /// **'Hot Pot'**
  String get categoryNabe;

  /// No description provided for @categoryDon.
  ///
  /// In en, this message translates to:
  /// **'Rice Bowl'**
  String get categoryDon;

  /// No description provided for @categoryMen.
  ///
  /// In en, this message translates to:
  /// **'Udon, Soba & Others'**
  String get categoryMen;

  /// No description provided for @categoryRamen.
  ///
  /// In en, this message translates to:
  /// **'Ramen'**
  String get categoryRamen;

  /// No description provided for @categoryKonamono.
  ///
  /// In en, this message translates to:
  /// **'Flour-based'**
  String get categoryKonamono;

  /// No description provided for @categoryYoshoku.
  ///
  /// In en, this message translates to:
  /// **'Western'**
  String get categoryYoshoku;

  /// No description provided for @categoryEuropean.
  ///
  /// In en, this message translates to:
  /// **'European'**
  String get categoryEuropean;

  /// No description provided for @categoryChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get categoryChinese;

  /// No description provided for @categoryKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get categoryKorean;

  /// No description provided for @categoryEthnic.
  ///
  /// In en, this message translates to:
  /// **'Ethnic'**
  String get categoryEthnic;

  /// No description provided for @categoryCurry.
  ///
  /// In en, this message translates to:
  /// **'Curry'**
  String get categoryCurry;

  /// No description provided for @categoryIzakaya.
  ///
  /// In en, this message translates to:
  /// **'Izakaya'**
  String get categoryIzakaya;

  /// No description provided for @categoryBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get categoryBar;

  /// No description provided for @categoryCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get categoryCafe;

  /// No description provided for @categorySweets.
  ///
  /// In en, this message translates to:
  /// **'Sweets'**
  String get categorySweets;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @groupJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese Cuisine'**
  String get groupJapanese;

  /// No description provided for @groupNoodles.
  ///
  /// In en, this message translates to:
  /// **'Noodles'**
  String get groupNoodles;

  /// No description provided for @groupWestern.
  ///
  /// In en, this message translates to:
  /// **'Western & European'**
  String get groupWestern;

  /// No description provided for @groupAsian.
  ///
  /// In en, this message translates to:
  /// **'Asian & International'**
  String get groupAsian;

  /// No description provided for @groupDrinks.
  ///
  /// In en, this message translates to:
  /// **'Nightlife & Drinks'**
  String get groupDrinks;

  /// No description provided for @groupCafe.
  ///
  /// In en, this message translates to:
  /// **'Café & Sweets'**
  String get groupCafe;

  /// No description provided for @groupOthers.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get groupOthers;

  /// No description provided for @errorLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location not available'**
  String get errorLocationUnavailable;

  /// No description provided for @errorNoShopsFound.
  ///
  /// In en, this message translates to:
  /// **'No shops found matching your criteria'**
  String get errorNoShopsFound;

  /// No description provided for @errorQuestAlreadyActive.
  ///
  /// In en, this message translates to:
  /// **'You already have an active quest'**
  String get errorQuestAlreadyActive;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @exploreAreaMsg.
  ///
  /// In en, this message translates to:
  /// **'Please explore this area. You need to clear the fog to see shop details.'**
  String get exploreAreaMsg;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @explorationRadius.
  ///
  /// In en, this message translates to:
  /// **'Exploration Radius'**
  String get explorationRadius;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @visitedLabel.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get visitedLabel;

  /// No description provided for @visitRecordedMsg.
  ///
  /// In en, this message translates to:
  /// **'Visit recorded! Fog cleared.'**
  String get visitRecordedMsg;

  /// No description provided for @errorVisitFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to record visit: {error}'**
  String errorVisitFailed(String error);

  /// No description provided for @visitRecordedExp.
  ///
  /// In en, this message translates to:
  /// **'Visit recorded! Gained {exp} EXP'**
  String visitRecordedExp(int exp);

  /// No description provided for @visitThisShop.
  ///
  /// In en, this message translates to:
  /// **'Visit this shop'**
  String get visitThisShop;

  /// No description provided for @away.
  ///
  /// In en, this message translates to:
  /// **'away'**
  String get away;

  /// No description provided for @arrived.
  ///
  /// In en, this message translates to:
  /// **'ARRIVED!'**
  String get arrived;

  /// No description provided for @enterShop.
  ///
  /// In en, this message translates to:
  /// **'Enter Shop'**
  String get enterShop;

  /// No description provided for @entering.
  ///
  /// In en, this message translates to:
  /// **'Entering...'**
  String get entering;

  /// No description provided for @verificationInProgress.
  ///
  /// In en, this message translates to:
  /// **'Verification in progress'**
  String get verificationInProgress;

  /// No description provided for @tooFarToEnter.
  ///
  /// In en, this message translates to:
  /// **'Too far to enter (Move within 25m)'**
  String get tooFarToEnter;

  /// No description provided for @remainingTime.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m {seconds}s remaining'**
  String remainingTime(int minutes, int seconds);

  /// No description provided for @howWasExperience.
  ///
  /// In en, this message translates to:
  /// **'How was your experience?'**
  String get howWasExperience;

  /// No description provided for @visitReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Visit Review'**
  String get visitReviewTitle;

  /// No description provided for @visitedOn.
  ///
  /// In en, this message translates to:
  /// **'Visited on'**
  String get visitedOn;

  /// No description provided for @yourReview.
  ///
  /// In en, this message translates to:
  /// **'YOUR REVIEW'**
  String get yourReview;

  /// No description provided for @noCommentProvided.
  ///
  /// In en, this message translates to:
  /// **'No comment provided.'**
  String get noCommentProvided;

  /// No description provided for @commentOptional.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get commentOptional;

  /// No description provided for @shareThoughts.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts...'**
  String get shareThoughts;

  /// No description provided for @levelUp.
  ///
  /// In en, this message translates to:
  /// **'LEVEL UP! Now at Level {level}'**
  String levelUp(int level);

  /// No description provided for @unlockedAchievement.
  ///
  /// In en, this message translates to:
  /// **'🏆 UNLOCKED: {name}!'**
  String unlockedAchievement(String name);

  /// No description provided for @noVisitsYet.
  ///
  /// In en, this message translates to:
  /// **'No visits yet.'**
  String get noVisitsYet;

  /// No description provided for @mapStyle.
  ///
  /// In en, this message translates to:
  /// **'Map Style'**
  String get mapStyle;

  /// No description provided for @selectMapStyle.
  ///
  /// In en, this message translates to:
  /// **'Select Map Style'**
  String get selectMapStyle;

  /// No description provided for @deleteHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete History?'**
  String get deleteHistoryTitle;

  /// No description provided for @deleteHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will reset all cleared fog on your map. This action cannot be undone.'**
  String get deleteHistoryConfirm;

  /// No description provided for @pathHistoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Path history deleted.'**
  String get pathHistoryDeleted;

  /// No description provided for @openingHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get openingHours;

  /// No description provided for @openStatus.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openStatus;

  /// No description provided for @closedStatus.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closedStatus;

  /// No description provided for @closedToEnter.
  ///
  /// In en, this message translates to:
  /// **'Outside of working hours'**
  String get closedToEnter;

  /// No description provided for @hoursUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get hoursUnknown;

  /// No description provided for @questMode.
  ///
  /// In en, this message translates to:
  /// **'Quest Mode'**
  String get questMode;

  /// No description provided for @cancelQuest.
  ///
  /// In en, this message translates to:
  /// **'Cancel Quest'**
  String get cancelQuest;

  /// No description provided for @noHiddenGems.
  ///
  /// In en, this message translates to:
  /// **'No hidden gems found in this category nearby.'**
  String get noHiddenGems;

  /// No description provided for @chooseCuisineQuest.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Cuisine Quest'**
  String get chooseCuisineQuest;

  /// No description provided for @selectCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Select a category to discover a hidden restaurant'**
  String get selectCategoryHint;

  /// No description provided for @questActive.
  ///
  /// In en, this message translates to:
  /// **'Quest Active'**
  String get questActive;

  /// No description provided for @toDestination.
  ///
  /// In en, this message translates to:
  /// **'to destination'**
  String get toDestination;

  /// No description provided for @revealOnArrival.
  ///
  /// In en, this message translates to:
  /// **'Restaurant details will be revealed when you arrive'**
  String get revealOnArrival;

  /// No description provided for @noAchievementsYet.
  ///
  /// In en, this message translates to:
  /// **'No achievements yet.'**
  String get noAchievementsYet;

  /// No description provided for @independentShop.
  ///
  /// In en, this message translates to:
  /// **'Independent Shop'**
  String get independentShop;

  /// No description provided for @hiddenGem.
  ///
  /// In en, this message translates to:
  /// **'Hidden Gem: {name}'**
  String hiddenGem(String name);

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'JAN'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'FEB'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'MAR'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'APR'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'MAY'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'JUN'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'JUL'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'AUG'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'SEP'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'OCT'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'NOV'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'DEC'**
  String get monthDec;

  /// No description provided for @achNameFirstSteps.
  ///
  /// In en, this message translates to:
  /// **'First Steps'**
  String get achNameFirstSteps;

  /// No description provided for @achDescFirstSteps.
  ///
  /// In en, this message translates to:
  /// **'Visit your first shop.'**
  String get achDescFirstSteps;

  /// No description provided for @achNameRamenFan.
  ///
  /// In en, this message translates to:
  /// **'Ramen Fan'**
  String get achNameRamenFan;

  /// No description provided for @achDescRamenFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Ramen shops.'**
  String get achDescRamenFan;

  /// No description provided for @achNameChainBreaker.
  ///
  /// In en, this message translates to:
  /// **'Chain-Breaker'**
  String get achNameChainBreaker;

  /// No description provided for @achDescChainBreaker.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Independent (non-chain) shops.'**
  String get achDescChainBreaker;

  /// No description provided for @achNameLightBringer.
  ///
  /// In en, this message translates to:
  /// **'Light-Bringer'**
  String get achNameLightBringer;

  /// No description provided for @achDescLightBringer.
  ///
  /// In en, this message translates to:
  /// **'Trigger 50 \'Dining Blasts\' (Shop visits).'**
  String get achDescLightBringer;

  /// No description provided for @achNameCuisineAlchemist.
  ///
  /// In en, this message translates to:
  /// **'Cuisine Alchemist'**
  String get achNameCuisineAlchemist;

  /// No description provided for @achDescCuisineAlchemist.
  ///
  /// In en, this message translates to:
  /// **'Visit one shop from 5 different categories.'**
  String get achDescCuisineAlchemist;

  /// No description provided for @achNameNightOwl.
  ///
  /// In en, this message translates to:
  /// **'Midnight Snack'**
  String get achNameNightOwl;

  /// No description provided for @achDescNightOwl.
  ///
  /// In en, this message translates to:
  /// **'Visit a shop between 12:00 AM and 4:00 AM.'**
  String get achDescNightOwl;

  /// No description provided for @achNameFogRunner.
  ///
  /// In en, this message translates to:
  /// **'Fog Runner'**
  String get achNameFogRunner;

  /// No description provided for @achDescFogRunner.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 different shops.'**
  String get achDescFogRunner;

  /// No description provided for @achNameLegendaryExplorer.
  ///
  /// In en, this message translates to:
  /// **'Legendary Explorer'**
  String get achNameLegendaryExplorer;

  /// No description provided for @achDescLegendaryExplorer.
  ///
  /// In en, this message translates to:
  /// **'Visit 200 different shops.'**
  String get achDescLegendaryExplorer;

  /// No description provided for @achNameRamenMaster.
  ///
  /// In en, this message translates to:
  /// **'Ramen Master'**
  String get achNameRamenMaster;

  /// No description provided for @achDescRamenMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 15 Ramen shops.'**
  String get achDescRamenMaster;

  /// No description provided for @achNameGourmetKing.
  ///
  /// In en, this message translates to:
  /// **'Gourmet King'**
  String get achNameGourmetKing;

  /// No description provided for @achDescGourmetKing.
  ///
  /// In en, this message translates to:
  /// **'Visit one shop from 15 different categories.'**
  String get achDescGourmetKing;

  /// No description provided for @achNameMorningBird.
  ///
  /// In en, this message translates to:
  /// **'Morning Bird'**
  String get achNameMorningBird;

  /// No description provided for @achDescMorningBird.
  ///
  /// In en, this message translates to:
  /// **'Visit a shop between 6:00 AM and 9:00 AM.'**
  String get achDescMorningBird;

  /// No description provided for @achNameWeekendWarrior.
  ///
  /// In en, this message translates to:
  /// **'Weekend Warrior'**
  String get achNameWeekendWarrior;

  /// No description provided for @achDescWeekendWarrior.
  ///
  /// In en, this message translates to:
  /// **'Visit 5 shops on weekends.'**
  String get achDescWeekendWarrior;

  /// No description provided for @achCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get achCategoryAll;

  /// No description provided for @achCategoryExploration.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE'**
  String get achCategoryExploration;

  /// No description provided for @achCategoryFoodie.
  ///
  /// In en, this message translates to:
  /// **'FOODIE'**
  String get achCategoryFoodie;

  /// No description provided for @achCategoryQuest.
  ///
  /// In en, this message translates to:
  /// **'QUEST'**
  String get achCategoryQuest;

  /// No description provided for @achCategorySocial.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL'**
  String get achCategorySocial;

  /// No description provided for @achievementTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementTabTitle;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get deselectAll;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @journalDate.
  ///
  /// In en, this message translates to:
  /// **'{day} {month}'**
  String journalDate(String day, String month);

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @editReview.
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReview;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @questRating.
  ///
  /// In en, this message translates to:
  /// **'RATING'**
  String get questRating;

  /// No description provided for @questOpenNow.
  ///
  /// In en, this message translates to:
  /// **'Open Now'**
  String get questOpenNow;

  /// No description provided for @questRatingExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent 🔥'**
  String get questRatingExcellent;

  /// No description provided for @questRatingAverage.
  ///
  /// In en, this message translates to:
  /// **'Good 👍'**
  String get questRatingAverage;

  /// No description provided for @questRatingMixed.
  ///
  /// In en, this message translates to:
  /// **'Wildcard 🎲'**
  String get questRatingMixed;

  /// No description provided for @visitComplete.
  ///
  /// In en, this message translates to:
  /// **'ARRIVED! 🎉'**
  String get visitComplete;

  /// No description provided for @photosLabel.
  ///
  /// In en, this message translates to:
  /// **'PHOTOS'**
  String get photosLabel;

  /// No description provided for @viewReview.
  ///
  /// In en, this message translates to:
  /// **'View Review'**
  String get viewReview;

  /// No description provided for @reservable.
  ///
  /// In en, this message translates to:
  /// **'Reservable'**
  String get reservable;

  /// No description provided for @notReservable.
  ///
  /// In en, this message translates to:
  /// **'Not Reservable'**
  String get notReservable;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @achNameExplorerLv1.
  ///
  /// In en, this message translates to:
  /// **'Explorer Lv.1'**
  String get achNameExplorerLv1;

  /// No description provided for @achDescExplorerLv1.
  ///
  /// In en, this message translates to:
  /// **'Visit 5 different shops.'**
  String get achDescExplorerLv1;

  /// No description provided for @achNameExplorerLv2.
  ///
  /// In en, this message translates to:
  /// **'Explorer Lv.2'**
  String get achNameExplorerLv2;

  /// No description provided for @achDescExplorerLv2.
  ///
  /// In en, this message translates to:
  /// **'Visit 25 different shops.'**
  String get achDescExplorerLv2;

  /// No description provided for @achNameExplorerLv3.
  ///
  /// In en, this message translates to:
  /// **'Explorer Lv.3'**
  String get achNameExplorerLv3;

  /// No description provided for @achDescExplorerLv3.
  ///
  /// In en, this message translates to:
  /// **'Visit 100 different shops.'**
  String get achDescExplorerLv3;

  /// No description provided for @achNameMasterExplorer.
  ///
  /// In en, this message translates to:
  /// **'Master Explorer'**
  String get achNameMasterExplorer;

  /// No description provided for @achDescMasterExplorer.
  ///
  /// In en, this message translates to:
  /// **'Visit 500 different shops.'**
  String get achDescMasterExplorer;

  /// No description provided for @achNameGodOfWalk.
  ///
  /// In en, this message translates to:
  /// **'God of Walk'**
  String get achNameGodOfWalk;

  /// No description provided for @achDescGodOfWalk.
  ///
  /// In en, this message translates to:
  /// **'Visit 1000 different shops.'**
  String get achDescGodOfWalk;

  /// No description provided for @achNameRamenLover.
  ///
  /// In en, this message translates to:
  /// **'Ramen Lover'**
  String get achNameRamenLover;

  /// No description provided for @achDescRamenLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Ramen shops.'**
  String get achDescRamenLover;

  /// No description provided for @achNameRamenGod.
  ///
  /// In en, this message translates to:
  /// **'Ramen God'**
  String get achNameRamenGod;

  /// No description provided for @achDescRamenGod.
  ///
  /// In en, this message translates to:
  /// **'Visit 50 Ramen shops.'**
  String get achDescRamenGod;

  /// No description provided for @achNameCafeFan.
  ///
  /// In en, this message translates to:
  /// **'Cafe Fan'**
  String get achNameCafeFan;

  /// No description provided for @achDescCafeFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Cafes.'**
  String get achDescCafeFan;

  /// No description provided for @achNameCafeLover.
  ///
  /// In en, this message translates to:
  /// **'Cafe Lover'**
  String get achNameCafeLover;

  /// No description provided for @achDescCafeLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Cafes.'**
  String get achDescCafeLover;

  /// No description provided for @achNameCafeMaster.
  ///
  /// In en, this message translates to:
  /// **'Cafe Master'**
  String get achNameCafeMaster;

  /// No description provided for @achDescCafeMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Cafes.'**
  String get achDescCafeMaster;

  /// No description provided for @achNameSushiFan.
  ///
  /// In en, this message translates to:
  /// **'Sushi Fan'**
  String get achNameSushiFan;

  /// No description provided for @achDescSushiFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Sushi shops.'**
  String get achDescSushiFan;

  /// No description provided for @achNameSushiLover.
  ///
  /// In en, this message translates to:
  /// **'Sushi Lover'**
  String get achNameSushiLover;

  /// No description provided for @achDescSushiLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Sushi shops.'**
  String get achDescSushiLover;

  /// No description provided for @achNameSushiMaster.
  ///
  /// In en, this message translates to:
  /// **'Sushi Master'**
  String get achNameSushiMaster;

  /// No description provided for @achDescSushiMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Sushi shops.'**
  String get achDescSushiMaster;

  /// No description provided for @achNameYakinikuFan.
  ///
  /// In en, this message translates to:
  /// **'Yakiniku Fan'**
  String get achNameYakinikuFan;

  /// No description provided for @achDescYakinikuFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Yakiniku shops.'**
  String get achDescYakinikuFan;

  /// No description provided for @achNameYakinikuLover.
  ///
  /// In en, this message translates to:
  /// **'Yakiniku Lover'**
  String get achNameYakinikuLover;

  /// No description provided for @achDescYakinikuLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Yakiniku shops.'**
  String get achDescYakinikuLover;

  /// No description provided for @achNameYakinikuMaster.
  ///
  /// In en, this message translates to:
  /// **'Yakiniku Master'**
  String get achNameYakinikuMaster;

  /// No description provided for @achDescYakinikuMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Yakiniku shops.'**
  String get achDescYakinikuMaster;

  /// No description provided for @achNameIzakayaFan.
  ///
  /// In en, this message translates to:
  /// **'Izakaya Fan'**
  String get achNameIzakayaFan;

  /// No description provided for @achDescIzakayaFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Izakayas.'**
  String get achDescIzakayaFan;

  /// No description provided for @achNameIzakayaLover.
  ///
  /// In en, this message translates to:
  /// **'Izakaya Lover'**
  String get achNameIzakayaLover;

  /// No description provided for @achDescIzakayaLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Izakayas.'**
  String get achDescIzakayaLover;

  /// No description provided for @achNameIzakayaMaster.
  ///
  /// In en, this message translates to:
  /// **'Izakaya Master'**
  String get achNameIzakayaMaster;

  /// No description provided for @achDescIzakayaMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Izakayas.'**
  String get achDescIzakayaMaster;

  /// No description provided for @achNameBarFan.
  ///
  /// In en, this message translates to:
  /// **'Bar Fan'**
  String get achNameBarFan;

  /// No description provided for @achDescBarFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Bars.'**
  String get achDescBarFan;

  /// No description provided for @achNameBarLover.
  ///
  /// In en, this message translates to:
  /// **'Bar Lover'**
  String get achNameBarLover;

  /// No description provided for @achDescBarLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Bars.'**
  String get achDescBarLover;

  /// No description provided for @achNameBarMaster.
  ///
  /// In en, this message translates to:
  /// **'Bar Master'**
  String get achNameBarMaster;

  /// No description provided for @achDescBarMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Bars.'**
  String get achDescBarMaster;

  /// No description provided for @achNameSweetsFan.
  ///
  /// In en, this message translates to:
  /// **'Sweets Fan'**
  String get achNameSweetsFan;

  /// No description provided for @achDescSweetsFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Sweets shops.'**
  String get achDescSweetsFan;

  /// No description provided for @achNameSweetsLover.
  ///
  /// In en, this message translates to:
  /// **'Sweets Lover'**
  String get achNameSweetsLover;

  /// No description provided for @achDescSweetsLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Sweets shops.'**
  String get achDescSweetsLover;

  /// No description provided for @achNameSweetsMaster.
  ///
  /// In en, this message translates to:
  /// **'Sweets Master'**
  String get achNameSweetsMaster;

  /// No description provided for @achDescSweetsMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Sweets shops.'**
  String get achDescSweetsMaster;

  /// No description provided for @achNameCurryFan.
  ///
  /// In en, this message translates to:
  /// **'Curry Fan'**
  String get achNameCurryFan;

  /// No description provided for @achDescCurryFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Curry shops.'**
  String get achDescCurryFan;

  /// No description provided for @achNameCurryLover.
  ///
  /// In en, this message translates to:
  /// **'Curry Lover'**
  String get achNameCurryLover;

  /// No description provided for @achDescCurryLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Curry shops.'**
  String get achDescCurryLover;

  /// No description provided for @achNameCurryMaster.
  ///
  /// In en, this message translates to:
  /// **'Curry Master'**
  String get achNameCurryMaster;

  /// No description provided for @achDescCurryMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Curry shops.'**
  String get achDescCurryMaster;

  /// No description provided for @achNameEuroFan.
  ///
  /// In en, this message translates to:
  /// **'European Fan'**
  String get achNameEuroFan;

  /// No description provided for @achDescEuroFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 European style shops.'**
  String get achDescEuroFan;

  /// No description provided for @achNameEuroLover.
  ///
  /// In en, this message translates to:
  /// **'European Lover'**
  String get achNameEuroLover;

  /// No description provided for @achDescEuroLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 European style shops.'**
  String get achDescEuroLover;

  /// No description provided for @achNameEuroMaster.
  ///
  /// In en, this message translates to:
  /// **'European Master'**
  String get achNameEuroMaster;

  /// No description provided for @achDescEuroMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 European style shops.'**
  String get achDescEuroMaster;

  /// No description provided for @achNameChineseFan.
  ///
  /// In en, this message translates to:
  /// **'Chinese Fan'**
  String get achNameChineseFan;

  /// No description provided for @achDescChineseFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Chinese shops.'**
  String get achDescChineseFan;

  /// No description provided for @achNameChineseLover.
  ///
  /// In en, this message translates to:
  /// **'Chinese Lover'**
  String get achNameChineseLover;

  /// No description provided for @achDescChineseLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Chinese shops.'**
  String get achDescChineseLover;

  /// No description provided for @achNameChineseMaster.
  ///
  /// In en, this message translates to:
  /// **'Chinese Master'**
  String get achNameChineseMaster;

  /// No description provided for @achDescChineseMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Chinese shops.'**
  String get achDescChineseMaster;

  /// No description provided for @achNameDonFan.
  ///
  /// In en, this message translates to:
  /// **'Donburi Fan'**
  String get achNameDonFan;

  /// No description provided for @achDescDonFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Donburi (Rice Bowl) shops.'**
  String get achDescDonFan;

  /// No description provided for @achNameDonLover.
  ///
  /// In en, this message translates to:
  /// **'Donburi Lover'**
  String get achNameDonLover;

  /// No description provided for @achDescDonLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Donburi shops.'**
  String get achDescDonLover;

  /// No description provided for @achNameDonMaster.
  ///
  /// In en, this message translates to:
  /// **'Donburi Master'**
  String get achNameDonMaster;

  /// No description provided for @achDescDonMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Donburi shops.'**
  String get achDescDonMaster;

  /// No description provided for @achNameWashokuFan.
  ///
  /// In en, this message translates to:
  /// **'Washoku Fan'**
  String get achNameWashokuFan;

  /// No description provided for @achDescWashokuFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Washoku shops.'**
  String get achDescWashokuFan;

  /// No description provided for @achNameWashokuLover.
  ///
  /// In en, this message translates to:
  /// **'Washoku Lover'**
  String get achNameWashokuLover;

  /// No description provided for @achDescWashokuLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Washoku shops.'**
  String get achDescWashokuLover;

  /// No description provided for @achNameWashokuMaster.
  ///
  /// In en, this message translates to:
  /// **'Washoku Master'**
  String get achNameWashokuMaster;

  /// No description provided for @achDescWashokuMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Washoku shops.'**
  String get achDescWashokuMaster;

  /// No description provided for @achNameYakitoriFan.
  ///
  /// In en, this message translates to:
  /// **'Yakitori Fan'**
  String get achNameYakitoriFan;

  /// No description provided for @achDescYakitoriFan.
  ///
  /// In en, this message translates to:
  /// **'Visit 3 Yakitori shops.'**
  String get achDescYakitoriFan;

  /// No description provided for @achNameYakitoriLover.
  ///
  /// In en, this message translates to:
  /// **'Yakitori Lover'**
  String get achNameYakitoriLover;

  /// No description provided for @achDescYakitoriLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Yakitori shops.'**
  String get achDescYakitoriLover;

  /// No description provided for @achNameYakitoriMaster.
  ///
  /// In en, this message translates to:
  /// **'Yakitori Master'**
  String get achNameYakitoriMaster;

  /// No description provided for @achDescYakitoriMaster.
  ///
  /// In en, this message translates to:
  /// **'Visit 30 Yakitori shops.'**
  String get achDescYakitoriMaster;

  /// No description provided for @achNameOmnivore.
  ///
  /// In en, this message translates to:
  /// **'Omnivore'**
  String get achNameOmnivore;

  /// No description provided for @achDescOmnivore.
  ///
  /// In en, this message translates to:
  /// **'Visit one shop from 20 different categories.'**
  String get achDescOmnivore;

  /// No description provided for @achNameIndieSpirit.
  ///
  /// In en, this message translates to:
  /// **'Indie Spirit'**
  String get achNameIndieSpirit;

  /// No description provided for @achDescIndieSpirit.
  ///
  /// In en, this message translates to:
  /// **'Visit 50 Independent shops.'**
  String get achDescIndieSpirit;

  /// No description provided for @achNameChainLover.
  ///
  /// In en, this message translates to:
  /// **'Chain Lover'**
  String get achNameChainLover;

  /// No description provided for @achDescChainLover.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 Chain shops.'**
  String get achDescChainLover;

  /// No description provided for @achNameLunchRush.
  ///
  /// In en, this message translates to:
  /// **'Lunch Rush'**
  String get achNameLunchRush;

  /// No description provided for @achDescLunchRush.
  ///
  /// In en, this message translates to:
  /// **'Visit a shop between 11:30 AM and 1:30 PM.'**
  String get achDescLunchRush;

  /// No description provided for @achNameAfternoonTea.
  ///
  /// In en, this message translates to:
  /// **'Afternoon Tea'**
  String get achNameAfternoonTea;

  /// No description provided for @achDescAfternoonTea.
  ///
  /// In en, this message translates to:
  /// **'Visit a shop between 3:00 PM and 5:00 PM.'**
  String get achDescAfternoonTea;

  /// No description provided for @achNameDinnerTime.
  ///
  /// In en, this message translates to:
  /// **'Dinner Time'**
  String get achNameDinnerTime;

  /// No description provided for @achDescDinnerTime.
  ///
  /// In en, this message translates to:
  /// **'Visit a shop between 6:00 PM and 9:00 PM.'**
  String get achDescDinnerTime;

  /// No description provided for @achNameWeekdayWorker.
  ///
  /// In en, this message translates to:
  /// **'Weekday Worker'**
  String get achNameWeekdayWorker;

  /// No description provided for @achDescWeekdayWorker.
  ///
  /// In en, this message translates to:
  /// **'Visit 10 shops on weekdays.'**
  String get achDescWeekdayWorker;

  /// No description provided for @achNameFridayNight.
  ///
  /// In en, this message translates to:
  /// **'TGIF'**
  String get achNameFridayNight;

  /// No description provided for @achDescFridayNight.
  ///
  /// In en, this message translates to:
  /// **'Visit a shop on Friday night (after 6 PM).'**
  String get achDescFridayNight;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'FOG OF FLAVOR PRO'**
  String get paywallTitle;

  /// No description provided for @paywallHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Trial Period Ended'**
  String get paywallHeroTitle;

  /// No description provided for @paywallHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your 1-month trial has expired. Upgrade to Fog of Flavor Pro to continue recording your gastronomic journey.'**
  String get paywallHeroSubtitle;

  /// No description provided for @paywallPlanBestValue.
  ///
  /// In en, this message translates to:
  /// **'BEST VALUE'**
  String get paywallPlanBestValue;

  /// No description provided for @paywallPlanPromoted.
  ///
  /// In en, this message translates to:
  /// **'PROMOTED'**
  String get paywallPlanPromoted;

  /// No description provided for @paywallPlanAnnualDesc.
  ///
  /// In en, this message translates to:
  /// **'Most popular choice'**
  String get paywallPlanAnnualDesc;

  /// No description provided for @paywallPlanLifetimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Own it forever'**
  String get paywallPlanLifetimeDesc;

  /// No description provided for @paywallContinueButton.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get paywallContinueButton;

  /// No description provided for @paywallRestoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get paywallRestoreButton;

  /// No description provided for @paywallSignOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out / Switch Account'**
  String get paywallSignOutButton;

  /// No description provided for @paywallPlanMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get paywallPlanMonthly;

  /// No description provided for @paywallPlanAnnual.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get paywallPlanAnnual;

  /// No description provided for @paywallPlanLifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get paywallPlanLifetime;

  /// No description provided for @paywallPlanDefault.
  ///
  /// In en, this message translates to:
  /// **'Pro Plan'**
  String get paywallPlanDefault;

  /// No description provided for @accountProMember.
  ///
  /// In en, this message translates to:
  /// **'Pro Member'**
  String get accountProMember;

  /// No description provided for @accountProUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get accountProUpgrade;

  /// No description provided for @accountProActive.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support!'**
  String get accountProActive;

  /// No description provided for @accountProUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock exclusive themes and more'**
  String get accountProUnlock;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @alreadyHaveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccountPrompt;

  /// No description provided for @invalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmailError;

  /// No description provided for @shortPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get shortPasswordError;

  /// No description provided for @passwordsDoNotMatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatchError;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @fogDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Fog Discovery'**
  String get fogDiscovery;

  /// No description provided for @clearedArea.
  ///
  /// In en, this message translates to:
  /// **'Cleared Area'**
  String get clearedArea;

  /// No description provided for @worldCoverage.
  ///
  /// In en, this message translates to:
  /// **'World Coverage'**
  String get worldCoverage;

  /// No description provided for @tabRanking.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get tabRanking;

  /// No description provided for @rankingTypeArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get rankingTypeArea;

  /// No description provided for @rankingTypeLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get rankingTypeLevel;

  /// No description provided for @rankingTypeVisits.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get rankingTypeVisits;

  /// No description provided for @rankingTypeCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get rankingTypeCategory;

  /// No description provided for @rankingLabelClearedArea.
  ///
  /// In en, this message translates to:
  /// **'Cleared Area'**
  String get rankingLabelClearedArea;

  /// No description provided for @rankingLabelLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get rankingLabelLevel;

  /// No description provided for @rankingLabelShopsVisited.
  ///
  /// In en, this message translates to:
  /// **'Shops Visited'**
  String get rankingLabelShopsVisited;

  /// No description provided for @rankingLabelVisits.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get rankingLabelVisits;

  /// No description provided for @rankingLabelPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get rankingLabelPoints;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

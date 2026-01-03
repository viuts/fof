import '../l10n/app_localizations.dart';

class LocalizedAchievement {
  final String name;
  final String description;

  LocalizedAchievement(this.name, this.description);
}

class AchievementLocalization {
  static LocalizedAchievement getLocalizedAchievement(AppLocalizations s, String id) {
    switch (id) {
      case 'first_steps':
        return LocalizedAchievement(s.achNameFirstSteps, s.achDescFirstSteps);
      case 'ramen_fan':
        return LocalizedAchievement(s.achNameRamenFan, s.achDescRamenFan);
      case 'chain_breaker':
        return LocalizedAchievement(s.achNameChainBreaker, s.achDescChainBreaker);
      case 'light_bringer':
        return LocalizedAchievement(s.achNameLightBringer, s.achDescLightBringer);
      case 'cuisine_alchemist':
        return LocalizedAchievement(s.achNameCuisineAlchemist, s.achDescCuisineAlchemist);
      case 'night_owl':
        return LocalizedAchievement(s.achNameNightOwl, s.achDescNightOwl);
      default:
        // Fallback for unknown IDs (or use the one from backend if provided)
        return LocalizedAchievement('Unknown Achievement', 'ID: $id');
    }
  }

  static String getLocalizedCategoryLabel(AppLocalizations s, String categoryId) {
    switch (categoryId) {
      case 'ALL':
        return s.achCategoryAll;
      case 'EXPLORATION':
        return s.achCategoryExploration;
      case 'FOODIE':
        return s.achCategoryFoodie;
      case 'QUEST':
        return s.achCategoryQuest;
      case 'SOCIAL':
        return s.achCategorySocial;
      default:
        return categoryId;
    }
  }
}

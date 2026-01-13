import '../l10n/app_localizations.dart';

class LocalizedAchievement {
  final String name;
  final String description;

  LocalizedAchievement(this.name, this.description);
}

class AchievementLocalization {
  static LocalizedAchievement getLocalizedAchievement(
    AppLocalizations s,
    String id,
  ) {
    switch (id) {
      case 'first_steps':
        return LocalizedAchievement(s.achNameFirstSteps, s.achDescFirstSteps);
      case 'explorer_lv1':
        return LocalizedAchievement(s.achNameExplorerLv1, s.achDescExplorerLv1);
      case 'fog_runner':
        return LocalizedAchievement(s.achNameFogRunner, s.achDescFogRunner);
      case 'explorer_lv2':
        return LocalizedAchievement(s.achNameExplorerLv2, s.achDescExplorerLv2);
      case 'light_bringer':
        return LocalizedAchievement(
          s.achNameLightBringer,
          s.achDescLightBringer,
        );
      case 'explorer_lv3':
        return LocalizedAchievement(s.achNameExplorerLv3, s.achDescExplorerLv3);
      case 'legendary_explorer':
        return LocalizedAchievement(
          s.achNameLegendaryExplorer,
          s.achDescLegendaryExplorer,
        );
      case 'master_explorer':
        return LocalizedAchievement(
          s.achNameMasterExplorer,
          s.achDescMasterExplorer,
        );
      case 'god_of_walk':
        return LocalizedAchievement(s.achNameGodOfWalk, s.achDescGodOfWalk);
      case 'ramen_fan':
        return LocalizedAchievement(s.achNameRamenFan, s.achDescRamenFan);
      case 'ramen_lover':
        return LocalizedAchievement(s.achNameRamenLover, s.achDescRamenLover);
      case 'ramen_master':
        return LocalizedAchievement(s.achNameRamenMaster, s.achDescRamenMaster);
      case 'ramen_god':
        return LocalizedAchievement(s.achNameRamenGod, s.achDescRamenGod);
      case 'cafe_fan':
        return LocalizedAchievement(s.achNameCafeFan, s.achDescCafeFan);
      case 'cafe_lover':
        return LocalizedAchievement(s.achNameCafeLover, s.achDescCafeLover);
      case 'cafe_master':
        return LocalizedAchievement(s.achNameCafeMaster, s.achDescCafeMaster);
      case 'sushi_fan':
        return LocalizedAchievement(s.achNameSushiFan, s.achDescSushiFan);
      case 'sushi_lover':
        return LocalizedAchievement(s.achNameSushiLover, s.achDescSushiLover);
      case 'sushi_master':
        return LocalizedAchievement(s.achNameSushiMaster, s.achDescSushiMaster);
      case 'yakiniku_fan':
        return LocalizedAchievement(s.achNameYakinikuFan, s.achDescYakinikuFan);
      case 'yakiniku_lover':
        return LocalizedAchievement(
          s.achNameYakinikuLover,
          s.achDescYakinikuLover,
        );
      case 'yakiniku_master':
        return LocalizedAchievement(
          s.achNameYakinikuMaster,
          s.achDescYakinikuMaster,
        );
      case 'izakaya_fan':
        return LocalizedAchievement(s.achNameIzakayaFan, s.achDescIzakayaFan);
      case 'izakaya_lover':
        return LocalizedAchievement(
          s.achNameIzakayaLover,
          s.achDescIzakayaLover,
        );
      case 'izakaya_master':
        return LocalizedAchievement(
          s.achNameIzakayaMaster,
          s.achDescIzakayaMaster,
        );
      case 'bar_fan':
        return LocalizedAchievement(s.achNameBarFan, s.achDescBarFan);
      case 'bar_lover':
        return LocalizedAchievement(s.achNameBarLover, s.achDescBarLover);
      case 'bar_master':
        return LocalizedAchievement(s.achNameBarMaster, s.achDescBarMaster);
      case 'sweets_fan':
        return LocalizedAchievement(s.achNameSweetsFan, s.achDescSweetsFan);
      case 'sweets_lover':
        return LocalizedAchievement(s.achNameSweetsLover, s.achDescSweetsLover);
      case 'sweets_master':
        return LocalizedAchievement(
          s.achNameSweetsMaster,
          s.achDescSweetsMaster,
        );
      case 'curry_fan':
        return LocalizedAchievement(s.achNameCurryFan, s.achDescCurryFan);
      case 'curry_lover':
        return LocalizedAchievement(s.achNameCurryLover, s.achDescCurryLover);
      case 'curry_master':
        return LocalizedAchievement(s.achNameCurryMaster, s.achDescCurryMaster);
      case 'euro_fan':
        return LocalizedAchievement(s.achNameEuroFan, s.achDescEuroFan);
      case 'euro_lover':
        return LocalizedAchievement(s.achNameEuroLover, s.achDescEuroLover);
      case 'euro_master':
        return LocalizedAchievement(s.achNameEuroMaster, s.achDescEuroMaster);
      case 'chinese_fan':
        return LocalizedAchievement(s.achNameChineseFan, s.achDescChineseFan);
      case 'chinese_lover':
        return LocalizedAchievement(
          s.achNameChineseLover,
          s.achDescChineseLover,
        );
      case 'chinese_master':
        return LocalizedAchievement(
          s.achNameChineseMaster,
          s.achDescChineseMaster,
        );
      case 'don_fan':
        return LocalizedAchievement(s.achNameDonFan, s.achDescDonFan);
      case 'don_lover':
        return LocalizedAchievement(s.achNameDonLover, s.achDescDonLover);
      case 'don_master':
        return LocalizedAchievement(s.achNameDonMaster, s.achDescDonMaster);
      case 'washoku_fan':
        return LocalizedAchievement(s.achNameWashokuFan, s.achDescWashokuFan);
      case 'washoku_lover':
        return LocalizedAchievement(
          s.achNameWashokuLover,
          s.achDescWashokuLover,
        );
      case 'washoku_master':
        return LocalizedAchievement(
          s.achNameWashokuMaster,
          s.achDescWashokuMaster,
        );
      case 'yakitori_fan':
        return LocalizedAchievement(s.achNameYakitoriFan, s.achDescYakitoriFan);
      case 'yakitori_lover':
        return LocalizedAchievement(
          s.achNameYakitoriLover,
          s.achDescYakitoriLover,
        );
      case 'yakitori_master':
        return LocalizedAchievement(
          s.achNameYakitoriMaster,
          s.achDescYakitoriMaster,
        );
      case 'cuisine_alchemist':
        return LocalizedAchievement(
          s.achNameCuisineAlchemist,
          s.achDescCuisineAlchemist,
        );
      case 'gourmet_king':
        return LocalizedAchievement(s.achNameGourmetKing, s.achDescGourmetKing);
      case 'omnivore':
        return LocalizedAchievement(s.achNameOmnivore, s.achDescOmnivore);
      case 'chain_breaker':
        return LocalizedAchievement(
          s.achNameChainBreaker,
          s.achDescChainBreaker,
        );
      case 'indie_spirit':
        return LocalizedAchievement(s.achNameIndieSpirit, s.achDescIndieSpirit);
      case 'chain_lover':
        return LocalizedAchievement(s.achNameChainLover, s.achDescChainLover);
      case 'morning_bird':
        return LocalizedAchievement(s.achNameMorningBird, s.achDescMorningBird);
      case 'lunch_rush':
        return LocalizedAchievement(s.achNameLunchRush, s.achDescLunchRush);
      case 'afternoon_tea':
        return LocalizedAchievement(
          s.achNameAfternoonTea,
          s.achDescAfternoonTea,
        );
      case 'dinner_time':
        return LocalizedAchievement(s.achNameDinnerTime, s.achDescDinnerTime);
      case 'night_owl':
      case 'midnight_snack':
        return LocalizedAchievement(s.achNameNightOwl, s.achDescNightOwl);
      case 'weekend_warrior':
        return LocalizedAchievement(
          s.achNameWeekendWarrior,
          s.achDescWeekendWarrior,
        );
      case 'weekday_worker':
        return LocalizedAchievement(
          s.achNameWeekdayWorker,
          s.achDescWeekdayWorker,
        );
      case 'friday_night':
        return LocalizedAchievement(s.achNameFridayNight, s.achDescFridayNight);
      default:
        // Fallback for unknown IDs (or use the one from backend if provided)
        return LocalizedAchievement('Unknown Achievement', 'ID: $id');
    }
  }

  static String getLocalizedCategoryLabel(
    AppLocalizations s,
    String categoryId,
  ) {
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

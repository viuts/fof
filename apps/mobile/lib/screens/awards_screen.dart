import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'achievements_screen.dart';
import 'ranking_screen.dart';
import '../l10n/app_localizations.dart';

class AwardsScreen extends StatelessWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.lightBackground,
        appBar: AppBar(
          title: Text(s.tabAwards),
          backgroundColor: AppTheme.lightSurface,
          surfaceTintColor: Colors.transparent,
          bottom: TabBar(
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.textSecondaryLight,
            indicatorColor: AppTheme.primaryColor,
            tabs: [
              Tab(text: s.achievementTabTitle),
              Tab(text: s.tabRanking),
            ],
          ),
        ),
        body: const TabBarView(
          children: [AchievementsScreen(), RankingScreen()],
        ),
      ),
    );
  }
}

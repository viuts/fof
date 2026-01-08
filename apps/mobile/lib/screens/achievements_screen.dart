import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../api/fof/v1/achievement.pb.dart';
import '../l10n/app_localizations.dart';
import '../utils/achievement_localization.dart';
import '../services/language_service.dart';
import '../services/user_service.dart';
import 'package:provider/provider.dart';

extension UserAchievementStatusExtension on UserAchievementStatus {
  double get progress => targetValue > 0 ? currentValue / targetValue : 0.0;
}

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  String _selectedCategory = 'ALL';

  final List<Map<String, dynamic>> _categories = [
    {'id': 'ALL', 'label': 'ALL', 'icon': Icons.grid_view_rounded},
    {'id': 'EXPLORATION', 'label': 'EXPLORE', 'icon': Icons.explore_rounded},
    {'id': 'FOODIE', 'label': 'FOODIE', 'icon': Icons.restaurant_rounded},
    {'id': 'QUEST', 'label': 'QUEST', 'icon': Icons.map_rounded},
    // {'id': 'SOCIAL', 'label': 'SOCIAL', 'icon': Icons.people_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  void _loadAchievements() {
    Provider.of<UserService>(context, listen: false).loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(s.achievementTabTitle),
        backgroundColor: AppTheme.lightSurface,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              Provider.of<UserService>(
                context,
                listen: false,
              ).refreshAchievements();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final userService = Provider.of<UserService>(context);
    if (userService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      children: [
        // Left Sidebar: Categories
        _buildSidebar(),
        // Right Content: Filtered Achievements
        Expanded(child: _buildAchievementList()),
      ],
    );
  }

  Widget _buildSidebar() {
    final s = AppLocalizations.of(context)!;
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: AppTheme.lightSurface,
        border: Border(
          right: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final localizedLabel =
              AchievementLocalization.getLocalizedCategoryLabel(s, cat['id']);
          final isSelected = _selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat['id']),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(
                        right: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 3,
                        ),
                      )
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cat['icon'],
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.textSecondaryLight,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localizedLabel,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAchievementList() {
    final userService = Provider.of<UserService>(context);
    final achievements = userService.achievements;
    final filtered =
        (_selectedCategory == 'ALL'
              ? achievements
              : achievements
                    .where(
                      (a) =>
                          a.achievement.category.toUpperCase() ==
                          _selectedCategory,
                    )
                    .toList())
          ..sort((a, b) {
            // Prioritize In Progress (Not unlocked, partial progress)
            final aInProgress = !a.isUnlocked && a.currentValue > 0;
            final bInProgress = !b.isUnlocked && b.currentValue > 0;
            if (aInProgress && !bInProgress) return -1;
            if (!aInProgress && bInProgress) return 1;

            // Then No Progress (Not unlocked, no progress)
            final aNoProgress = !a.isUnlocked && a.currentValue == 0;
            final bNoProgress = !b.isUnlocked && b.currentValue == 0;
            if (aNoProgress && !bNoProgress) return -1;
            if (!aNoProgress && bNoProgress) return 1;

            // Finally Achieved (Unlocked), sorted by most recently unlocked
            if (a.isUnlocked && b.isUnlocked) {
              // Parse dates if available, otherwise strict sort isn't critical but good to have
              // unlockedAt is string ISO? Proto says string. Assuming ISO8601 or empty.
              if (a.unlockedAt.isNotEmpty && b.unlockedAt.isNotEmpty) {
                return b.unlockedAt.compareTo(a.unlockedAt); // Descending
              }
            }

            // Fallback to name or ID if needed, or keep stable
            return 0;
          });

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          S.of(context).noAchievementsYet,
          style: TextStyle(color: AppTheme.textSecondaryLight),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(
        left: AppTheme.spacingMd,
        right: AppTheme.spacingMd,
        top: AppTheme.spacingMd,
        bottom: 16, // Extra space for FAB and bottom bar
      ),
      itemCount: filtered.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppTheme.spacingMd),
      itemBuilder: (context, index) {
        return _buildAchievementCard(filtered[index]);
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'EXPLORATION':
        return Colors.blue;
      case 'FOODIE':
        return Colors.orange;
      case 'QUEST':
        return Colors.purple;
      case 'SOCIAL':
        return Colors.green;
      default:
        return AppTheme.primaryColor;
    }
  }

  Color _getTierColor(AchievementTier tier) {
    switch (tier) {
      case AchievementTier.ACHIEVEMENT_TIER_BRONZE:
        return AppTheme.tierBronze;
      case AchievementTier.ACHIEVEMENT_TIER_SILVER:
        return AppTheme.tierSilver;
      case AchievementTier.ACHIEVEMENT_TIER_GOLD:
        return AppTheme.tierGold;
      case AchievementTier.ACHIEVEMENT_TIER_PLATINUM:
        return AppTheme.tierPlatinum;
      default:
        return Colors.grey;
    }
  }

  String _getTierLabel(AchievementTier tier) {
    switch (tier) {
      case AchievementTier.ACHIEVEMENT_TIER_BRONZE:
        return 'BRONZE';
      case AchievementTier.ACHIEVEMENT_TIER_SILVER:
        return 'SILVER';
      case AchievementTier.ACHIEVEMENT_TIER_GOLD:
        return 'GOLD';
      case AchievementTier.ACHIEVEMENT_TIER_PLATINUM:
        return 'PLATINUM';
      default:
        return '';
    }
  }

  Widget _buildAchievementCard(UserAchievementStatus status) {
    final s = AppLocalizations.of(context)!;
    final ach = status.achievement;
    final isUnlocked = status.isUnlocked;
    final progress = status.progress;

    // Localize!
    final localized = AchievementLocalization.getLocalizedAchievement(
      s,
      ach.id,
    );

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.lightSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isUnlocked
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color:
                      (isUnlocked ? AppTheme.primaryColor : Colors.grey[200]!)
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: _getTierColor(ach.tier),
                      size: 24,
                    ),
                    if (ach.tier !=
                        AchievementTier.ACHIEVEMENT_TIER_UNSPECIFIED)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          _getTierLabel(ach.tier),
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: _getTierColor(ach.tier),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(
                                ach.category,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _getCategoryColor(
                                  ach.category,
                                ).withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              AchievementLocalization.getLocalizedCategoryLabel(
                                s,
                                ach.category,
                              ),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _getCategoryColor(ach.category),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '+${ach.expReward} EXP',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isUnlocked
                                ? AppTheme.primaryColor
                                : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      localized.name, // Use localized name
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isUnlocked
                            ? AppTheme.textPrimaryLight
                            : AppTheme.textSecondaryLight,
                      ),
                    ),
                    Text(
                      localized.description, // Use localized description
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondaryLight,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnlocked)
                Icon(
                  Icons.stars_rounded,
                  color:
                      ach.tier != AchievementTier.ACHIEVEMENT_TIER_UNSPECIFIED
                      ? _getTierColor(ach.tier)
                      : AppTheme.primaryColor,
                  size: 20,
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
          const SizedBox(height: AppTheme.spacingMd),
          if (isUnlocked) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _formatDate(status.unlockedAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryColor.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: AppTheme.lightSurfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${status.currentValue}/${status.targetValue}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final date = DateTime.parse(isoString).toLocal();
      // Simple formatting YYYY/MM/DD, can use intl package if desired but keeping simple for now
      return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
}

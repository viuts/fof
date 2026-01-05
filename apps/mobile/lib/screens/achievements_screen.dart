import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import '../api/fof/v1/fof.pb.dart';
import '../l10n/app_localizations.dart';
import '../utils/achievement_localization.dart';

extension UserAchievementStatusExtension on UserAchievementStatus {
  double get progress => targetValue > 0 ? currentValue / targetValue : 0.0;
}

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final ApiService _apiService = ApiService();
  List<UserAchievementStatus> _achievements = [];
  bool _isLoading = true;
  String? _error;
  String _selectedCategory = 'ALL';

  final List<Map<String, dynamic>> _categories = [
    {'id': 'ALL', 'label': 'ALL', 'icon': Icons.grid_view_rounded},
    {'id': 'EXPLORATION', 'label': 'EXPLORE', 'icon': Icons.explore_rounded},
    {'id': 'FOODIE', 'label': 'FOODIE', 'icon': Icons.restaurant_rounded},
    {'id': 'QUEST', 'label': 'QUEST', 'icon': Icons.map_rounded},
    {'id': 'SOCIAL', 'label': 'SOCIAL', 'icon': Icons.people_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  Future<void> _loadAchievements() async {
    try {
      final response = await _apiService.getAchievements();
      setState(() {
        _achievements = response.achievements;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
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
              setState(() => _isLoading = true);
              _loadAchievements();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text('Error: $_error'),
            TextButton(
              onPressed: _loadAchievements,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
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
    final filtered =
        (_selectedCategory == 'ALL'
              ? _achievements
              : _achievements
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
          'No achievements yet.',
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

  IconData _getIconForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'EXPLORATION':
        return Icons.explore_rounded;
      case 'FOODIE':
        return Icons.restaurant_rounded;
      case 'QUEST':
        return Icons.map_rounded;
      case 'SOCIAL':
        return Icons.people_rounded;
      default:
        return Icons.emoji_events_rounded;
    }
  }

  Widget _buildAchievementCard(UserAchievementStatus status) {
    final s = AppLocalizations.of(context)!;
    final ach = status.achievement;
    final isUnlocked = status.isUnlocked;
    final progress = status.progress;
    final icon = _getIconForCategory(ach.category);

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
                child: Icon(
                  icon,
                  color: isUnlocked ? AppTheme.primaryColor : Colors.grey[400],
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                const Icon(
                  Icons.stars_rounded,
                  color: AppTheme.primaryColor,
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

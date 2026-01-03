import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: ListView(
          children: [
            _buildAchievementCard(
              title: 'First Discoverer',
              description: 'Clear your first fog tile',
              progress: 1.0,
              icon: Icons.explore,
              isUnlocked: true,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _buildAchievementCard(
              title: 'Cuisine Explorer',
              description: 'Visit 5 different restaurant categories',
              progress: 0.4,
              icon: Icons.restaurant,
              isUnlocked: false,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _buildAchievementCard(
              title: 'The Regular',
              description: 'Visit the same shop 3 times',
              progress: 0.0,
              icon: Icons.repeat,
              isUnlocked: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String description,
    required double progress,
    required IconData icon,
    required bool isUnlocked,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isUnlocked ? AppTheme.primaryColor.withValues(alpha: 0.5) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (isUnlocked ? AppTheme.primaryColor : Colors.grey).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isUnlocked ? AppTheme.primaryColor : Colors.grey,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isUnlocked ? AppTheme.primaryColor : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

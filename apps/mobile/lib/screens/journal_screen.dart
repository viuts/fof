import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/shop.dart';
import '../services/language_service.dart';

class JournalEntry {
  final DateTime timestamp;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  JournalEntry({
    required this.timestamp,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // Placeholder data - in a real app, this would come from a service/database
    final entries = [
      JournalEntry(
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        title: s.neighborExplorer,
        description: s.tilesClearedMsg(15),
        icon: Icons.explore,
        color: AppTheme.primaryColor,
      ),
      JournalEntry(
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        title: s.isJa ? '新発見！' : 'Hidden Gem Discovered!',
        description: s.isJa ? '霧の中に隠れたカフェ「The Cozy Cup」を見つけました。' : 'Found "The Cozy Cup", a cafe hidden in the fog.',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(s.journalTitle),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return _buildJournalCard(context, entry);
        },
      ),
    );
  }

  Widget _buildJournalCard(BuildContext context, JournalEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: entry.color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeColumn(context, entry.timestamp),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(entry.icon, size: 16, color: entry.color),
                    const SizedBox(width: 8),
                    Text(
                      entry.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  entry.description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(BuildContext context, DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final min = timestamp.minute.toString().padLeft(2, '0');
    
    return Column(
      children: [
        Text(
          '$hour:$min',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        Text(
          _getMonthName(context, timestamp.month),
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          timestamp.day.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getMonthName(BuildContext context, int month) {
    if (S.of(context).isJa) {
      return '$month月';
    }
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[month - 1];
  }
}

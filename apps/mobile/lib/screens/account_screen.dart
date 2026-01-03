import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/location_service.dart';
import '../services/language_service.dart';

class AccountScreen extends StatefulWidget {
  final VoidCallback? onDeleteHistory;

  const AccountScreen({super.key, this.onDeleteHistory});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.accountTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        children: [
          // Profile Section
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.darkSurfaceVariant,
                  child: Icon(Icons.person, size: 50, color: AppTheme.textSecondary),
                ),
                SizedBox(height: AppTheme.spacingMd),
                Text(
                  'FoF Explorer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'explorer@fof.app',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),

          // Privacy Settings (Migrated from MapScreen)
          _buildSectionHeader(s.privacySettings),
          const SizedBox(height: AppTheme.spacingSm),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(s.freezeTracking),
                  subtitle: Text(s.freezeSubtitle),
                  value: locationService.isFrozen,
                  activeThumbColor: AppTheme.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      locationService.setFreeze(value);
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(s.deleteHistory),
                  subtitle: Text(s.deleteSubtitle),
                  trailing: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                  onTap: () => _confirmDeleteHistory(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppTheme.spacingLg),
          _buildSectionHeader(s.preferences),
          const SizedBox(height: AppTheme.spacingSm),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(s.language),
                  trailing: Text(
                    s.languageName,
                    style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    languageService.toggleLanguage();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.volume_up),
                  title: Text(s.soundEffects),
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {},
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.map_outlined),
                  title: const Text('Map Style'), // Optional: could be translated too
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingXl),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withValues(alpha: 0.1),
              foregroundColor: Colors.red,
            ),
            child: Text(s.logout),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _confirmDeleteHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete History?'),
        content: const Text('This will reset all cleared fog on your map. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDeleteHistory?.call();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Path history deleted.')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

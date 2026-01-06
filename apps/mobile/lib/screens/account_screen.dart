import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/location_service.dart';
import '../services/language_service.dart';
import '../services/map_style_service.dart';
import '../services/api_service.dart';
import '../api/fof/v1/user.pb.dart';

class AccountScreen extends StatefulWidget {
  final VoidCallback? onDeleteHistory;

  const AccountScreen({super.key, this.onDeleteHistory});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final locationService = LocationService();
  final apiService = ApiService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final response = await apiService.getProfile();
      if (mounted) {
        setState(() {
          _user = response.user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final languageService = Provider.of<LanguageService>(context);
    final mapStyleService = Provider.of<MapStyleService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.accountTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingLg,
                AppTheme.spacingLg,
                AppTheme.spacingLg,
                100, // Extra space for bottom bar and FAB
              ),
              children: [
                // Profile Section
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.darkSurfaceVariant,
                        backgroundImage: _user?.profileImage.isNotEmpty == true
                            ? NetworkImage(_user!.profileImage)
                            : null,
                        child: _user?.profileImage.isNotEmpty == true
                            ? null
                            : const Icon(
                                Icons.person,
                                size: 50,
                                color: AppTheme.textSecondary,
                              ),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text(
                        _user?.displayName.isNotEmpty == true
                            ? _user!.displayName
                            : 'FoF Explorer',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _user?.email ?? 'explorer@fof.app',
                        style: const TextStyle(color: AppTheme.textSecondary),
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
                        trailing: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
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
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          languageService.toggleLanguage();
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: const Icon(Icons.volume_up),
                        title: Text(s.soundEffects),
                        value: true,
                        onChanged: (v) {},
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.map_outlined),
                        title: Text(s.mapStyle),
                        subtitle: Text(
                          mapStyleService.currentStyle.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () =>
                            _showMapStyleDialog(context, mapStyleService),
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

  void _showMapStyleDialog(BuildContext context, MapStyleService service) {
    showDialog(
      context: context,
      builder: (context) {
        final s = S.of(context);
        return AlertDialog(
          title: Text(s.selectMapStyle),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: MapStyleService.styles.length,
              itemBuilder: (context, index) {
                final style = MapStyleService.styles[index];
                return RadioListTile<String>(
                  title: Text(style.name),
                  value: style.name,
                  groupValue: service.currentStyle.name,
                  onChanged: (_) {
                    service.setStyle(style);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.cancel),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final s = S.of(context);
        return AlertDialog(
          title: Text(s.deleteHistoryTitle),
          content: Text(s.deleteHistoryConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.cancel),
            ),
            TextButton(
              onPressed: () {
                widget.onDeleteHistory?.call();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Path history deleted.')),
                );
              },
              child: Text(s.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

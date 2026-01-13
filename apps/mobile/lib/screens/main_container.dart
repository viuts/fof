import 'package:flutter/material.dart';
import 'achievements_screen.dart';
import 'account_screen.dart';
import 'journal_screen.dart';
import 'quest_selection_screen.dart';
import 'map_screen.dart';
import '../theme/app_theme.dart';
import '../services/language_service.dart';
import '../api/fof/v1/shop.pb.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';
import '../services/purchase_service.dart';
import 'paywall_screen.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 2; // Default to Map (Middle)
  Shop? _questShop; // Quest destination shop

  // These will be used to pass data or trigger resets
  final GlobalKey<MapScreenState> _mapKey = GlobalKey<MapScreenState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSubscription();
    });
  }

  void _checkSubscription() {
    final userService = Provider.of<UserService>(context, listen: false);
    final purchaseService = Provider.of<PurchaseService>(
      context,
      listen: false,
    );

    if (userService.isTrialExpired && !purchaseService.isPro) {
      PaywallScreen.show(context, isGate: true);
    }
  }

  void startQuest(Shop shop) {
    setState(() {
      _questShop = shop;
      _currentIndex = 2; // Switch to map tab
    });
  }

  void cancelQuest() {
    setState(() {
      _questShop = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          QuestSelectionScreen(onStartQuest: startQuest),
          const JournalScreen(),
          MapScreen(
            key: _mapKey,
            questShop: _questShop,
            onCancelQuest: cancelQuest,
          ),
          const AchievementsScreen(),
          const AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: AppTheme.lightSurface,
        elevation: 10,
        height: 72, // Main bar height
        padding: EdgeInsets.zero,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        child: SafeArea(
          top: false,
          bottom: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(
                0,
                Icons.explore_outlined,
                Icons.explore,
                S.of(context).tabQuest,
              ),
              _buildTabItem(
                1,
                Icons.auto_stories_outlined,
                Icons.auto_stories,
                S.of(context).tabJournal,
              ),
              SizedBox(height: 16, width: 16),
              FloatingActionButton(
                onPressed: () {
                  if (_currentIndex == 2) {
                    _mapKey.currentState?.recenter();
                  } else {
                    setState(() => _currentIndex = 2);
                  }
                },
                backgroundColor: AppTheme.primaryColor,
                elevation: 0,
                shape: const CircleBorder(),
                child: const Icon(Icons.map, color: Colors.white, size: 30),
              ),
              SizedBox(height: 16, width: 16),
              _buildTabItem(
                3,
                Icons.emoji_events_outlined,
                Icons.emoji_events,
                S.of(context).tabAwards,
              ),
              _buildTabItem(
                4,
                Icons.person_outline,
                Icons.person,
                S.of(context).tabAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(
    int index,
    IconData outlineIcon,
    IconData solidIcon,
    String label,
  ) {
    // Index 2 is handled by the FAB
    if (index == 2) return const SizedBox.shrink();

    final isSelected = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? solidIcon : outlineIcon,
              color: isSelected
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondaryLight,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondaryLight,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

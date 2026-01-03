import 'package:flutter/material.dart';
import 'achievements_screen.dart';
import 'account_screen.dart';
import 'journal_screen.dart';
import 'quest_selection_screen.dart';
import 'map_screen.dart';
import '../theme/app_theme.dart';
import '../services/language_service.dart';
import '../api/fof/v1/fof.pb.dart';

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
      extendBody: true, // Allows the map to show behind the tab bar
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
          AccountScreen(
            onDeleteHistory: () {
              // Reset the map state when history is deleted
              _mapKey.currentState?.clearHistory();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: AppTheme.lightSurface,
        elevation: 10,
        height: 72, // Explicit height for better control
        padding: EdgeInsets.zero, // We use SafeArea inside
        shadowColor: Colors.black.withValues(alpha: 0.2),
        child: SafeArea(
          top: false,
          bottom: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(0, Icons.explore_outlined, Icons.explore, S.of(context).tabQuest),
              _buildTabItem(1, Icons.auto_stories_outlined, Icons.auto_stories, S.of(context).tabJournal),
              const SizedBox(width: 52), // Space for FAB
              _buildTabItem(3, Icons.emoji_events_outlined, Icons.emoji_events, S.of(context).tabAwards),
              _buildTabItem(4, Icons.person_outline, Icons.person, S.of(context).tabAccount),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => setState(() => _currentIndex = 2),
          backgroundColor: _currentIndex == 2 ? AppTheme.primaryColor : Colors.white,
          elevation: 0,
          shape: const CircleBorder(),
          child: Icon(
            Icons.map,
            color: _currentIndex == 2 ? Colors.white : AppTheme.textSecondaryLight,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTabItem(int index, IconData outlineIcon, IconData solidIcon, String label) {
    // We skip index 2 in the Row because it's handled by the FAB
    if (index == 2) return const SizedBox.shrink();

    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? solidIcon : outlineIcon,
            color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryLight,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryLight,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

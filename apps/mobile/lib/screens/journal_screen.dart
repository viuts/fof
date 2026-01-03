import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import '../api/fof/v1/fof.pb.dart';
import '../services/language_service.dart';
import 'visit_detail_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final ApiService _apiService = ApiService();
  List<VisitedShop> _visitedShops = [];
  bool _isLoading = true;
  String? _error;
  String _selectedCategory = 'ALL';

  final List<Map<String, dynamic>> _categories = [
    {'id': 'ALL', 'label': 'ALL', 'icon': Icons.history_rounded},
    {'id': 'RESTAURANT', 'label': 'DINING', 'icon': Icons.restaurant_rounded},
    {'id': 'CAFE', 'label': 'CAFE', 'icon': Icons.coffee_rounded},
    {'id': 'BAR', 'label': 'BAR', 'icon': Icons.local_bar_rounded},
    {'id': 'OTHERS', 'label': 'OTHER', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _loadVisitedShops();
  }

  Future<void> _loadVisitedShops() async {
    try {
      final response = await _apiService.getVisitedShops();
      setState(() {
        _visitedShops = response.visitedShops;
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
    final s = S.of(context);
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(s.journalTitle),
        backgroundColor: AppTheme.lightSurface,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() => _isLoading = true);
              _loadVisitedShops();
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
            const Icon(Icons.error_outline_rounded, size: 48, color: Colors.red),
            const SizedBox(height: AppTheme.spacingMd),
            Text('Error: $_error'),
            TextButton(
              onPressed: _loadVisitedShops,
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
        // Right Content: Filtered Visited Shops
        Expanded(
          child: _buildVisitedShopsList(),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
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
          final isSelected = _selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat['id']),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: isSelected ? const Border(
                  right: BorderSide(color: AppTheme.primaryColor, width: 3),
                ) : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cat['icon'],
                    color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryLight,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryLight,
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

  Widget _buildVisitedShopsList() {
    final filtered = _selectedCategory == 'ALL'
        ? _visitedShops
        : _visitedShops.where((v) {
            final cat = v.shop.category.toUpperCase();
            if (_selectedCategory == 'OTHERS') {
              return cat != 'RESTAURANT' && cat != 'CAFE' && cat != 'BAR';
            }
            return cat == _selectedCategory;
          }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 48, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              'No visits yet.',
              style: TextStyle(color: AppTheme.textSecondaryLight),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final visit = filtered[index];
        final isLast = index == filtered.length - 1;
        return _buildTimelineItem(visit, isLast);
      },
    );
  }

  Widget _buildTimelineItem(VisitedShop visit, bool isLast) {
    final shop = visit.shop;
    final visitedAt = DateTime.parse(visit.visitedAt).toLocal();
    final timeStr = '${visitedAt.hour.toString().padLeft(2, '0')}:${visitedAt.minute.toString().padLeft(2, '0')}';
    final dateStr = '${visitedAt.day.toString().padLeft(2, '0')} ${_getMonthName(visitedAt.month)}';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppTheme.primaryColor.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      timeStr,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '| $dateStr',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildVisitedShopCard(visit),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitedShopCard(VisitedShop visit) {
    final shop = visit.shop;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitDetailScreen(visit: visit),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        decoration: BoxDecoration(
          color: AppTheme.lightSurface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForCategory(shop.category),
                color: AppTheme.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimaryLight,
                    ),
                  ),
                  Text(
                    shop.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[month - 1];
  }

  IconData _getIconForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'RESTAURANT':
        return Icons.restaurant_rounded;
      case 'CAFE':
        return Icons.coffee_rounded;
      case 'BAR':
        return Icons.local_bar_rounded;
      default:
        return Icons.place_rounded;
    }
  }
}

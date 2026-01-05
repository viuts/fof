import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import '../api/fof/v1/fof.pb.dart';
import '../constants/category_colors.dart';
import '../services/language_service.dart';
import '../api/fof/v1/shop_extensions.dart';
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
  FoodCategory? _selectedCategory; // null means ALL

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
    final s = S.of(context);
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
            Text(s.errorLabel(_error!)),
            TextButton(onPressed: _loadVisitedShops, child: Text(s.retry)),
          ],
        ),
      );
    }

    return Row(
      children: [
        // Left Sidebar: Categories
        _buildSidebar(),
        // Right Content: Filtered Visited Shops
        Expanded(child: _buildVisitedShopsList()),
      ],
    );
  }

  Widget _buildSidebar() {
    final s = S.of(context);
    final groups = ShopCategory.getGroupedCategories(s);
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: AppTheme.lightSurface,
        border: Border(
          right: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: ListView(
        children: [
          // "ALL" Option
          _buildSidebarItem(
            icon: Icons.history_rounded,
            label: s.achCategoryAll,
            isSelected: _selectedCategory == null,
            onTap: () => setState(() => _selectedCategory = null),
          ),
          const Divider(height: 1),
          // Grouped Categories
          ...groups.map((group) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    group.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[400],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                ...group.categories.map((cat) {
                  return _buildSidebarItem(
                    icon: ShopCategory.getIcon(cat),
                    label: s.translateCategory(cat),
                    isSelected: _selectedCategory == cat,
                    onTap: () => setState(() => _selectedCategory = cat),
                    activeColor: ShopCategory.getColor(cat),
                  );
                }),
                const Divider(height: 1),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color activeColor = AppTheme.primaryColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          border: isSelected
              ? Border(right: BorderSide(color: activeColor, width: 3))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : AppTheme.textSecondaryLight,
              size: 24,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? activeColor : AppTheme.textSecondaryLight,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitedShopsList() {
    final s = S.of(context);
    final filtered = _selectedCategory == null
        ? _visitedShops
        : _visitedShops
              .where((v) => v.shop.effectiveFoodCategory == _selectedCategory)
              .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 48, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              s.noVisitsYet,
              style: TextStyle(color: AppTheme.textSecondaryLight),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        left: AppTheme.spacingMd,
        right: AppTheme.spacingMd,
        top: AppTheme.spacingMd,
        bottom: 16, // Extra space for FAB and bottom bar
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final visit = filtered[index];
        final isLast = index == filtered.length - 1;
        return _buildTimelineItem(visit, isLast);
      },
    );
  }

  Widget _buildTimelineItem(VisitedShop visit, bool isLast) {
    final visitedAt = DateTime.parse(visit.visitedAt).toLocal();
    final timeStr =
        '${visitedAt.hour.toString().padLeft(2, '0')}:${visitedAt.minute.toString().padLeft(2, '0')}';
    final dateStr =
        '${visitedAt.day.toString().padLeft(2, '0')} ${_getMonthName(context, visitedAt.month)}';

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
                ShopCategory.getIcon(shop.effectiveFoodCategory),
                color: ShopCategory.getColor(shop.effectiveFoodCategory),
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
                    S.of(context).translateCategory(shop.effectiveFoodCategory),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(BuildContext context, int month) {
    final s = S.of(context);
    final months = [
      s.monthJan,
      s.monthFeb,
      s.monthMar,
      s.monthApr,
      s.monthMay,
      s.monthJun,
      s.monthJul,
      s.monthAug,
      s.monthSep,
      s.monthOct,
      s.monthNov,
      s.monthDec,
    ];
    return months[month - 1];
  }
}

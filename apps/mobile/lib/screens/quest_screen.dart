import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/shop.dart';
import '../constants/category_colors.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';
import '../widgets/shop_category.dart'; // Added import
import '../services/language_service.dart'; // Added import

/// Quest Mode screen with category selection and compass navigation
/// Implements FR-10, FR-11, FR-12 from PRD
class QuestScreen extends StatefulWidget {
  final Position? currentPosition;
  
  const QuestScreen({
    super.key,
    this.currentPosition,
  });

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> with TickerProviderStateMixin {
  String? _selectedCategory;
  Shop? _targetShop;
  bool _isQuestActive = false;
  late AnimationController _compassController;

  @override
  void initState() {
    super.initState();
    _compassController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _compassController.dispose();
    super.dispose();
  }

  void _startQuest(String category) async {
    try {
      final response = await ApiService().getQuestShop(category);
      if (response.shops.isNotEmpty) {
        setState(() {
          _selectedCategory = category;
          _isQuestActive = true;
          _targetShop = response.shops.first;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hidden gems found in this category nearby.')),
        );
      }
    } catch (e) {
      debugPrint('Quest error: $e');
      // Fallback for demo/dev if API fails
      setState(() {
        _selectedCategory = category;
        _isQuestActive = true;
        _targetShop = Shop(
          id: 'quest_1',
          name: '???',
          lat: widget.currentPosition!.latitude + 0.001,
          lng: widget.currentPosition!.longitude + 0.001,
          category: category,
          isChain: false,
        );
      });
    }
  }

  void _cancelQuest() {
    setState(() {
      _selectedCategory = null;
      _targetShop = null;
      _isQuestActive = false;
    });
  }

  double _calculateDistance() {
    final pos = widget.currentPosition ?? LocationService().currentPosition;
    if (pos == null || _targetShop == null) return 0;
    return Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      _targetShop!.lat,
      _targetShop!.lng,
    );
  }

  double _calculateBearing() {
    final pos = widget.currentPosition ?? LocationService().currentPosition;
    if (pos == null || _targetShop == null) return 0;
    return Geolocator.bearingBetween(
      pos.latitude,
      pos.longitude,
      _targetShop!.lat,
      _targetShop!.lng,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quest Mode'),
        actions: [
          if (_isQuestActive)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _cancelQuest,
              tooltip: 'Cancel Quest',
            ),
        ],
      ),
      body: _isQuestActive ? _buildActiveQuest() : _buildCategorySelection(),
    );
  }

  Widget _buildCategorySelection() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Your Cuisine Quest',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Select a category to discover a hidden restaurant',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppTheme.spacingMd,
                mainAxisSpacing: AppTheme.spacingMd,
                childAspectRatio: 1.2,
              ),
              itemCount: ShopCategory.allCategories.length,
              itemBuilder: (context, index) {
                final category = ShopCategory.allCategories[index];
                final color = ShopCategory.getColor(category);
                
                return _buildCategoryCard(category, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category, Color color) {
    return GestureDetector(
      onTap: widget.currentPosition != null
          ? () => _startQuest(category)
          : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.3),
              color.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: 48,
              color: color,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              S.of(context).translateCategory(category),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveQuest() {
    if (_targetShop == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final distance = _calculateDistance();
    final bearing = _calculateBearing();

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          // Quest header
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: BoxDecoration(
              color: AppTheme.darkSurfaceVariant,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: ShopCategory.getColor(_selectedCategory!).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Icon(
                    Icons.explore,
                    color: ShopCategory.getColor(_selectedCategory!),
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).translateCategory(_selectedCategory!),
                        style: TextStyle(
                          fontSize: 12,
                          color: ShopCategory.getColor(_selectedCategory!),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Quest Active',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          
          // Compass (FR-12)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Compass widget
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CustomPaint(
                      painter: CompassPainter(
                        bearing: bearing,
                        color: ShopCategory.getColor(_selectedCategory!),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXl),
                  
                  // Distance indicator
                  Column(
                    children: [
                      if (distance < 30) // Reveal when within 30m
                        Column(
                          children: [
                            const Text(
                              'ARRIVED!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingSm),
                            Text(
                              'Hidden Gem: ${_targetShop?.name ?? "Independent Shop"}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            Text(
                              '${distance.toInt()}m',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'to destination',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Info text
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(
                color: Colors.amber.withOpacity(0.3),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.amber, size: 20),
                SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: Text(
                    'Restaurant details will be revealed when you arrive',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.amber,
                    ),
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

/// Custom painter for the compass needle
class CompassPainter extends CustomPainter {
  final double bearing;
  final Color color;

  CompassPainter({
    required this.bearing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw outer circle
    final circlePaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    // Draw circle border
    final borderPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius, borderPaint);

    // Draw cardinal directions
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final directions = ['N', 'E', 'S', 'W'];
    for (int i = 0; i < 4; i++) {
      final angle = (i * 90) * math.pi / 180;
      final x = center.dx + (radius - 30) * math.sin(angle);
      final y = center.dy - (radius - 30) * math.cos(angle);

      textPainter.text = TextSpan(
        text: directions[i],
        style: TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    // Draw needle pointing in bearing direction
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(bearing * math.pi / 180);

    final needlePath = Path();
    needlePath.moveTo(0, -radius + 40);
    needlePath.lineTo(15, 0);
    needlePath.lineTo(0, 20);
    needlePath.lineTo(-15, 0);
    needlePath.close();

    final needlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(needlePath, needlePaint);

    canvas.restore();

    // Draw center dot
    final centerDotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, centerDotPaint);
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) {
    return bearing != oldDelegate.bearing || color != oldDelegate.color;
  }
}

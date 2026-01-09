import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/shop_extensions.dart'; // Import extensions for effectiveFoodCategory
import '../constants/category_colors.dart';
import '../theme/app_theme.dart';
import '../services/location_service.dart';
import '../services/language_service.dart';

import 'quest_selection_screen.dart';

/// Quest Mode screen with category selection and compass navigation
/// Implements FR-10, FR-11, FR-12 from PRD
class QuestScreen extends StatefulWidget {
  final Position? currentPosition;

  const QuestScreen({super.key, this.currentPosition});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen>
    with TickerProviderStateMixin {
  FoodCategory? _selectedCategory;
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
        title: Text(S.of(context).questModeLabel),
        actions: [
          if (_isQuestActive)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _cancelQuest,
              tooltip: S.of(context).cancelQuestLabel,
            ),
        ],
      ),
      body: _isQuestActive ? _buildActiveQuest() : _buildCategorySelection(),
    );
  }

  Widget _buildCategorySelection() {
    // Delegate to the dedicated selection screen
    // Since QuestSelectionScreen is a Scaffold, we probably want to just return it directly
    // in build() instead of nesting it here, OR QuestSelectionScreen shouldn't be a Scaffold.
    // However, assuming for now we return it.
    // But wait, _buildCategorySelection is returned by build() inside Scaffold body?
    // QuestScreen build() returns a Scaffold.
    // If I nest a Scaffold in body, it's okay but might have double AppBars.
    // QuestScreen has an AppBar. QuestSelectionScreen (if I recall) has body but no AppBar?
    // Let's check Step 2227. QuestSelectionScreen returns Scaffold.
    // It does NOT have an AppBar.
    // So nesting is acceptable, or better:

    return QuestSelectionScreen(
      onStartQuest: (shop) {
        setState(() {
          _selectedCategory = shop.effectiveFoodCategory;
          _isQuestActive = true;
          _targetShop = shop;
        });
      },
    );
  }

  Widget _buildActiveQuest() {
    if (_targetShop == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final distance = _calculateDistance();
    final bearing = _calculateBearing();

    return SingleChildScrollView(
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
                    color: ShopCategory.getColor(
                      _selectedCategory!,
                    ).withValues(alpha: 0.2),
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
                      Text(
                        S.of(context).questActiveLabel,
                        style: const TextStyle(
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

          // Compass and Distance (Centered and compacted)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Compass
              SizedBox(
                width: 220, // Slightly smaller
                height: 220,
                child: CustomPaint(
                  painter: CompassPainter(
                    bearing: bearing,
                    color: ShopCategory.getColor(_selectedCategory!),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Distance indicator
              if (distance < 30)
                Column(
                  children: [
                    Text(
                      S.of(context).visitComplete,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _targetShop?.name ?? S.of(context).independentShop,
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
                      distance >= 1000
                          ? '${(distance / 1000).toStringAsFixed(1)} km'
                          : '${distance.toInt()}m',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                      ),
                    ),
                    Text(
                      S.of(context).toDestination,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: Text(
                    S.of(context).revealOnArrival,
                    style: const TextStyle(fontSize: 12, color: Colors.amber),
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

  CompassPainter({required this.bearing, required this.color});

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
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

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

import 'package:flutter/material.dart';
import '../models/shop.dart';

/// Custom marker widget for shop beacons with category-based coloring
/// Implements FR-5 and FR-6 from PRD
class ShopBeacon extends StatefulWidget {
  final Shop shop;
  final VoidCallback? onTap;
  final bool showPulse;
  final bool isInClearedArea;

  const ShopBeacon({
    super.key,
    required this.shop,
    this.onTap,
    this.showPulse = false,
    this.isInClearedArea = true,
  });

  @override
  State<ShopBeacon> createState() => _ShopBeaconState();
}

class _ShopBeaconState extends State<ShopBeacon>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.showPulse) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shop = widget.shop;
    
    return GestureDetector(
      onTap: widget.onTap,
      child: Opacity(
        opacity: widget.isInClearedArea ? 1.0 : 0.75,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: widget.showPulse ? _pulseAnimation.value : 1.0,
              child: child,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow for visited shops
              if (shop.isVisited && widget.isInClearedArea)
                Container(
                  width: shop.markerSize + 10,
                  height: shop.markerSize + 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: shop.color.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              
              // Main beacon icon
              Container(
                width: shop.markerSize,
                height: shop.markerSize,
                decoration: BoxDecoration(
                  color: shop.isVisited ? shop.color : Colors.grey[600],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  _getIconForCategory(shop.category),
                  size: shop.markerSize * 0.55,
                  color: Colors.white,
                ),
              ),
              
              // Chain badge (small indicator)
              if (shop.isChain)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: shop.markerSize * 0.35,
                    height: shop.markerSize * 0.35,
                    decoration: BoxDecoration(
                      color: const Color(0xFF424242),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.link,
                      size: shop.markerSize * 0.2,
                      color: Colors.white70,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    final lower = category.toLowerCase();
    
    if (lower.contains('ramen') || lower.contains('noodle') || lower.contains('ラーメン') || lower.contains('そば') || lower.contains('うどん') || lower.contains('麺')) {
      return Icons.ramen_dining;
    }
    if (lower.contains('cafe') || lower.contains('coffee') || lower.contains('tea') || lower.contains('カフェ') || lower.contains('喫茶') || lower.contains('コーヒー')) {
      return Icons.local_cafe;
    }
    if (lower.contains('izakaya') || lower.contains('pub') || lower.contains('bar') || lower.contains('alcohol') || lower.contains('居酒屋') || lower.contains('バー') || lower.contains('酒')) {
      return Icons.local_bar;
    }
    if (lower.contains('sushi') || lower.contains('seafood') || lower.contains('fish') || lower.contains('寿司') || lower.contains('海鮮') || lower.contains('魚')) {
      return Icons.set_meal;
    }
    if (lower.contains('italian') || lower.contains('pizza') || lower.contains('pasta') || lower.contains('イタリアン') || lower.contains('ピザ') || lower.contains('パスタ')) {
      return Icons.local_pizza;
    }
    if (lower.contains('french') || lower.contains('bistro') || lower.contains('フレンチ') || lower.contains('ビストロ')) {
      return Icons.wine_bar;
    }
    if (lower.contains('chinese') || lower.contains('dumpling') || lower.contains('中華') || lower.contains('餃子')) {
      return Icons.rice_bowl;
    }
    if (lower.contains('korean') || lower.contains('bibimbap') || lower.contains('韓国') || lower.contains('焼肉')) {
      return Icons.outdoor_grill;
    }
    if (lower.contains('steak') || lower.contains('meat') || lower.contains('hamburger') || lower.contains('burg') || lower.contains('ステーキ') || lower.contains('肉') || lower.contains('ハンバーグ')) {
      return Icons.dinner_dining;
    }
    if (lower.contains('bakery') || lower.contains('bread') || lower.contains('cake') || lower.contains('sweet') || lower.contains('パン') || lower.contains('ケーキ') || lower.contains('スイーツ')) {
      return Icons.bakery_dining;
    }
    if (lower.contains('fast food') || lower.contains('burger') || lower.contains('ファストフード') || lower.contains('ハンバーガー')) {
      return Icons.fastfood;
    }
    if (lower.contains('convenience') || lower.contains('store') || lower.contains('コンビニ')) {
      return Icons.storefront;
    }
    
    return Icons.restaurant;
  }
}

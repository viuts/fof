import 'package:flutter/material.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/shop_extensions.dart';
import '../constants/category_colors.dart';

/// Custom marker widget for shop beacons with category-based coloring
/// Implements FR-5 and FR-6 from PRD
class ShopBeacon extends StatefulWidget {
  final Shop shop;
  final VoidCallback? onTap;
  final bool showPulse;
  final bool showName;
  final bool isInClearedArea;

  const ShopBeacon({
    super.key,
    required this.shop,
    this.onTap,
    this.showPulse = false,
    this.showName = false,
    this.isInClearedArea = true,
  });

  @override
  State<ShopBeacon> createState() => _ShopBeaconState();
}

class _ShopBeaconState extends State<ShopBeacon>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;
  Animation<double>? _pulseAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.showPulse) {
      _pulseController = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      );
      _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
        CurvedAnimation(parent: _pulseController!, curve: Curves.easeInOut),
      );
      _pulseController!.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shop = widget.shop;

    Widget child = Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
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
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            ShopCategory.getIcon(shop.effectiveFoodCategory),
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
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Icon(
                Icons.link,
                size: shop.markerSize * 0.2,
                color: Colors.white70,
              ),
            ),
          ),

        // Shop Name Label
        if (widget.showName && widget.isInClearedArea)
          Positioned(
            top: shop.markerSize + 4,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 100),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Text halo/outline for better readability
                  Text(
                    shop.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2.5
                        ..color = Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  Text(
                    shop.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      color: shop.isVisited ? Colors.black87 : Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );

    if (widget.showPulse && _pulseAnimation != null) {
      child = AnimatedBuilder(
        animation: _pulseAnimation!,
        builder: (context, child) {
          return Transform.scale(scale: _pulseAnimation!.value, child: child);
        },
        child: child,
      );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Opacity(
        opacity: widget.isInClearedArea ? 1.0 : 0.75,
        child: child,
      ),
    );
  }
}

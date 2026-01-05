import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:geolocator/geolocator.dart';
import '../api/fof/v1/fof.pb.dart';
import '../api/fof/v1/shop_extensions.dart';
import '../theme/app_theme.dart';
import '../constants/category_colors.dart';
import '../utils/geo_utils.dart';
import '../services/language_service.dart';

class ShopDetailCard extends StatelessWidget {
  final Shop shop;
  final latlong2.LatLng? currentLocation;
  final String? clearedAreaGeojson;
  final VoidCallback onClose;
  final Function(Shop) onEnterShop;

  const ShopDetailCard({
    super.key,
    required this.shop,
    required this.currentLocation,
    required this.clearedAreaGeojson,
    required this.onClose,
    required this.onEnterShop,
  });

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? AppTheme.textSecondaryLight),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: AppTheme.textSecondaryLight,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: color ?? AppTheme.textPrimaryLight,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final shopLocation = latlong2.LatLng(shop.lat, shop.lng);
    final isInClearedArea = GeoUtils.isPointInClearedArea(
      shopLocation,
      clearedAreaGeojson,
    );

    final distanceToShop = currentLocation == null
        ? double.infinity
        : Geolocator.distanceBetween(
            currentLocation!.latitude,
            currentLocation!.longitude,
            shop.lat,
            shop.lng,
          );

    // Shop is discovered if it's in a cleared area OR user is very close (fallback for lag)
    final isDiscovered = isInClearedArea || distanceToShop <= 50;

    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightSurface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop is in fog - show limited info
              if (!isDiscovered) ...[
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: shop.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        ShopCategory.getIcon(shop.effectiveFoodCategory),
                        color: shop.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S
                                .of(context)
                                .translateCategory(shop.effectiveFoodCategory),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: shop.color,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '???',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondaryLight.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.explore_off,
                        color: AppTheme.textSecondaryLight,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          S.of(context).exploreAreaMsg,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondaryLight,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Shop is in cleared area - show full details
              if (isDiscovered) ...[
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: shop.isVisited
                            ? shop.color.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        ShopCategory.getIcon(shop.effectiveFoodCategory),
                        color: shop.isVisited ? shop.color : Colors.grey,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: shop.isVisited
                                  ? AppTheme.textPrimaryLight
                                  : Colors.grey.shade600,
                              letterSpacing: -0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .translateCategory(
                                      shop.effectiveFoodCategory,
                                    ),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: shop.isVisited
                                      ? shop.color
                                      : Colors.grey,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                          if (shop.reservable)
                            Row(
                              children: [
                                Icon(
                                  Icons.event_available,
                                  size: 11,
                                  color: Colors.green.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Reservable',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailRow(
                  Icons.location_on_outlined,
                  S.of(context).locationLabel,
                  shop.address.isNotEmpty
                      ? shop.address
                      : '${shop.lat.toStringAsFixed(4)}, ${shop.lng.toStringAsFixed(4)}',
                ),
                if (shop.isVisited) ...[
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.check_circle_outline,
                    S.of(context).statusLabel,
                    S.of(context).visitedLabel,
                    color: Colors.green.shade600,
                  ),
                ],
                const SizedBox(height: 20),
                if (!shop.isVisited) ...[
                  Builder(
                    builder: (context) {
                      final canEnter = distanceToShop <= 25;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!canEnter)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                S.of(context).tooFarToEnter,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ElevatedButton(
                            onPressed: canEnter
                                ? () => onEnterShop(shop)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: canEnter
                                  ? Colors.green.shade600
                                  : Colors.grey.shade300,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: canEnter ? 2 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              S.of(context).enterShop,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

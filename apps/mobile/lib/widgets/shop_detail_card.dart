import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:geolocator/geolocator.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/shop_extensions.dart';
import '../theme/app_theme.dart';
import '../constants/category_colors.dart';
import '../utils/geo_utils.dart';
import '../services/language_service.dart';

class ShopDetailCard extends StatelessWidget {
  final Shop shop;
  final latlong2.LatLng? currentLocation;
  final List<List<latlong2.LatLng>> clearedRings;
  final VoidCallback onClose;
  final Function(Shop) onEnterShop;
  final bool isEntering;
  final bool isSubmitting;
  final int remainingSeconds;
  final VoidCallback? onCancelEntering;
  final VoidCallback? onViewVisit;

  const ShopDetailCard({
    super.key,
    required this.shop,
    required this.currentLocation,
    required this.clearedRings,
    required this.onClose,
    required this.onEnterShop,
    this.isEntering = false,
    this.isSubmitting = false,
    this.remainingSeconds = 0,
    this.onCancelEntering,
    this.onViewVisit,
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
    final s = S.of(context);
    final shopLocation = latlong2.LatLng(shop.lat, shop.lng);
    final isInClearedArea = GeoUtils.isPointInClearedArea(
      shopLocation,
      clearedRings,
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
                            s.translateCategory(shop.effectiveFoodCategory),
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
                          s.exploreAreaMsg,
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
                                s.translateCategory(shop.effectiveFoodCategory),
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
                if (isEntering) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                s.verificationInProgress,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value:
                              remainingSeconds / 10, // Assuming 10s countdown
                          backgroundColor: Colors.orange.withValues(alpha: 0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.orange,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          minHeight: 6,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s.remainingTime(
                            remainingSeconds ~/ 60,
                            remainingSeconds % 60,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'monospace',
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ] else ...[
                  _buildDetailRow(
                    Icons.location_on_outlined,
                    s.locationLabel,
                    shop.address.isNotEmpty
                        ? shop.address
                        : '${shop.lat.toStringAsFixed(4)}, ${shop.lng.toStringAsFixed(4)}',
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.access_time_outlined,
                    s.openingHours,
                    shop.todaysOpeningHours.isNotEmpty
                        ? shop.todaysOpeningHours
                        : s.hoursUnknown,
                    color: shop.isOpen && shop.todaysOpeningHours.isNotEmpty
                        ? Colors.green.shade600
                        : Colors.red.shade600,
                  ),
                  if (shop.isVisited) ...[
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      Icons.check_circle_outline,
                      s.statusLabel,
                      s.visitedLabel,
                      color: Colors.green.shade600,
                    ),
                  ],
                  const SizedBox(height: 20),
                ],

                if (!shop.isVisited) ...[
                  Builder(
                    builder: (context) {
                      final canEnter = distanceToShop <= 25;
                      final isOpen = shop.isOpen;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!isEntering) ...[
                            if (!isOpen)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  s.closedToEnter,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            if (isOpen && !canEnter)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  s.tooFarToEnter,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                          ElevatedButton(
                            onPressed: isSubmitting
                                ? null
                                : isEntering
                                ? onCancelEntering
                                : (canEnter && isOpen)
                                ? () => onEnterShop(shop)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSubmitting
                                  ? Colors.grey.shade200
                                  : isEntering
                                  ? Colors.red.shade50
                                  : (canEnter && isOpen)
                                  ? Colors.green.shade600
                                  : Colors.grey.shade300,
                              foregroundColor: isSubmitting
                                  ? Colors.grey.shade600
                                  : isEntering
                                  ? Colors.red
                                  : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: (canEnter && isOpen && !isSubmitting)
                                  ? 2
                                  : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: isEntering && !isSubmitting
                                    ? BorderSide(color: Colors.red.shade200)
                                    : BorderSide.none,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isSubmitting) ...[
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                Text(
                                  isSubmitting
                                      ? '確認中'
                                      : isEntering
                                      ? s.cancel
                                      : s.enterShop,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],

                // Action button for visited shops (View Review)
                if (shop.isVisited) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onViewVisit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      foregroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.rate_review_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          s.viewReview,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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

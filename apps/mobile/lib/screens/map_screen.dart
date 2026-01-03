import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:geolocator/geolocator.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';
import '../services/language_service.dart';
import '../models/shop.dart';
import '../widgets/fog_layer.dart';
import '../widgets/shop_beacon.dart';
import '../theme/app_theme.dart';
import '../utils/geo_utils.dart';
import '../api/fof/v1/fof.pb.dart' as fof_pb;

class MapScreen extends StatefulWidget {
  final Shop? questShop;
  final VoidCallback? onCancelQuest;
  
  const MapScreen({
    super.key,
    this.questShop,
    this.onCancelQuest,
  });

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  final FocusNode _focusNode = FocusNode();
  String? _clearedAreaGeojson;
  final List<Shop> _nearbyShops = [];
  final List<Shop> _visitedShops = [];
  latlong2.LatLng? _currentLocation;
  double? _currentHeading; // Compass heading in degrees
  Timer? _shopUpdateTimer;
  Timer? _locationBatchTimer;
  bool _hasCentered = false;
  int _virtualStepCount = 0;
  
  // Shop Entry Feature
  bool _isEntering = false;
  Shop? _enteringShop;
  Timer? _countdownTimer;
  int _remainingSeconds = 0;
  int _currentLevel = 1;
  int _currentExp = 0;

  // Blast Animation
  late AnimationController _blastController;
  latlong2.LatLng? _blastCenterLocation;

  @override
  void initState() {
    super.initState();
    _startLocationService();
    _shopUpdateTimer = Timer.periodic(const Duration(seconds: 30), (_) => _loadShops());
    _locationBatchTimer = Timer.periodic(const Duration(seconds: 10), (_) => _sendBatchedLocationUpdate());
    
    _blastController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() => setState(() {}));
  }

  Future<void> _startLocationService() async {
    try {
      await LocationService().startTracking(
        onLocationUpdate: (lat, lng) {
          final newLoc = latlong2.LatLng(lat, lng);
          
          // Calculate heading from movement direction
          if (_currentLocation != null) {
            final bearing = Geolocator.bearingBetween(
              _currentLocation!.latitude,
              _currentLocation!.longitude,
              lat,
              lng,
            );
            setState(() {
              _currentLocation = newLoc;
              _currentHeading = bearing;
            });
          } else {
            setState(() {
              _currentLocation = newLoc;
            });
          }
          
          if (!_hasCentered) {
            _hasCentered = true;
            _mapController.move(newLoc, 15.0);
          }
        },
      );
      _loadInitialData();
    } catch (e) {
      debugPrint('Error starting location service: $e');
    }
  }

  Future<void> _loadInitialData() async {
    try {
      final response = await ApiService().getClearedArea();
      setState(() {
        _clearedAreaGeojson = response.clearedAreaGeojson;
      });
      _loadShops();
    } catch (e) {
      debugPrint('Failed to load initial data: $e');
      _loadShops();
    }
  }

  Future<void> _sendBatchedLocationUpdate() async {
    final pathPositions = await LocationService().getPath();
    if (pathPositions.isEmpty) return;

    try {
      final path = pathPositions
          .map((p) => fof_pb.LatLng(lat: p.latitude, lng: p.longitude))
          .toList();
      final response = await ApiService().updateLocation(path);
      
      // ONLY flush the path from local storage if the backend call was successful
      await LocationService().clearPath();
      
      if (response.newlyCleared) {
        setState(() {
          _clearedAreaGeojson = response.clearedAreaGeojson;
        });
      }
    } catch (e) {
      debugPrint('Failed to update location (will retry): $e');
    }
  }

  Future<void> _loadShops() async {
    if (_currentLocation == null) return;
    try {
      final nearby = await ApiService().getNearbyShops(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        1000.0, // 1km radius
      );
      final visited = await ApiService().getVisitedShops();
      setState(() {
        _nearbyShops.clear();
        _nearbyShops.addAll(nearby.shops);
        _visitedShops.clear();
        _visitedShops.addAll(visited.shops);
      });
    } catch (e) {
      debugPrint('Failed to load shops: $e');
    }
  }

  void _showShopDetails(Shop shop) {
    final shopLocation = latlong2.LatLng(shop.lat, shop.lng);
    final isInClearedArea = GeoUtils.isPointInClearedArea(shopLocation, _clearedAreaGeojson);
    
    final distanceToShop = _currentLocation == null 
        ? double.infinity 
        : Geolocator.distanceBetween(
            _currentLocation!.latitude,
            _currentLocation!.longitude,
            shop.lat,
            shop.lng,
          );
    
    // Shop is discovered if it's in a cleared area OR user is very close (fallback for lag)
    final isDiscovered = isInClearedArea || distanceToShop <= 50;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightSurface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textSecondaryLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Shop is in fog - show limited info
            if (!isDiscovered) ...[
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: shop.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: shop.color,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).translateCategory(shop.category),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: shop.color,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
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
                ],
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.textSecondaryLight.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.explore_off,
                      color: AppTheme.textSecondaryLight,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textSecondaryLight.withValues(alpha: 0.1),
                    foregroundColor: AppTheme.textPrimaryLight,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: Text(S.of(context).close),
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
                      Icons.restaurant,
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
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: shop.isVisited 
                                ? AppTheme.textPrimaryLight 
                                : Colors.grey.shade600,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (shop.isChain)
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.textSecondaryLight.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'チェーン店',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textSecondaryLight,
                                  ),
                                ),
                              ),
                            Text(
                              S.of(context).translateCategory(shop.category),
                              style: TextStyle(
                                fontSize: 11,
                                color: shop.isVisited ? shop.color : Colors.grey,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildDetailRow(Icons.location_on_outlined, S.of(context).locationLabel, '${shop.lat.toStringAsFixed(4)}, ${shop.lng.toStringAsFixed(4)}'),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.radar_outlined, S.of(context).explorationRadius, '${shop.clearanceRadius.toInt()}m'),
              if (shop.isVisited) ...[ 
                const SizedBox(height: 16),
                _buildDetailRow(Icons.check_circle_outline, S.of(context).statusLabel, S.of(context).visitedLabel, color: Colors.green.shade600),
              ],
              const SizedBox(height: 40),
              if (!shop.isVisited) ...[
                Builder(
                  builder: (context) {
                    final distance = _currentLocation == null 
                        ? double.infinity 
                        : Geolocator.distanceBetween(
                            _currentLocation!.latitude,
                            _currentLocation!.longitude,
                            shop.lat,
                            shop.lng,
                          );
                    final canEnter = distance <= 25;

                    return Column(
                      children: [
                        if (!canEnter)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              S.of(context).tooFarToEnter,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: canEnter ? () => _startEnteringShop(shop) : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: canEnter ? Colors.green.shade600 : Colors.grey.shade300,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: canEnter ? 2 : 0,
                            ),
                            child: Text(
                              S.of(context).enterShop,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ] else 
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.textSecondaryLight.withValues(alpha: 0.1),
                      foregroundColor: AppTheme.textPrimaryLight,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: Text(S.of(context).close),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEnteringOverlay() {
    if (!_isEntering || _enteringShop == null) return const SizedBox.shrink();

    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.timer, color: Colors.orange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).verificationInProgress,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryLight,
                        ),
                      ),
                      Text(
                        _enteringShop!.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    setState(() {
                      _isEntering = false;
                      _enteringShop = null;
                      _remainingSeconds = 0;
                    });
                    _countdownTimer?.cancel();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: _remainingSeconds / (10 * 1),
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              borderRadius: BorderRadius.circular(4),
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).remainingTime(minutes, seconds),
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
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color ?? AppTheme.textSecondaryLight),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondaryLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: color ?? AppTheme.textPrimaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestOverlay() {
    if (widget.questShop == null || _currentLocation == null) {
      return const SizedBox.shrink();
    }

    final distance = Geolocator.distanceBetween(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
      widget.questShop!.lat,
      widget.questShop!.lng,
    );

    final isArrived = distance < 30; // Within 30 meters

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.explore,
                      color: Colors.orange,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).translateCategory(widget.questShop!.category),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isArrived ? widget.questShop!.name : '???',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isArrived ? AppTheme.textPrimaryLight : AppTheme.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: widget.onCancelQuest,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (isArrived)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).arrived,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.navigation, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${distance.toInt()}m',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryLight,
                      ),
                    ),
                    Text(
                      S.of(context).away,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Virtual location movement for development/testing
  void _moveVirtualLocation(String direction) {
    if (_currentLocation == null) return;
    
    // Move approximately 10 meters in the selected direction
    const double metersToMove = 10.0;
    const double metersPerDegree = 111320.0; // Approximate meters per degree of latitude
    
    double latOffset = 0;
    double lngOffset = 0;
    double newHeading = 0;
    
    switch (direction) {
      case 'up':
        latOffset = metersToMove / metersPerDegree;
        newHeading = 0; // North
        break;
      case 'down':
        latOffset = -metersToMove / metersPerDegree;
        newHeading = 180; // South
        break;
      case 'left':
        lngOffset = -metersToMove / (metersPerDegree * 0.9); // Adjust for longitude
        newHeading = 270; // West
        break;
      case 'right':
        lngOffset = metersToMove / (metersPerDegree * 0.9);
        newHeading = 90; // East
        break;
    }
    
    final newLat = _currentLocation!.latitude + latOffset;
    final newLng = _currentLocation!.longitude + lngOffset;

    setState(() {
      _currentHeading = newHeading;
    });

    // Update via service so all listeners (including map & proximity) are notified
    LocationService().updateVirtualLocation(newLat, newLng);
    
    // Trigger aggressive location update for DEV mode
    _virtualStepCount++;
    if (_virtualStepCount >= 5) {
      _virtualStepCount = 0;
      _sendBatchedLocationUpdate();
    }

    // Recenter map
    _mapController.move(latlong2.LatLng(newLat, newLng), _mapController.camera.zoom);
  }

  Widget _buildVirtualDPad() {
    return Positioned(
      left: 16,
      bottom: 100,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'DEV',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Up button
            _buildDPadButton(Icons.arrow_upward, 'up'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Left button
                _buildDPadButton(Icons.arrow_back, 'left'),
                const SizedBox(width: 8),
                // Right button
                _buildDPadButton(Icons.arrow_forward, 'right'),
              ],
            ),
            // Down button
            _buildDPadButton(Icons.arrow_downward, 'down'),
          ],
        ),
      ),
    );
  }

  Widget _buildDPadButton(IconData icon, String direction) {
    return GestureDetector(
      onTap: () => _moveVirtualLocation(direction),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  void clearHistory() {
    setState(() {
      _clearedAreaGeojson = null;
      _visitedShops.clear();
    });
  }

  void _startEnteringShop(Shop shop) {
    setState(() {
      _isEntering = true;
      _enteringShop = shop;
      _remainingSeconds = 10 * 1; // 10 minutes
    });

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _onVisitCountdownFinished();
      }
    });

    // Close the shop details modal if open
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _onVisitCountdownFinished() {
    setState(() {
      _isEntering = false;
      // Keep _enteringShop to show the completion dialog
    });
    _showVisitCompletionDialog();
  }

  Future<void> _showVisitCompletionDialog() async {
    if (_enteringShop == null) return;
    
    int rating = 5;
    final commentController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Visit Complete: ${_enteringShop!.name}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'How was your experience?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () => setDialogState(() => rating = index + 1),
                )),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: 'Comment (optional)',
                  hintText: 'Share your thoughts...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _enteringShop = null;
                });
                Navigator.pop(context);
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final shopId = _enteringShop!.id;
                final r = rating;
                final comment = commentController.text;
                
                Navigator.pop(context); // Close dialog
                _submitVisit(shopId, r, comment);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitVisit(String shopId, int rating, String comment) async {
    try {
      final response = await ApiService().createVisit(shopId, rating, comment);
      if (response.success) {
        final oldLevel = _currentLevel;
        setState(() {
          _clearedAreaGeojson = response.clearedAreaGeojson;
          _currentLevel = response.currentLevel;
          _currentExp = response.currentExp;
          _loadShops();
          _enteringShop = null;
        });

        // Show reward feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text('Visit recorded! Gained ${response.expGained} EXP'),
                   if (_currentLevel > oldLevel)
                     Text('LEVEL UP! Now at Level $_currentLevel', 
                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.yellow)),
                ],
              ),
              backgroundColor: AppTheme.primaryColor,
              duration: const Duration(seconds: 4),
            ),
          );
        }

        // Trigger blast animation at shop location
        _showBlastAnimation(shopId);

        // Flush pending locations so the server has the path up to the visit
        _sendBatchedLocationUpdate();
      }
    } catch (e) {
      debugPrint('Error submitting visit: $e');
    }
  }

  void _showBlastAnimation(String shopId) {
    debugPrint('BOOM! Fog cleared around $shopId');
    
    // Find shop location
    Shop? shop;
    try {
      shop = _nearbyShops.firstWhere((s) => s.id == shopId);
    } catch (_) {
      try {
        shop = _visitedShops.firstWhere((s) => s.id == shopId);
      } catch (_) {}
    }

    if (shop != null) {
      setState(() {
        _blastCenterLocation = latlong2.LatLng(shop!.lat, shop!.lng);
      });
      _blastController.reset();
      _blastController.forward();
    }
  }

  @override
  void dispose() {
    LocationService().stopTracking();
    _shopUpdateTimer?.cancel();
    _locationBatchTimer?.cancel();
    _countdownTimer?.cancel();
    _blastController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _moveVirtualLocation('up');
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _moveVirtualLocation('down');
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _moveVirtualLocation('left');
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _moveVirtualLocation('right');
          }
        }
      },
      child: Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? const latlong2.LatLng(35.6812, 139.7671),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.viuts.fof',
              ),
              FogLayer(
                fogColor: AppTheme.fogColorDark,
                currentLocation: _currentLocation,
                visionRadius: 100,
                clearedRings: FogLayer.parseGeoJson(_clearedAreaGeojson),
              ),
                MarkerLayer(
                  markers: [
                    if (_currentLocation != null)
                      Marker(
                        point: _currentLocation!,
                        width: 50,
                        height: 50,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Quest Direction Arrow
                            if (widget.questShop != null)
                              Builder(
                                builder: (context) {
                                  final bearing = Geolocator.bearingBetween(
                                    _currentLocation!.latitude,
                                    _currentLocation!.longitude,
                                    widget.questShop!.lat,
                                    widget.questShop!.lng,
                                  );
                                  return Transform.rotate(
                                    angle: bearing * (math.pi / 180),
                                    child: CustomPaint(
                                      painter: QuestDirectionPainter(),
                                      size: const Size(80, 80),
                                    ),
                                  );
                                }
                              ),
                            // User Heading Avatar
                            Transform.rotate(
                              angle: _currentHeading != null 
                                  ? (_currentHeading! * 3.141592653589793 / 180.0) // Convert degrees to radians
                                  : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.accentColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.accentColor.withValues(alpha: 0.4),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.navigation, // Directional arrow icon
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ...(() {
                      final allShops = <String, Shop>{};
                      for (var s in _nearbyShops) {
                        allShops[s.id] = s;
                      }
                      for (var s in _visitedShops) {
                        allShops[s.id] = s;
                      }
                      
                      return allShops.values;
                    }()).map((shop) {
                      final shopLocation = latlong2.LatLng(shop.lat, shop.lng);
                      final isInClearedArea = GeoUtils.isPointInClearedArea(shopLocation, _clearedAreaGeojson);
                      
                      return Marker(
                        point: shopLocation,
                        width: shop.markerSize + 10,
                        height: shop.markerSize + 10,
                        child: ShopBeacon(
                          shop: shop,
                          showPulse: false,
                          isInClearedArea: isInClearedArea,
                          onTap: () => _showShopDetails(shop),
                        ),
                      );
                     }),
                    // Quest marker (if active)
                    if (widget.questShop != null)
                      Marker(
                        point: latlong2.LatLng(widget.questShop!.lat, widget.questShop!.lng),
                        width: 60,
                        height: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withValues(alpha: 0.5),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.flag,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                  ],
                ),
            ],

          ),
          // Entering Overlay
          _buildEnteringOverlay(),
          // Quest overlay
          if (widget.questShop != null && _currentLocation != null)
            _buildQuestOverlay(),
          // Blast animation layer
          _buildBlastLayer(radiusInMeters: 250.0),
          // Location button
          Positioned(
            right: 16,
            bottom: 100, // Positioned above the bottom nav bar
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              elevation: 4,
              onPressed: () {
                if (_currentLocation != null) {
                  _mapController.move(_currentLocation!, 15.0);
                }
              },
              child: const Icon(
                Icons.my_location,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            ),
          ),
          // Virtual D-pad for development
          if (kDebugMode)
            _buildVirtualDPad(),
          
          // Level Badge
          _buildLevelBadge(),
        ],
      ),
      ),
    );
  }

  Widget _buildLevelBadge() {
    final nextLevelThreshold = _currentLevel * _currentLevel * 100;
    final expNeeded = nextLevelThreshold - _currentExp;

    // Shift down if entering overlay is visible to avoid overlap
    // Also shift down if Quest Mode is active (top overlay present)
    final topPadding = MediaQuery.of(context).padding.top + 
        (_isEntering ? 180 : (widget.questShop != null ? 170 : 16));

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: topPadding,
      left: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.lightSurface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LV. $_currentLevel',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.textPrimaryLight,
                  ),
                ),
                Text(
                  'Next: $expNeeded EXP',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondaryLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlastLayer({double radiusInMeters = 250.0}) {
    if (_blastCenterLocation == null) return const SizedBox.shrink();

    return IgnorePointer(
      child: CustomPaint(
        painter: BlastPainter(
          center: _blastCenterLocation!,
          progress: _blastController.value,
          camera: _mapController.camera,
          radiusInMeters: radiusInMeters,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class BlastPainter extends CustomPainter {
  final latlong2.LatLng center;
  final double progress;
  final MapCamera camera;
  final double radiusInMeters;

  BlastPainter({
    required this.center,
    required this.progress,
    required this.camera,
    this.radiusInMeters = 100.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1.0) return;
    final offset = camera.getOffsetFromOrigin(center);
    
    // Meters to pixels conversion
    final latRad = center.latitude * math.pi / 180.0;
    final metersPerPixel = 156543.03392 * math.cos(latRad) / math.pow(2, camera.zoom);
    final maxRadius = radiusInMeters / metersPerPixel;

    // Use a custom curve for the expansion feel
    final mainCurve = Curves.easeOutExpo.transform(progress);
    
    // 0. Inner Fill (Fades out quickly)
    final fillPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: (1.0 - mainCurve) * 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(offset.dx, offset.dy), maxRadius * mainCurve, fillPaint);

    // 1. Primary Shockwave (Primary Color)
    final paint1 = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: (1.0 - mainCurve) * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0 * (1.0 - mainCurve);
    canvas.drawCircle(Offset(offset.dx, offset.dy), maxRadius * mainCurve, paint1);

    // 2. Secondary Shockwave (Accent Color, delayed)
    if (progress > 0.15) {
      final p2 = (progress - 0.15) / 0.85;
      final c2 = Curves.easeOutCubic.transform(p2);
      final paint2 = Paint()
        ..color = AppTheme.accentColor.withValues(alpha: (1.0 - c2) * 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12.0 * (1.0 - c2);
      canvas.drawCircle(Offset(offset.dx, offset.dy), maxRadius * 0.8 * c2, paint2);
    }
    
    // 3. Third Shockwave (White core, faster)
    if (progress < 0.6) {
      final p3 = progress / 0.6;
      final c3 = Curves.easeOutQuart.transform(p3);
      final paint3 = Paint()
        ..color = Colors.white.withValues(alpha: (1.0 - c3) * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0 * (1.0 - c3);
       canvas.drawCircle(Offset(offset.dx, offset.dy), maxRadius * 0.5 * c3, paint3);
    }

    // 4. Central Flash
    final flashCurve = Curves.easeIn.transform(1.0 - progress);
    if (flashCurve > 0.0) {
      final flashPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: flashCurve * 0.95),
            AppTheme.primaryColor.withValues(alpha: flashCurve * 0.4),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(offset.dx, offset.dy), radius: maxRadius * 0.6));
      
      canvas.drawCircle(Offset(offset.dx, offset.dy), maxRadius * 0.6 * progress, flashPaint);
    }

    // 5. Particles (Expanded)
    final pPaint = Paint();
    final random = math.Random(center.hashCode); // Consistent random based on location
    
    // More particles
    for (int i = 0; i < 24; i++) {
        final angle = (i * math.pi / 12) + (progress * 0.5); // Slight rotation
        final randomOffset = random.nextDouble() * 0.2; // Variance
        
        final particleProgress = Curves.easeOutCirc.transform(progress); 
        final pDist = maxRadius * particleProgress * (0.8 + randomOffset);
        
        final px = offset.dx + math.cos(angle) * pDist;
        final py = offset.dy + math.sin(angle) * pDist;
        
        // Randomly alternate between primary, accent and white
        Color particleColor;
        if (i % 3 == 0) {
          particleColor = AppTheme.primaryColor;
        } else if (i % 3 == 1) {
          particleColor = AppTheme.accentColor;
        } else {
          particleColor = Colors.amber;
        }
        
        pPaint.color = particleColor.withValues(alpha: (1.0 - particleProgress) * 0.9);
        
        final sizeBase = (i % 2 == 0) ? 6.0 : 3.0;
        canvas.drawCircle(Offset(px, py), sizeBase * (1.0 - particleProgress), pPaint);
    }
  }

  @override
  bool shouldRepaint(covariant BlastPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.center != center;
  }
}

class QuestDirectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    // Marker is approx 50x50 (radius 25).
    // We draw arc at radius ~38 to hover just outside.
    final rect = Rect.fromCircle(center: center, radius: 36);
    
    // Draw Arc centered at Top (-pi/2)
    // Sweep angle approx 72 degrees (2*pi/5)
    canvas.drawArc(rect, -math.pi / 2 - math.pi / 5, math.pi * 2 / 5, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

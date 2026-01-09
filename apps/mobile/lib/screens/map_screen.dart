import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:geolocator/geolocator.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';
import '../services/language_service.dart';
import 'visit_detail_screen.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/common.pb.dart';
import '../api/fof/v1/location.pb.dart';
import '../api/fof/v1/achievement.pb.dart';
import '../api/fof/v1/shop_extensions.dart';
import '../widgets/fog_layer.dart';
import '../widgets/shop_beacon.dart';
import '../widgets/shop_detail_card.dart';
import '../constants/category_colors.dart';
import '../theme/app_theme.dart';
import '../utils/geo_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:provider/provider.dart';
import '../services/map_style_service.dart';
import '../services/user_service.dart';

class MapScreen extends StatefulWidget {
  final Shop? questShop;
  final VoidCallback? onCancelQuest;

  const MapScreen({super.key, this.questShop, this.onCancelQuest});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  final FocusNode _focusNode = FocusNode();
  String? _clearedAreaGeojson;
  final List<Shop> _nearbyShops = [];
  List<List<latlong2.LatLng>> _clearedRings = []; // Cached parsed GeoJSON
  latlong2.LatLng? _currentLocation;
  Shop? _selectedShop; // Selected shop for non-blocking detail view

  Timer? _shopUpdateTimer;
  Timer? _locationBatchTimer;
  bool _isMapReady = false;
  bool _hasCentered = false;
  bool _hasFetchedNearbyShops = false;
  int _virtualStepCount = 0;

  // Shop Entry Feature
  bool _isEntering = false;
  bool _isSubmittingVisit = false;
  Shop? _enteringShop;
  Timer? _countdownTimer;
  int _remainingSeconds = 0;
  bool _isInitialLoading = true;

  // Blast Animation
  late AnimationController _blastController;
  latlong2.LatLng? _blastCenterLocation;
  double? _blastRadius;

  // Filter State
  Set<FoodCategory>? _hiddenCategoriesBacking;
  Set<FoodCategory> get _hiddenCategories => _hiddenCategoriesBacking ??= {};

  @override
  void initState() {
    super.initState();
    _loadFilters();
    _startLocationService();
    _loadInitialData();
    _shopUpdateTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _fetchNearbyShops(),
    );
    _locationBatchTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _sendBatchedLocationUpdate(),
    );

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
          if (!mounted) return;
          setState(() {
            _currentLocation = newLoc;
          });

          if (!_hasCentered && _isMapReady) {
            _hasCentered = true;
            _mapController.move(newLoc, 15.0);
          }

          if (!_hasFetchedNearbyShops) {
            _hasFetchedNearbyShops = true;
            _fetchNearbyShops();
          }
        },
      );
      // location service started
    } catch (e) {
      debugPrint('Error starting location service: $e');
    }
  }

  void recenter() {
    if (_currentLocation != null && _isMapReady) {
      _mapController.move(_currentLocation!, 15.0);
    }
  }

  Future<void> _loadFilters() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hidden = prefs.getStringList('hidden_categories');
      if (hidden != null && mounted) {
        setState(() {
          _hiddenCategoriesBacking = hidden
              .map(
                (name) => FoodCategory.values.firstWhere(
                  (e) => e.name == name,
                  orElse: () => FoodCategory.FOOD_CATEGORY_UNSPECIFIED,
                ),
              )
              .where((e) => e != FoodCategory.FOOD_CATEGORY_UNSPECIFIED)
              .toSet();
        });
      }
    } catch (e) {
      debugPrint('Error loading filters: $e');
    }
  }

  Future<void> _saveFilters() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = _hiddenCategories.map((e) => e.name).toList();
      await prefs.setStringList('hidden_categories', list);
    } catch (e) {
      debugPrint('Error saving filters: $e');
    }
  }

  Future<void> _loadInitialData() async {
    try {
      final userService = Provider.of<UserService>(context, listen: false);
      final futures = <Future>[
        ApiService().getClearedArea(),
        userService.loadInitialData(),
      ];

      final results = await Future.wait(futures);

      if (!mounted) return;

      final clearedAreaResponse = results[0] as GetClearedAreaResponse;

      setState(() {
        _clearedAreaGeojson = clearedAreaResponse.clearedAreaGeojson;
        _clearedRings = GeoUtils.parseGeoJson(_clearedAreaGeojson);
      });

      // If we didn't fetch nearby shops yet (no location), let the location service callback handle it or the timer
    } catch (e) {
      debugPrint('Failed to load initial data: $e');
      // Fallback: try loading singly if batch failed, though unlikely
      await _fetchShops();
    } finally {
      if (mounted) {
        setState(() {
          _isInitialLoading = false;
        });
      }
    }
  }

  Future<void> _sendBatchedLocationUpdate() async {
    final pathPositions = await LocationService().getPath();
    if (pathPositions.isEmpty) return;

    try {
      final path = pathPositions
          .map((p) => LatLng(lat: p.latitude, lng: p.longitude))
          .toList();
      final response = await ApiService().updateLocation(path);

      await LocationService().clearPath();

      if (response.newlyCleared && mounted) {
        setState(() {
          _clearedAreaGeojson = response.clearedAreaGeojson;
          _clearedRings = GeoUtils.parseGeoJson(_clearedAreaGeojson);
        });
      }
    } catch (e) {
      debugPrint('Failed to update location (will retry): $e');
    }
  }

  // Renamed from _loadShops to be more generic if needed, or just use specific methods
  Future<void> _fetchShops() async {
    await _fetchNearbyShops();
    if (!mounted) return;
    await Provider.of<UserService>(
      context,
      listen: false,
    ).loadInitialData(force: true);
  }

  Future<GetNearbyShopsResponse?> _fetchNearbyShops({
    bool updateState = true,
  }) async {
    if (_currentLocation == null) return null;
    try {
      final response = await ApiService().getNearbyShops(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        1000.0, // 1km radius
      );

      if (updateState && mounted) {
        setState(() {
          _nearbyShops.clear();
          _nearbyShops.addAll(response.shops);
        });
      }
      return response;
    } catch (e) {
      debugPrint('Failed to load nearby shops: $e');
      return null;
    }
  }

  // Removed _fetchVisitedShops - now in UserService

  // Removed _fetchUserProfile - now in UserService

  void _showShopDetails(Shop shop) {
    setState(() {
      _selectedShop = shop;
    });
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
                          S
                              .of(context)
                              .translateCategory(
                                widget.questShop!.effectiveFoodCategory,
                              ),
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
                            color: isArrived
                                ? AppTheme.textPrimaryLight
                                : AppTheme.textSecondaryLight,
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
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
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
                    const Icon(
                      Icons.navigation,
                      color: Colors.orange,
                      size: 20,
                    ),
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
    const double metersPerDegree =
        111320.0; // Approximate meters per degree of latitude

    double latOffset = 0;
    double lngOffset = 0;
    switch (direction) {
      case 'up':
        latOffset = metersToMove / metersPerDegree;
        break;
      case 'down':
        latOffset = -metersToMove / metersPerDegree;
        break;
      case 'left':
        lngOffset =
            -metersToMove / (metersPerDegree * 0.9); // Adjust for longitude
        break;
      case 'right':
        lngOffset = metersToMove / (metersPerDegree * 0.9);
        break;
    }

    final newLat = _currentLocation!.latitude + latOffset;
    final newLng = _currentLocation!.longitude + lngOffset;

    // Update via service so all listeners (including map & proximity) are notified
    LocationService().updateVirtualLocation(newLat, newLng);

    // Trigger aggressive location update for DEV mode
    _virtualStepCount++;
    if (_virtualStepCount >= 5) {
      _virtualStepCount = 0;
      _sendBatchedLocationUpdate();
    }

    // Recenter map
    if (_isMapReady) {
      _mapController.move(
        latlong2.LatLng(newLat, newLng),
        _mapController.camera.zoom,
      );
    }
  }

  Widget _buildVirtualDPad() {
    return Positioned(
      left: 16,
      bottom: 32,
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
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
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
  }

  void _onVisitCountdownFinished() {
    if (_enteringShop == null) return;

    _submitVisit(_enteringShop!.id, 5, '');
  }

  Future<void> _submitVisit(String shopId, int rating, String comment) async {
    setState(() {
      _isSubmittingVisit = true;
      _isEntering = false;
    });

    try {
      final response = await ApiService().createVisit(shopId, rating, comment);
      if (response.success) {
        final userService = Provider.of<UserService>(context, listen: false);
        final oldLevel = userService.currentLevel;

        setState(() {
          _clearedAreaGeojson = response.clearedAreaGeojson;
          _clearedRings = GeoUtils.parseGeoJson(_clearedAreaGeojson);
          _fetchNearbyShops();
          _enteringShop = null;

          // Refresh selected shop status
          if (_selectedShop != null && _selectedShop!.id == shopId) {
            _selectedShop!.isVisited = true;
          }
        });

        if (mounted) {
          userService.updateVisitData(
            level: response.currentLevel,
            exp: response.currentExp,
          );

          // Show reward feedback
          final s = S.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).visitRecordedExp(response.expGained)),
                  if (response.currentLevel > oldLevel)
                    Text(
                      s.levelUp(response.currentLevel),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.yellow,
                      ),
                    ),
                  ...response.unlockedAchievements.map((ach) {
                    String prefix = '';
                    if (ach.hasTier() &&
                        ach.tier !=
                            AchievementTier.ACHIEVEMENT_TIER_UNSPECIFIED) {
                      prefix = '[${ach.tier.name.split('_').last}] ';
                    }
                    return Text(
                      s.unlockedAchievement('$prefix${ach.name}'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ],
              ),
              backgroundColor: AppTheme.primaryColor,
              duration: const Duration(seconds: 4),
            ),
          );

          // Trigger blast animation at shop location
          _showBlastAnimation(shopId);

          // Flush pending locations so the server has the path up to the visit
          _sendBatchedLocationUpdate();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).errorLabel(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint('Error submitting visit: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmittingVisit = false;
        });
      }
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
        final userService = Provider.of<UserService>(context, listen: false);
        shop = userService.visitedShopModels.firstWhere((s) => s.id == shopId);
      } catch (_) {}
    }

    if (shop != null) {
      final validShop = shop;
      setState(() {
        _blastCenterLocation = latlong2.LatLng(validShop.lat, validShop.lng);
        _blastRadius = validShop.clearanceRadius > 0
            ? validShop.clearanceRadius
            : 100.0;
      });
      _blastController.reset();
      _blastController.forward();
    }
  }

  Widget _buildInitialLoadingOverlay() {
    final s = S.of(context);
    return Container(
      color: AppTheme.fogColorDark,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            const Icon(
              Icons.restaurant_menu,
              size: 80,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            ),
            const SizedBox(height: 24),
            Text(
              s.loadingMap,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
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
    final mapStyleService = Provider.of<MapStyleService>(context);

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
                initialCenter:
                    _currentLocation ??
                    const latlong2.LatLng(35.6812, 139.7671),
                initialZoom: 15,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                ),
                onMapReady: () {
                  setState(() {
                    _isMapReady = true;
                  });
                  // If we already have a location but haven't centered yet, do it now
                  if (_currentLocation != null && !_hasCentered) {
                    _hasCentered = true;
                    _mapController.move(_currentLocation!, 15.0);
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: mapStyleService.currentStyle.urlTemplate,
                  subdomains: mapStyleService.currentStyle.subdomains,
                  userAgentPackageName: 'com.viuts.fof',
                  tileProvider: NetworkTileProvider(
                    cachingProvider:
                        BuiltInMapCachingProvider.getOrCreateInstance(
                          maxCacheSize: 1_000_000_000, // 1 GB
                        ),
                  ),
                ),
                FogLayer(
                  fogColor: AppTheme.fogColorDark,
                  currentLocation: _currentLocation,
                  visionRadius: 100,
                  clearedRings: _clearedRings,
                ),
                CurrentLocationLayer(
                  positionStream: LocationService().positionStream.map(
                    (p) => LocationMarkerPosition(
                      latitude: p.latitude,
                      longitude: p.longitude,
                      accuracy: p.accuracy,
                    ),
                  ),
                  style: LocationMarkerStyle(
                    marker: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    markerSize: const Size(24, 24),
                    markerDirection: kIsWeb
                        ? MarkerDirection.top
                        : MarkerDirection.heading,
                    showAccuracyCircle: false,
                    accuracyCircleColor: AppTheme.accentColor.withValues(
                      alpha: 0.3,
                    ),
                    headingSectorColor: AppTheme.accentColor.withValues(
                      alpha: 0.4,
                    ),
                    headingSectorRadius: 60,
                    showHeadingSector: !kIsWeb,
                  ),
                ),
                MarkerLayer(
                  markers: [
                    // Quest Direction Arrow (Standalone)
                    if (_currentLocation != null && widget.questShop != null)
                      Marker(
                        point: _currentLocation!,
                        width: 100,
                        height: 100,
                        child: Builder(
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
                                size: const Size(100, 100),
                              ),
                            );
                          },
                        ),
                      ),
                    ...(() {
                      final allShops = <String, Shop>{};
                      for (var s in _nearbyShops) {
                        allShops[s.id] = s;
                      }
                      final userService = Provider.of<UserService>(
                        context,
                        listen: false,
                      );
                      for (var s in userService.visitedShopModels) {
                        allShops[s.id] = s;
                      }

                      return allShops.values.where(
                        (s) => !_hiddenCategories.contains(
                          s.effectiveFoodCategory,
                        ),
                      );
                    }()).map((shop) {
                      final shopLocation = latlong2.LatLng(shop.lat, shop.lng);
                      final isInClearedArea = GeoUtils.isPointInClearedArea(
                        shopLocation,
                        _clearedRings,
                      );

                      return Marker(
                        point: shopLocation,
                        width: shop.markerSize + 10,
                        height: shop.markerSize + 10,
                        key: ValueKey('shop_${shop.id}'),
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
                        point: latlong2.LatLng(
                          widget.questShop!.lat,
                          widget.questShop!.lng,
                        ),
                        width: 24,
                        height: 24,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
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
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            // Quest overlay
            if (widget.questShop != null && _currentLocation != null)
              _buildQuestOverlay(),
            // Blast animation layer
            _buildBlastLayer(radiusInMeters: 250.0),
            // Virtual D-pad for development (Web only)
            if (kDebugMode) _buildVirtualDPad(),

            // Level Badge
            _buildLevelBadge(),

            // Filter Bar
            _buildFilterBar(),

            // Persistent Shop Detail Card
            if (_selectedShop != null)
              ShopDetailCard(
                shop: _selectedShop!,
                currentLocation: _currentLocation,
                clearedRings: _clearedRings,
                onClose: () => setState(() => _selectedShop = null),
                onEnterShop: _startEnteringShop,
                isEntering:
                    _isEntering && _enteringShop?.id == _selectedShop?.id,
                isSubmitting:
                    _isSubmittingVisit &&
                    _enteringShop?.id == _selectedShop?.id,
                remainingSeconds: _remainingSeconds,
                onCancelEntering: () {
                  setState(() {
                    _isEntering = false;
                    _enteringShop = null;
                    _remainingSeconds = 0;
                  });
                  _countdownTimer?.cancel();
                },
                onViewVisit: () {
                  final userService = Provider.of<UserService>(
                    context,
                    listen: false,
                  );
                  try {
                    final visit = userService.visitedShops.firstWhere(
                      (v) => v.shop.id == _selectedShop!.id,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisitDetailScreen(visit: visit),
                      ),
                    );
                  } catch (e) {
                    debugPrint('Error finding visit for shop: $e');
                  }
                },
              ),

            // Initial Loading Overlay
            if (_isInitialLoading) _buildInitialLoadingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelBadge() {
    final s = S.of(context);
    final userService = Provider.of<UserService>(context);
    final currentLevel = userService.currentLevel;
    final currentExp = userService.currentExp;
    final nextLevelThreshold = currentLevel * currentLevel * 100;
    final expNeeded = nextLevelThreshold - currentExp;

    // Shift down if entering overlay is visible to avoid overlap
    // Quest Mode is active (top overlay present)
    final topPadding =
        MediaQuery.of(context).padding.top +
        (widget.questShop != null ? 170 : 16);

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
                  s.levelLabel(currentLevel),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.textPrimaryLight,
                  ),
                ),
                Text(
                  s.nextExp(expNeeded),
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
    if (_blastCenterLocation == null || !_isMapReady)
      return const SizedBox.shrink();

    return IgnorePointer(
      child: CustomPaint(
        painter: BlastPainter(
          center: _blastCenterLocation!,
          progress: _blastController.value,
          camera: _mapController.camera,
          radiusInMeters: _blastRadius ?? radiusInMeters,
        ),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildFilterBar() {
    // Use the same logic as LevelBadge to avoid overlap
    final topPadding =
        MediaQuery.of(context).padding.top +
        (widget.questShop != null ? 170 : 16);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: topPadding,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filter Button
          FloatingActionButton.small(
            heroTag: 'filter_toggle',
            backgroundColor: Colors.white,
            elevation: 4,
            onPressed: _showFilterSheet,
            child: Icon(
              Icons.filter_list,
              color: _hiddenCategories.isNotEmpty
                  ? AppTheme.primaryColor
                  : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    final s = S.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final grouped = ShopCategory.getGroupedCategories(s);
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            s.selectCuisine,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() => _hiddenCategories.clear());
                                  setModalState(() {});
                                  _saveFilters();
                                },
                                child: Text(
                                  s.selectAll,
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _hiddenCategories.clear();
                                    _hiddenCategories.addAll(
                                      ShopCategory.allCategories,
                                    );
                                  });
                                  setModalState(() {});
                                  _saveFilters();
                                },
                                child: Text(
                                  s.deselectAll,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 32),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: grouped.length,
                        itemBuilder: (context, index) {
                          final group = grouped[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 12,
                                ),
                                child: Text(
                                  group.label,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: group.categories.map((cat) {
                                  final isHidden = _hiddenCategories.contains(
                                    cat,
                                  );
                                  final color = ShopCategory.getColor(cat);
                                  final icon = ShopCategory.getIcon(cat);
                                  return FilterChip(
                                    label: Text(
                                      s.translateCategory(cat),
                                      style: TextStyle(
                                        color: isHidden
                                            ? Colors.grey[600]
                                            : Colors.black87,
                                        fontSize: 13,
                                        fontWeight: isHidden
                                            ? FontWeight.normal
                                            : FontWeight.w600,
                                      ),
                                    ),
                                    avatar: Icon(
                                      icon,
                                      size: 16,
                                      color: isHidden ? Colors.grey : color,
                                    ),
                                    selected: !isHidden,
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          _hiddenCategories.remove(cat);
                                        } else {
                                          _hiddenCategories.add(cat);
                                        }
                                        _saveFilters();
                                      });
                                      setModalState(() {});
                                    },
                                    backgroundColor: Colors.white,
                                    selectedColor: color.withValues(
                                      alpha: 0.15,
                                    ),
                                    checkmarkColor: color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: isHidden
                                            ? Colors.grey[300]!
                                            : color,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
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
    final metersPerPixel =
        156543.03392 * math.cos(latRad) / math.pow(2, camera.zoom);
    final maxRadius = radiusInMeters / metersPerPixel;

    // Use a custom curve for the expansion feel
    final mainCurve = Curves.easeOutExpo.transform(progress);

    // 0. Inner Fill (Fades out quickly)
    final fillPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: (1.0 - mainCurve) * 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(offset.dx, offset.dy),
      maxRadius * mainCurve,
      fillPaint,
    );

    // 1. Primary Shockwave (Primary Color)
    final paint1 = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: (1.0 - mainCurve) * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0 * (1.0 - mainCurve);
    canvas.drawCircle(
      Offset(offset.dx, offset.dy),
      maxRadius * mainCurve,
      paint1,
    );

    // 2. Secondary Shockwave (Accent Color, delayed)
    if (progress > 0.15) {
      final p2 = (progress - 0.15) / 0.85;
      final c2 = Curves.easeOutCubic.transform(p2);
      final paint2 = Paint()
        ..color = AppTheme.accentColor.withValues(alpha: (1.0 - c2) * 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12.0 * (1.0 - c2);
      canvas.drawCircle(
        Offset(offset.dx, offset.dy),
        maxRadius * 0.8 * c2,
        paint2,
      );
    }

    // 3. Third Shockwave (White core, faster)
    if (progress < 0.6) {
      final p3 = progress / 0.6;
      final c3 = Curves.easeOutQuart.transform(p3);
      final paint3 = Paint()
        ..color = Colors.white.withValues(alpha: (1.0 - c3) * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0 * (1.0 - c3);
      canvas.drawCircle(
        Offset(offset.dx, offset.dy),
        maxRadius * 0.5 * c3,
        paint3,
      );
    }

    // 4. Central Flash
    final flashCurve = Curves.easeIn.transform(1.0 - progress);
    if (flashCurve > 0.0) {
      final flashPaint = Paint()
        ..shader =
            RadialGradient(
              colors: [
                Colors.white.withValues(alpha: flashCurve * 0.95),
                AppTheme.primaryColor.withValues(alpha: flashCurve * 0.4),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 1.0],
            ).createShader(
              Rect.fromCircle(
                center: Offset(offset.dx, offset.dy),
                radius: maxRadius * 0.6,
              ),
            );

      canvas.drawCircle(
        Offset(offset.dx, offset.dy),
        maxRadius * 0.6 * progress,
        flashPaint,
      );
    }

    // 5. Particles (Expanded)
    final pPaint = Paint();
    final random = math.Random(
      center.hashCode,
    ); // Consistent random based on location

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

      pPaint.color = particleColor.withValues(
        alpha: (1.0 - particleProgress) * 0.9,
      );

      final sizeBase = (i % 2 == 0) ? 6.0 : 3.0;
      canvas.drawCircle(
        Offset(px, py),
        sizeBase * (1.0 - particleProgress),
        pPaint,
      );
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
    canvas.drawArc(
      rect,
      -math.pi / 2 - math.pi / 5,
      math.pi * 2 / 5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

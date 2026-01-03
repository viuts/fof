import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'api/fof/v1/fof.pb.dart' as fof_pb;
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'services/api_service.dart';
import 'services/location_service.dart';
import 'models/shop.dart';
import 'theme/app_theme.dart';
import 'widgets/shop_beacon.dart';
import 'services/audio_service.dart';
import 'screens/main_container.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/language_service.dart';
import 'widgets/fog_layer.dart';
import 'utils/geo_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService().init(host: 'localhost', port: 8080); // Use 10.0.2.2 for Android emulator
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageService(),
      child: const FogOfFlavorApp(),
    ),
  );
}

class FogOfFlavorApp extends StatelessWidget {
  const FogOfFlavorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    
    return MaterialApp(
      title: 'Fog of Flavor',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      locale: languageService.currentLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const MainContainer(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  String? _clearedAreaGeojson;
  final List<Shop> _nearbyShops = [];
  final List<Shop> _visitedShops = [];
  latlong2.LatLng? _currentLocation;
  Timer? _shopUpdateTimer;
  Timer? _locationBatchTimer;

  @override
  void initState() {
    super.initState();
    _startLocationService();
    _shopUpdateTimer = Timer.periodic(const Duration(seconds: 30), (_) => _loadShops());
    _locationBatchTimer = Timer.periodic(const Duration(seconds: 10), (_) => _sendBatchedLocationUpdate());
  }

  Future<void> _startLocationService() async {
    try {
      await LocationService().startTracking(
        onLocationUpdate: (lat, lng) {
          setState(() {
            _currentLocation = latlong2.LatLng(lat, lng);
          });
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
      // debugPrint('Loaded ${nearby.shops.length} nearby shops');
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
            if (!isInClearedArea) ...[
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
                          shop.category.toUpperCase(),
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
                        'この地域を探索してください\nショップの詳細を確認するには、フォグをクリアする必要があります。',
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
                  child: const Text('閉じる'),
                ),
              ),
            ],
            
            // Shop is in cleared area - show full details
            if (isInClearedArea) ...[
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
                          shop.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimaryLight,
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
                              shop.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                color: shop.color,
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
              _buildDetailRow(Icons.location_on_outlined, '場所', '${shop.lat.toStringAsFixed(4)}, ${shop.lng.toStringAsFixed(4)}'),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.radar_outlined, '探索半径', '${shop.clearanceRadius.toInt()}m'),
              if (shop.isVisited) ...[ 
                const SizedBox(height: 16),
                _buildDetailRow(Icons.check_circle_outline, 'ステータス', '訪問済み', color: Colors.green.shade600),
              ],
              const SizedBox(height: 40),
              if (!shop.isVisited) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final response = await ApiService().createVisit(shop.id);
                        if (response.success) {
                          setState(() {
                            _clearedAreaGeojson = response.clearedAreaGeojson;
                            _loadShops();
                          });
                          if (mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('訪問を記録しました！フォグが晴れました。')),
                            );
                          }
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('訪問の記録に失敗しました: $e')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text('このショップに訪問する'),
                  ),
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
                    child: const Text('閉じる'),
                  ),
                ),
            ],
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

  void clearHistory() {
    setState(() {
      _clearedAreaGeojson = null;
      _visitedShops.clear();
    });
  }

  @override
  void dispose() {
    LocationService().stopTracking();
    _shopUpdateTimer?.cancel();
    _locationBatchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                visionRadius: 180,
                clearedRings: FogLayer.parseGeoJson(_clearedAreaGeojson),
              ),
                MarkerLayer(
                  markers: [
                    if (_currentLocation != null)
                      Marker(
                        point: _currentLocation!,
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
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
                            Icons.my_location,
                            color: Colors.white,
                            size: 20,
                          ),
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
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

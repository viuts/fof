import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for location tracking with battery optimization and persistent local caching
class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  StreamSubscription<Position>? _positionSubscription;
  bool _isFrozen = false;
  Position? _currentPosition;
  final List<Position> _currentPath = [];
  static const String _pathCacheKey = 'location_path_cache';

  /// Load cached path from storage
  Future<void> loadCachedPath() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cachedPathJson = prefs.getString(_pathCacheKey);
      if (cachedPathJson != null) {
        final List<dynamic> decoded = jsonDecode(cachedPathJson);
        _currentPath.clear();
        _currentPath.addAll(decoded.map((p) => Position(
          latitude: p['lat'],
          longitude: p['lng'],
          timestamp: DateTime.fromMillisecondsSinceEpoch(p['t']),
          accuracy: p['a'] ?? 0.0,
          altitude: p['alt'] ?? 0.0,
          heading: p['h'] ?? 0.0,
          speed: p['s'] ?? 0.0,
          speedAccuracy: p['sa'] ?? 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        )));
      }
    } catch (e) {
      debugPrint('Error loading cached path: $e');
    }
  }

  /// Save current path to storage
  Future<void> _savePath() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded = jsonEncode(_currentPath.map((p) => {
        'lat': p.latitude,
        'lng': p.longitude,
        't': p.timestamp.millisecondsSinceEpoch,
        'a': p.accuracy,
        'alt': p.altitude,
        'h': p.heading,
        's': p.speed,
        'sa': p.speedAccuracy,
      }).toList());
      await prefs.setString(_pathCacheKey, encoded);
    } catch (e) {
      debugPrint('Error saving path: $e');
    }
  }

  /// Set tracking freeze state
  void setFreeze(bool frozen) {
    _isFrozen = frozen;
    if (frozen) {
      stopTracking();
    }
  }

  /// Check if tracking is frozen
  bool get isFrozen => _isFrozen;

  /// Get current path (without clearing)
  Future<List<Position>> getPath() async {
    return List<Position>.from(_currentPath);
  }

  /// Clear the path and persistent cache
  Future<void> clearPath() async {
    _currentPath.clear();
    await _savePath();
  }

  /// Get accumulated path and clear it (Atomically)
  Future<List<Position>> flushPath() async {
    final path = await getPath();
    await clearPath();
    return path;
  }

  /// Start location tracking with battery optimization
  Future<void> startTracking({
    required Function(double lat, double lng) onLocationUpdate,
  }) async {
    if (_isFrozen) return;
    
    await loadCachedPath(); // Ensure existing cache is loaded
    
    // Set initial position from cache if available
    if (_currentPath.isNotEmpty) {
      final lastPos = _currentPath.last;
      _currentPosition = lastPos;
      onLocationUpdate(lastPos.latitude, lastPos.longitude);
    }

    // Check permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled');
      // On web, this might always return false, so we continue anyway
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Define platform-specific settings
    late LocationSettings locationSettings;

    if (kIsWeb) {
      // Web-specific settings
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100, // relaxed filter for web
      );
    } else if (Platform.isAndroid) {
      // Android-specific settings
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS/macOS-specific settings
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      // Fallback for other platforms
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    }

    // Start position stream
    try {
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (Position position) {
          _currentPosition = position;
          _currentPath.add(position);
          _savePath(); // Persist immediately
          onLocationUpdate(position.latitude, position.longitude);
        },
        onError: (e) {
          debugPrint('Position stream error: $e');
        },
      );
    } catch (e) {
      debugPrint('Failed to start position stream: $e');
    }

    // Get initial position
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      _currentPosition = position;
      onLocationUpdate(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('Failed to get initial position (ignoring): $e');
    }
  }

  /// Get current position
  Position? get currentPosition => _currentPosition;
  
  /// Stop location tracking
  void stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  /// Dispose resources
  void dispose() {
    stopTracking();
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Service for location tracking with battery optimization and persistent local caching
class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  Timer? _saveTimer;
  Timer? _stationaryTimer;

  final _positionController = StreamController<Position>.broadcast();
  Stream<Position> get positionStream => _positionController.stream;

  // Battery Optimization State
  bool _isHighAccuracy = true;
  DateTime _lastMovedTime = DateTime.now();
  static const int _stationaryThresholdSeconds = 60;
  static const double _motionThreshold = 1.0; // Acceleration delta threshold

  // Compass Support
  Stream<double?> get headingStream =>
      FlutterCompass.events!.map((event) => event.heading);
  Position? _currentPosition;
  final List<Position> _currentPath = [];
  final List<Function(double lat, double lng)> _updateListeners = [];
  static const String _pathCacheKey = 'location_path_cache';

  /// Update location virtually (for debugging/D-pad)
  void updateVirtualLocation(double lat, double lng) {
    if (_positionSubscription != null) {
      _positionSubscription?.cancel();
      _positionSubscription = null;
    }
    final now = DateTime.now();
    final newPosition = Position(
      latitude: lat,
      longitude: lng,
      timestamp: now,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );

    _currentPosition = newPosition;
    _currentPath.add(newPosition);
    _scheduleSave();

    for (final listener in _updateListeners) {
      listener(lat, lng);
    }
    _positionController.add(newPosition);
  }

  /// Load cached path from storage
  Future<void> loadCachedPath() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cachedPathJson = prefs.getString(_pathCacheKey);
      if (cachedPathJson != null) {
        final List<dynamic> decoded = jsonDecode(cachedPathJson);
        _currentPath.clear();
        _currentPath.addAll(
          decoded.map(
            (p) => Position(
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
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error loading cached path: $e');
    }
  }

  /// Save current path to storage
  Future<void> _savePath() async {
    _saveTimer?.cancel();
    _saveTimer = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded = jsonEncode(
        _currentPath
            .map(
              (p) => {
                'lat': p.latitude,
                'lng': p.longitude,
                't': p.timestamp.millisecondsSinceEpoch,
                'a': p.accuracy,
                'alt': p.altitude,
                'h': p.heading,
                's': p.speed,
                'sa': p.speedAccuracy,
              },
            )
            .toList(),
      );
      await prefs.setString(_pathCacheKey, encoded);
    } catch (e) {
      debugPrint('Error saving path: $e');
    }
  }

  /// Schedule a save operation (Debounced to 30s)
  void _scheduleSave() {
    if (_saveTimer != null) return;
    _saveTimer = Timer(const Duration(seconds: 30), () {
      _savePath();
    });
  }

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
    // If already tracking, don't restart unless specifically needed,
    // but here we just add the listener.
    if (_positionSubscription != null) {
      _updateListeners.add(onLocationUpdate);
      return;
    }

    _updateListeners.clear();
    _updateListeners.add(onLocationUpdate);

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

    // Initialize Accelerometer for Battery Optimization
    _startMotionMonitoring();

    // Start with high accuracy initially
    _startLocationStream(highAccuracy: true);
  }

  void _startMotionMonitoring() {
    _lastMovedTime = DateTime.now();
    _accelSubscription?.cancel();

    if (kIsWeb) return; // No accelerometer on standard web usually

    _accelSubscription = accelerometerEventStream().listen((
      AccelerometerEvent event,
    ) {
      // Calculate magnitude of acceleration vector (including gravity)
      // Gravity is ~9.8 m/s^2. We check for deviation.
      final magnitude = math.sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );
      final delta = (magnitude - 9.8).abs();

      if (delta > _motionThreshold) {
        _onMotionDetected();
      }
    });

    // Check for stationary state periodically
    _stationaryTimer?.cancel();
    _stationaryTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      final secondsSinceMove = DateTime.now()
          .difference(_lastMovedTime)
          .inSeconds;
      if (secondsSinceMove > _stationaryThresholdSeconds && _isHighAccuracy) {
        debugPrint(
          'Device stationary for ${secondsSinceMove}s. Switching to Low Power GPS.',
        );
        _startLocationStream(highAccuracy: false);
      }
    });
  }

  void _onMotionDetected() {
    _lastMovedTime = DateTime.now();
    if (!_isHighAccuracy) {
      debugPrint('Motion detected. Switching to High Accuracy GPS.');
      _startLocationStream(highAccuracy: true);
    }
  }

  void _startLocationStream({required bool highAccuracy}) {
    _isHighAccuracy = highAccuracy;
    _positionSubscription?.cancel();

    late LocationSettings locationSettings;

    if (kIsWeb) {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    } else if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: highAccuracy
            ? LocationAccuracy.high
            : LocationAccuracy.medium,
        distanceFilter: highAccuracy
            ? 10
            : 100, // Drastically increase filter when stationary
        forceLocationManager: true,
        intervalDuration: Duration(
          seconds: highAccuracy ? 10 : 60,
        ), // Slower updates
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      locationSettings = AppleSettings(
        accuracy: highAccuracy
            ? LocationAccuracy.high
            : LocationAccuracy.medium,
        activityType: highAccuracy
            ? ActivityType.fitness
            : ActivityType
                  .automotiveNavigation, // fitness keeps it active, auto might be more lenient? actually fitness is good for walking.
        distanceFilter: highAccuracy ? 10 : 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: highAccuracy
            ? LocationAccuracy.high
            : LocationAccuracy.medium,
        distanceFilter: highAccuracy ? 10 : 100,
      );
    }

    try {
      _positionSubscription =
          Geolocator.getPositionStream(
            locationSettings: locationSettings,
          ).listen(
            (Position position) {
              _currentPosition = position;
              _currentPath.add(position);
              _scheduleSave();
              for (final listener in _updateListeners) {
                listener(position.latitude, position.longitude);
              }
              _positionController.add(position);
            },
            onError: (e) {
              debugPrint('Position stream error: $e');
            },
          );
    } catch (e) {
      debugPrint('Failed to start position stream: $e');
    }
  }

  /// Get current position
  Position? get currentPosition => _currentPosition;

  /// Stop location tracking
  void stopTracking() {
    _positionSubscription?.cancel();
    _accelSubscription?.cancel();
    _stationaryTimer?.cancel();
    _positionSubscription = null;
    _accelSubscription = null;
    _stationaryTimer = null;
    _updateListeners.clear();
  }

  /// Dispose resources
  void dispose() {
    stopTracking();
  }
}

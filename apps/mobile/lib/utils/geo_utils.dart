import 'package:latlong2/latlong.dart';
import 'dart:convert';

/// Geo utilities for point-in-polygon checking
class GeoUtils {
  /// Check if a point is inside any of the cleared areas (MultiPolygon GeoJSON)
  static bool isPointInClearedArea(LatLng point, String? geoJsonString) {
    if (geoJsonString == null || geoJsonString.isEmpty) {
      return false;
    }

    try {
      final data = jsonDecode(geoJsonString);
      
      if (data['type'] == 'MultiPolygon') {
        // MultiPolygon: array of polygons
        for (final polygon in data['coordinates']) {
          if (_isPointInPolygon(point, polygon[0])) {
            return true;
          }
        }
      } else if (data['type'] == 'Polygon') {
        // Single Polygon
        if (_isPointInPolygon(point, data['coordinates'][0])) {
          return true;
        }
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Ray casting algorithm for point-in-polygon test
  /// Uses the even-odd rule: if a ray from the point crosses an odd number of edges, it's inside
  static bool _isPointInPolygon(LatLng point, List<dynamic> ring) {
    if (ring.length < 3) return false;

    bool inside = false;
    final x = point.longitude;
    final y = point.latitude;

    for (int i = 0, j = ring.length - 1; i < ring.length; j = i++) {
      final xi = ring[i][0].toDouble(); // longitude
      final yi = ring[i][1].toDouble(); // latitude
      final xj = ring[j][0].toDouble();
      final yj = ring[j][1].toDouble();

      final intersect = ((yi > y) != (yj > y)) &&
          (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      
      if (intersect) {
        inside = !inside;
      }
    }

    return inside;
  }
}

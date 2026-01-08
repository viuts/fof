import 'package:latlong2/latlong.dart';
import 'dart:convert';

/// Geo utilities for point-in-polygon checking
class GeoUtils {
  /// Helper to parse GeoJSON MultiPolygon or Polygon into rings
  static List<List<LatLng>> parseGeoJson(String? geoJsonString) {
    if (geoJsonString == null || geoJsonString.isEmpty) return [];
    try {
      final data = jsonDecode(geoJsonString);
      final List<List<LatLng>> rings = [];

      if (data['type'] == 'MultiPolygon') {
        for (final polygon in data['coordinates']) {
          for (final ring in polygon) {
            rings.add(
              (ring as List)
                  .map(
                    (coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()),
                  )
                  .toList(),
            );
          }
        }
      } else if (data['type'] == 'Polygon') {
        for (final ring in data['coordinates']) {
          rings.add(
            (ring as List)
                .map(
                  (coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()),
                )
                .toList(),
          );
        }
      }
      return rings;
    } catch (e) {
      return [];
    }
  }

  /// Check if a point is inside any of the cleared area rings
  static bool isPointInClearedArea(LatLng point, List<List<LatLng>> rings) {
    for (final ring in rings) {
      if (_isPointInPolygon(point, ring)) {
        return true;
      }
    }
    return false;
  }

  /// Ray casting algorithm for point-in-polygon test
  /// Uses the even-odd rule: if a ray from the point crosses an odd number of edges, it's inside
  static bool _isPointInPolygon(LatLng point, List<LatLng> ring) {
    if (ring.length < 3) return false;

    bool inside = false;
    final x = point.longitude;
    final y = point.latitude;

    for (int i = 0, j = ring.length - 1; i < ring.length; j = i++) {
      final xi = ring[i].longitude;
      final yi = ring[i].latitude;
      final xj = ring[j].longitude;
      final yj = ring[j].latitude;

      final intersect =
          ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);

      if (intersect) {
        inside = !inside;
      }
    }

    return inside;
  }
}

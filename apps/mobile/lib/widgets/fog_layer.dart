import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

import 'dart:convert';
import 'dart:ui' as ui;

class FogLayer extends StatelessWidget {
  final List<List<LatLng>> clearedRings;
  final LatLng? currentLocation;
  final double visionRadius;
  final Color fogColor;

  const FogLayer({
    super.key,
    required this.clearedRings,
    this.currentLocation,
    this.visionRadius = 100,
    required this.fogColor,
  });

  /// Helper to parse GeoJSON MultiPolygon into rings
  static List<List<LatLng>> parseGeoJson(String? geoJsonString) {
    if (geoJsonString == null || geoJsonString.isEmpty) return [];
    try {
      final data = jsonDecode(geoJsonString);
      final List<List<LatLng>> rings = [];
      
      if (data['type'] == 'MultiPolygon') {
        for (final polygon in data['coordinates']) {
          for (final ring in polygon) {
            rings.add((ring as List).map((coord) => 
              LatLng(coord[1].toDouble(), coord[0].toDouble())
            ).toList());
          }
        }
      } else if (data['type'] == 'Polygon') {
        for (final ring in data['coordinates']) {
          rings.add((ring as List).map((coord) => 
            LatLng(coord[1].toDouble(), coord[0].toDouble())
          ).toList());
        }
      }
      return rings;
    } catch (e) {
      debugPrint('Error parsing GeoJSON: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    
    return MobileLayerTransformer(
      child: CustomPaint(
        painter: FogPainter(
          camera: camera,
          clearedRings: clearedRings,
          currentLocation: currentLocation,
          visionRadius: visionRadius,
          fogColor: fogColor,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class FogPainter extends CustomPainter {
  final MapCamera camera;
  final List<List<LatLng>> clearedRings;
  final LatLng? currentLocation;
  final double visionRadius;
  final Color fogColor;

  FogPainter({
    required this.camera,
    required this.clearedRings,
    this.currentLocation,
    this.visionRadius = 100,
    required this.fogColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width.isInfinite || size.height.isInfinite) return;

    // Use saveLayer with Saturation blend mode
    // This makes the background (map) grayscale in the fogged area
    // Cleared areas (holes) will remain transparent in this layer, effectively showing the original colored map
    canvas.saveLayer(
      ui.Rect.fromLTWH(0, 0, size.width, size.height), 
      Paint()..blendMode = ui.BlendMode.saturation
    );

    // 1. Draw the base fog (full screen) as pure black/white (Saturation = 0)
    // This "color" removes all saturation from the underlying map
    canvas.drawRect(
        ui.Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = const ui.Color(0xFF000000)..style = PaintingStyle.fill
    );

    // 2. Prepare paint for holes (eraser)
    final holePaint = Paint()
      ..blendMode = ui.BlendMode.dstOut
      ..color = const ui.Color(0xFF000000) // Opaque color to fully erase
      ..style = PaintingStyle.fill;

    // 3. Create path for holes
    final holesPath = ui.Path();

    // Add rings from GeoJSON
    for (final ring in clearedRings) {
      if (ring.isEmpty) continue;
      
      final points = ring.map((latlng) {
        final offset = camera.getOffsetFromOrigin(latlng);
        return ui.Offset(offset.dx, offset.dy);
      }).toList();

      if (points.isNotEmpty) {
        // Calculate bounding box in screen pixels
        double minX = points.first.dx;
        double maxX = points.first.dx;
        double minY = points.first.dy;
        double maxY = points.first.dy;

        for (var p in points.skip(1)) {
          if (p.dx < minX) minX = p.dx;
          if (p.dx > maxX) maxX = p.dx;
          if (p.dy < minY) minY = p.dy;
          if (p.dy > maxY) maxY = p.dy;
        }

        final width = maxX - minX;
        final height = maxY - minY;
        
        // If polygon is too small (e.g. zoomed out), draw a minimum-size circle/dot instead
        if (width < 3.0 || height < 3.0) {
            final centerX = minX + width / 2;
            final centerY = minY + height / 2;
            holesPath.addOval(ui.Rect.fromCircle(
                center: ui.Offset(centerX, centerY),
                radius: 3.0, // Minimum visible dot radius
            ));
        } else {
            // Draw normal polygon
            holesPath.moveTo(points.first.dx, points.first.dy);
            for (int i = 1; i < points.length; i++) {
                holesPath.lineTo(points[i].dx, points[i].dy);
            }
            holesPath.close();
        }
      }
    }

    // Add current location circle
    if (currentLocation != null) {
      final centerOffset = camera.getOffsetFromOrigin(currentLocation!);
      
      final double latRad = currentLocation!.latitude * math.pi / 180.0;
      final double metersPerPixel = 156543.03392 * math.cos(latRad) / math.pow(2, camera.zoom);
      final double radiusInPixels = visionRadius / metersPerPixel;
      
      // Ensure minimum visibility (2px radius) so it doesn't disappear when zoomed out
      final double effectiveRadius = math.max(radiusInPixels, 4.0);

      holesPath.addOval(ui.Rect.fromCircle(
        center: ui.Offset(centerOffset.dx, centerOffset.dy),
        radius: effectiveRadius,
      ));
    }

    // Draw all holes with the eraser paint
    canvas.drawPath(holesPath, holePaint);
    
    // Restore the layer to apply the compositing
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant FogPainter oldDelegate) {
    return oldDelegate.camera != camera ||
        oldDelegate.currentLocation != currentLocation ||
        oldDelegate.clearedRings != clearedRings ||
        oldDelegate.visionRadius != visionRadius ||
        oldDelegate.fogColor != fogColor;
  }
}

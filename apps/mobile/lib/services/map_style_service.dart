import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapStyle {
  final String name;
  final String urlTemplate;
  final List<String> subdomains;

  const MapStyle({
    required this.name,
    required this.urlTemplate,
    this.subdomains = const [],
  });
}

class MapStyleService extends ChangeNotifier {
  static const String _prefsKey = 'selected_map_style';

  static const List<MapStyle> styles = [
    MapStyle(
      name: 'Voyager',
      urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png',
      subdomains: ['a', 'b', 'c', 'd'],
    ),
    MapStyle(
      name: 'Positron (Light)',
      urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}@2x.png',
      subdomains: ['a', 'b', 'c', 'd'],
    ),
    MapStyle(
      name: 'Dark Matter (Dark)',
      urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png',
      subdomains: ['a', 'b', 'c', 'd'],
    ),
    MapStyle(
      name: 'OpenStreetMap',
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: ['a', 'b', 'c'],
    ),
    MapStyle(
      name: 'Esri World Street Map',
      urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
      subdomains: [],
    ),
  ];

  MapStyle _currentStyle = styles[0];
  MapStyle get currentStyle => _currentStyle;

  MapStyleService() {
    _loadStyle();
  }

  Future<void> _loadStyle() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString(_prefsKey);
    if (url != null) {
      try {
        _currentStyle = styles.firstWhere((s) => s.urlTemplate == url);
        notifyListeners();
      } catch (_) {
        // Style not found, keep default
      }
    }
  }

  Future<void> setStyle(MapStyle style) async {
    _currentStyle = style;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, style.urlTemplate);
  }
}

import 'package:flutter/material.dart';

/// Category constants and color mappings for shop beacons
class ShopCategory {
  // Category constants
  static const String ramen = 'ramen';
  static const String cafe = 'cafe';
  static const String pub = 'pub';
  static const String sushi = 'sushi';
  static const String izakaya = 'izakaya';
  static const String italian = 'italian';
  static const String french = 'french';
  static const String chinese = 'chinese';
  static const String korean = 'korean';
  static const String bakery = 'bakery';
  static const String fastfood = 'fastfood';
  static const String other = 'other';

  /// Get color for a given category
  static Color getColor(String category) {
    return _categoryColors[category.toLowerCase()] ?? _categoryColors[other]!;
  }

  /// Category to color mapping (per PRD: Ramen=Red, Cafe=Green, Pub=Blue)
  static final Map<String, Color> _categoryColors = {
    ramen: const Color(0xFFE53935), // Red
    cafe: const Color(0xFF43A047), // Green
    pub: const Color(0xFF1E88E5), // Blue
    sushi: const Color(0xFFFF6F00), // Deep Orange
    izakaya: const Color(0xFFD81B60), // Pink
    italian: const Color(0xFF8E24AA), // Purple
    french: const Color(0xFF5E35B1), // Deep Purple
    chinese: const Color(0xFFFDD835), // Yellow
    korean: const Color(0xFFE53935), // Red
    bakery: const Color(0xFFFB8C00), // Orange
    fastfood: const Color(0xFF757575), // Grey
    other: const Color(0xFF78909C), // Blue Grey
  };

  /// Category to Icon mapping
  static final Map<String, IconData> _categoryIcons = {
    ramen: Icons.ramen_dining,
    cafe: Icons.local_cafe,
    pub: Icons.local_bar,
    sushi: Icons.set_meal,
    izakaya: Icons.kebab_dining, // Best fit for Izakaya/Skewers
    italian: Icons.local_pizza,
    french: Icons.wine_bar,
    chinese: Icons.rice_bowl,
    korean: Icons.soup_kitchen,
    bakery: Icons.bakery_dining,
    fastfood: Icons.fastfood,
    other: Icons.storefront,
  };

  /// Get icon for a given category
  static IconData getIcon(String category) {
    return _categoryIcons[category.toLowerCase()] ?? Icons.storefront;
  }

  /// All available categories
  static List<String> get allCategories => _categoryColors.keys.toList();
}

/// Styling constants for shops
class ShopStyle {
  // Chain vs indie differentiation
  static const double indieShopMarkerSize = 25.0;
  static const double chainShopMarkerSize = 18.0;
  
  static const double indieShopOpacity = 1.0;
  static const double chainShopOpacity = 0.6;

  // Fog clearing radii (in meters)
  static const double pathClearingRadius = 10.0; // 5-10m per PRD
  static const double indieShopDiningBlastRadius = 250.0; // 250 per PRD
  static const double chainShopDiningBlastRadius = 20.0; // 90% less per PRD

  // Marker badge for chains
  static const Color chainBadgeColor = Color(0xFF424242);
  
  /// Get marker size based on whether shop is a chain
  static double getMarkerSize(bool isChain) {
    return isChain ? chainShopMarkerSize : indieShopMarkerSize;
  }

  /// Get marker opacity based on whether shop is a chain
  static double getMarkerOpacity(bool isChain) {
    return isChain ? chainShopOpacity : indieShopOpacity;
  }

  /// Get fog clearing radius based on whether shop is a chain
  static double getClearingRadius(bool isChain) {
    return isChain ? chainShopDiningBlastRadius : indieShopDiningBlastRadius;
  }
}

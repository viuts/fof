import 'package:flutter/material.dart';
import '../api/fof/v1/shop.pbenum.dart';
import '../services/language_service.dart';

/// Category constants and color mappings for shop beacons
class ShopCategory {
  /// Get color for a given FoodCategory enum
  static Color getColor(FoodCategory category) {
    return _categoryColors[category] ??
        _categoryColors[FoodCategory.FOOD_CATEGORY_UNSPECIFIED]!;
  }

  /// FoodCategory to color mapping
  static final Map<FoodCategory, Color> _categoryColors = {
    FoodCategory.FOOD_CATEGORY_UNSPECIFIED: const Color(
      0xFF78909C,
    ), // Blue Grey
    FoodCategory.FOOD_CATEGORY_WASHOKU: const Color(
      0xFF8D6E63,
    ), // Brown (traditional Japanese)
    FoodCategory.FOOD_CATEGORY_SUSHI: const Color(0xFFFF6F00), // Deep Orange
    FoodCategory.FOOD_CATEGORY_AGEMONO: const Color(
      0xFFFFB300,
    ), // Amber (fried foods)
    FoodCategory.FOOD_CATEGORY_YAKITORI: const Color(
      0xFFD84315,
    ), // Deep Orange Red
    FoodCategory.FOOD_CATEGORY_YAKINIKU: const Color(
      0xFFBF360C,
    ), // Deep Red (grilled meat)
    FoodCategory.FOOD_CATEGORY_NIKURYOURI: const Color(
      0xFFC62828,
    ), // Red (meat dishes)
    FoodCategory.FOOD_CATEGORY_NABE: const Color(
      0xFFEF6C00,
    ), // Orange (hot pot)
    FoodCategory.FOOD_CATEGORY_DON: const Color(0xFFF57C00), // Orange
    FoodCategory.FOOD_CATEGORY_MEN: const Color(
      0xFFFFB74D,
    ), // Light Orange (noodles)
    FoodCategory.FOOD_CATEGORY_RAMEN: const Color(0xFFE53935), // Red
    FoodCategory.FOOD_CATEGORY_KONAMONO: const Color(
      0xFF6D4C41,
    ), // Brown (flour-based)
    FoodCategory.FOOD_CATEGORY_YOSHOKU: const Color(
      0xFF7B1FA2,
    ), // Purple (Western-Japanese)
    FoodCategory.FOOD_CATEGORY_EUROPEAN: const Color(0xFF5E35B1), // Deep Purple
    FoodCategory.FOOD_CATEGORY_CHINESE: const Color(0xFFFDD835), // Yellow
    FoodCategory.FOOD_CATEGORY_KOREAN: const Color(0xFFE53935), // Red
    FoodCategory.FOOD_CATEGORY_ETHNIC: const Color(0xFF00897B), // Teal
    FoodCategory.FOOD_CATEGORY_CURRY: const Color(0xFFFF6F00), // Deep Orange
    FoodCategory.FOOD_CATEGORY_IZAKAYA: const Color(0xFFD81B60), // Pink
    FoodCategory.FOOD_CATEGORY_BAR: const Color(0xFF1E88E5), // Blue
    FoodCategory.FOOD_CATEGORY_CAFE: const Color(0xFF43A047), // Green
    FoodCategory.FOOD_CATEGORY_SWEETS: const Color(0xFFEC407A), // Pink
  };

  /// FoodCategory to Icon mapping
  static final Map<FoodCategory, IconData> _categoryIcons = {
    FoodCategory.FOOD_CATEGORY_UNSPECIFIED: Icons.storefront,
    FoodCategory.FOOD_CATEGORY_WASHOKU: Icons.rice_bowl,
    FoodCategory.FOOD_CATEGORY_SUSHI: Icons.set_meal,
    FoodCategory.FOOD_CATEGORY_AGEMONO: Icons.lunch_dining,
    FoodCategory.FOOD_CATEGORY_YAKITORI: Icons.kebab_dining,
    FoodCategory.FOOD_CATEGORY_YAKINIKU: Icons.outdoor_grill,
    FoodCategory.FOOD_CATEGORY_NIKURYOURI: Icons.dinner_dining,
    FoodCategory.FOOD_CATEGORY_NABE: Icons.soup_kitchen,
    FoodCategory.FOOD_CATEGORY_DON: Icons.rice_bowl,
    FoodCategory.FOOD_CATEGORY_MEN: Icons.ramen_dining,
    FoodCategory.FOOD_CATEGORY_RAMEN: Icons.ramen_dining,
    FoodCategory.FOOD_CATEGORY_KONAMONO: Icons.emoji_food_beverage,
    FoodCategory.FOOD_CATEGORY_YOSHOKU: Icons.restaurant,
    FoodCategory.FOOD_CATEGORY_EUROPEAN: Icons.wine_bar,
    FoodCategory.FOOD_CATEGORY_CHINESE: Icons.rice_bowl,
    FoodCategory.FOOD_CATEGORY_KOREAN: Icons.soup_kitchen,
    FoodCategory.FOOD_CATEGORY_ETHNIC: Icons.restaurant_menu,
    FoodCategory.FOOD_CATEGORY_CURRY: Icons.restaurant,
    FoodCategory.FOOD_CATEGORY_IZAKAYA: Icons.kebab_dining,
    FoodCategory.FOOD_CATEGORY_BAR: Icons.local_bar,
    FoodCategory.FOOD_CATEGORY_CAFE: Icons.local_cafe,
    FoodCategory.FOOD_CATEGORY_SWEETS: Icons.cake,
  };

  /// Get icon for a given FoodCategory enum
  static IconData getIcon(FoodCategory category) {
    return _categoryIcons[category] ?? Icons.storefront;
  }

  /// All available food categories for selection
  static const List<FoodCategory> allCategories = [
    FoodCategory.FOOD_CATEGORY_WASHOKU,
    FoodCategory.FOOD_CATEGORY_SUSHI,
    FoodCategory.FOOD_CATEGORY_AGEMONO,
    FoodCategory.FOOD_CATEGORY_YAKITORI,
    FoodCategory.FOOD_CATEGORY_YAKINIKU,
    FoodCategory.FOOD_CATEGORY_NIKURYOURI,
    FoodCategory.FOOD_CATEGORY_NABE,
    FoodCategory.FOOD_CATEGORY_DON,
    FoodCategory.FOOD_CATEGORY_RAMEN,
    FoodCategory.FOOD_CATEGORY_MEN,
    FoodCategory.FOOD_CATEGORY_KONAMONO,
    FoodCategory.FOOD_CATEGORY_YOSHOKU,
    FoodCategory.FOOD_CATEGORY_EUROPEAN,
    FoodCategory.FOOD_CATEGORY_CHINESE,
    FoodCategory.FOOD_CATEGORY_KOREAN,
    FoodCategory.FOOD_CATEGORY_ETHNIC,
    FoodCategory.FOOD_CATEGORY_CURRY,
    FoodCategory.FOOD_CATEGORY_IZAKAYA,
    FoodCategory.FOOD_CATEGORY_BAR,
    FoodCategory.FOOD_CATEGORY_CAFE,
    FoodCategory.FOOD_CATEGORY_SWEETS,
    FoodCategory.FOOD_CATEGORY_UNSPECIFIED,
  ];

  /// Grouped categories for better UI selection
  static List<CategoryGroup> getGroupedCategories(S s) {
    return [
      CategoryGroup(
        label: s.groupJapanese,
        categories: [
          FoodCategory.FOOD_CATEGORY_WASHOKU,
          FoodCategory.FOOD_CATEGORY_SUSHI,
          FoodCategory.FOOD_CATEGORY_AGEMONO,
          FoodCategory.FOOD_CATEGORY_YAKITORI,
          FoodCategory.FOOD_CATEGORY_YAKINIKU,
          FoodCategory.FOOD_CATEGORY_NIKURYOURI,
          FoodCategory.FOOD_CATEGORY_NABE,
          FoodCategory.FOOD_CATEGORY_DON,
          FoodCategory.FOOD_CATEGORY_KONAMONO,
        ],
      ),
      CategoryGroup(
        label: s.groupNoodles,
        categories: [
          FoodCategory.FOOD_CATEGORY_RAMEN,
          FoodCategory.FOOD_CATEGORY_MEN,
        ],
      ),
      CategoryGroup(
        label: s.groupWestern,
        categories: [
          FoodCategory.FOOD_CATEGORY_YOSHOKU,
          FoodCategory.FOOD_CATEGORY_EUROPEAN,
        ],
      ),
      CategoryGroup(
        label: s.groupAsian,
        categories: [
          FoodCategory.FOOD_CATEGORY_CHINESE,
          FoodCategory.FOOD_CATEGORY_KOREAN,
          FoodCategory.FOOD_CATEGORY_ETHNIC,
          FoodCategory.FOOD_CATEGORY_CURRY,
        ],
      ),
      CategoryGroup(
        label: s.groupDrinks,
        categories: [
          FoodCategory.FOOD_CATEGORY_IZAKAYA,
          FoodCategory.FOOD_CATEGORY_BAR,
        ],
      ),
      CategoryGroup(
        label: s.groupCafe,
        categories: [
          FoodCategory.FOOD_CATEGORY_CAFE,
          FoodCategory.FOOD_CATEGORY_SWEETS,
        ],
      ),
      CategoryGroup(
        label: s.groupOthers,
        categories: [FoodCategory.FOOD_CATEGORY_UNSPECIFIED],
      ),
    ];
  }
}

/// Helper class for grouping categories in the UI
class CategoryGroup {
  final String label;
  final List<FoodCategory> categories;

  CategoryGroup({required this.label, required this.categories});
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

  // Marker badge for chains
  static const Color chainBadgeColor = Color(0xFF424242);

  /// Get marker size based on whether shop is a chain
  static double getMarkerSize(bool isChain) {
    return isChain ? chainShopMarkerSize : indieShopMarkerSize;
  }
}

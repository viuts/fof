import 'package:flutter/material.dart';
import 'fof.pb.dart';
import '../../../constants/category_colors.dart';

extension ShopExtension on Shop {
  /// Get the actual food category, handling both enum and string fallback
  FoodCategory get effectiveFoodCategory {
    if (foodCategory != FoodCategory.FOOD_CATEGORY_UNSPECIFIED) {
      return foodCategory;
    }
    // Fallback: try to map the string 'category' to enum
    if (category.isEmpty) return FoodCategory.FOOD_CATEGORY_UNSPECIFIED;

    final upper = category.toUpperCase();
    return FoodCategory.values.firstWhere(
      (e) => e.name == upper,
      orElse: () => FoodCategory.FOOD_CATEGORY_UNSPECIFIED,
    );
  }

  /// Get color for this shop based on category
  Color get color => ShopCategory.getColor(effectiveFoodCategory);

  /// Get marker size based on whether this is a chain
  double get markerSize => ShopStyle.getMarkerSize(isChain);

  /// Get marker opacity based on whether this is a chain
  double get markerOpacity => ShopStyle.getMarkerOpacity(isChain);

  /// Get clearance radius, defaulting to style guide if not set in proto
  double get effectiveClearanceRadius => clearanceRadius > 0
      ? clearanceRadius
      : ShopStyle.getClearingRadius(isChain);
}

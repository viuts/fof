import 'package:flutter/material.dart';
import 'fof.pb.dart';
import '../../../constants/category_colors.dart';

extension ShopExtension on Shop {
  /// Get color for this shop based on category
  Color get color => ShopCategory.getColor(category);

  /// Get marker size based on whether this is a chain
  double get markerSize => ShopStyle.getMarkerSize(isChain);

  /// Get marker opacity based on whether this is a chain
  double get markerOpacity => ShopStyle.getMarkerOpacity(isChain);

  /// Get clearance radius, defaulting to style guide if not set in proto
  double get effectiveClearanceRadius => clearanceRadius > 0 
      ? clearanceRadius 
      : ShopStyle.getClearingRadius(isChain);
}

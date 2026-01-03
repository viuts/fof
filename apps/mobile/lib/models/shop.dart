import 'package:flutter/material.dart';
import '../constants/category_colors.dart';

class Shop {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String category;
  final bool isVisited;
  final bool isChain; // FR-7: Chain detection
  final String address;
  final String phone;
  final String openingHours;
  final List<String> imageUrls;
  final double rating;
  final String sourceUrl;
  final double clearanceRadius; // Differentiated fog clearing

  Shop({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.category = '',
    this.isVisited = false,
    this.isChain = false,
    this.address = '',
    this.phone = '',
    this.openingHours = '',
    this.imageUrls = const [],
    this.rating = 0.0,
    this.sourceUrl = '',
    double? clearanceRadius,
  }) : clearanceRadius = clearanceRadius ?? 
       ShopStyle.getClearingRadius(isChain);

  /// Get color for this shop based on category (FR-6)
  Color get color => ShopCategory.getColor(category);

  /// Get marker size based on whether this is a chain
  double get markerSize => ShopStyle.getMarkerSize(isChain);

  /// Get marker opacity based on whether this is a chain
  double get markerOpacity => ShopStyle.getMarkerOpacity(isChain);

  factory Shop.fromJson(Map<String, dynamic> json) {
    final isChain = json['isChain'] ?? json['is_chain'] ?? false;
    return Shop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lat: (json['lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      isVisited: json['isVisited'] ?? json['is_visited'] ?? false,
      isChain: isChain,
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      openingHours: json['openingHours'] ?? json['opening_hours'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? json['image_urls'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      sourceUrl: json['sourceUrl'] ?? json['source_url'] ?? '',
      clearanceRadius: json['clearanceRadius']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'category': category,
      'isVisited': isVisited,
      'isChain': isChain,
      'address': address,
      'phone': phone,
      'openingHours': openingHours,
      'imageUrls': imageUrls,
      'rating': rating,
      'sourceUrl': sourceUrl,
      'clearanceRadius': clearanceRadius,
    };
  }
}

class UpdateLocationResponse {
  final bool newlyCleared;
  final String clearedAreaGeojson;

  UpdateLocationResponse({
    required this.newlyCleared,
    required this.clearedAreaGeojson,
  });

  factory UpdateLocationResponse.fromJson(Map<String, dynamic> json) {
    return UpdateLocationResponse(
      newlyCleared: json['newlyCleared'] ?? false,
      clearedAreaGeojson: json['clearedAreaGeojson'] ?? '',
    );
  }
}

class GetNearbyShopsResponse {
  final List<Shop> shops;

  GetNearbyShopsResponse({required this.shops});

  factory GetNearbyShopsResponse.fromJson(Map<String, dynamic> json) {
    final shopsList = json['shops'] as List<dynamic>? ?? [];
    return GetNearbyShopsResponse(
      shops: shopsList.map((s) => Shop.fromJson(s)).toList(),
    );
  }
}

class GetVisitedShopsResponse {
  final List<Shop> shops;

  GetVisitedShopsResponse({required this.shops});

  factory GetVisitedShopsResponse.fromJson(Map<String, dynamic> json) {
    final shopsList = json['shops'] as List<dynamic>? ?? [];
    return GetVisitedShopsResponse(
      shops: shopsList.map((s) => Shop.fromJson(s)).toList(),
    );
  }
}
class GetClearedAreaResponse {
  final String clearedAreaGeojson;

  GetClearedAreaResponse({required this.clearedAreaGeojson});

  factory GetClearedAreaResponse.fromJson(Map<String, dynamic> json) {
    return GetClearedAreaResponse(
      clearedAreaGeojson: json['clearedAreaGeojson'] ?? '',
    );
  }
}

class CreateVisitResponse {
  final bool success;
  final String clearedAreaGeojson;
  final int expGained;
  final int currentExp;
  final int currentLevel;

  CreateVisitResponse({
    required this.success,
    required this.clearedAreaGeojson,
    this.expGained = 0,
    this.currentExp = 0,
    this.currentLevel = 1,
  });

  factory CreateVisitResponse.fromJson(Map<String, dynamic> json) {
    return CreateVisitResponse(
      success: json['success'] ?? false,
      clearedAreaGeojson: json['clearedAreaGeojson'] ?? '',
      expGained: json['expGained'] ?? json['exp_gained'] ?? 0,
      currentExp: json['currentExp'] ?? json['current_exp'] ?? 0,
      currentLevel: json['currentLevel'] ?? json['current_level'] ?? 1,
    );
  }
}

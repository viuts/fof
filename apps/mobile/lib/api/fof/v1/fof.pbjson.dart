//
//  Generated code. Do not modify.
//  source: fof/v1/fof.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use foodCategoryDescriptor instead')
const FoodCategory$json = {
  '1': 'FoodCategory',
  '2': [
    {'1': 'FOOD_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'FOOD_CATEGORY_WASHOKU', '2': 1},
    {'1': 'FOOD_CATEGORY_SUSHI', '2': 2},
    {'1': 'FOOD_CATEGORY_AGEMONO', '2': 3},
    {'1': 'FOOD_CATEGORY_YAKITORI', '2': 4},
    {'1': 'FOOD_CATEGORY_YAKINIKU', '2': 5},
    {'1': 'FOOD_CATEGORY_NIKURYOURI', '2': 6},
    {'1': 'FOOD_CATEGORY_NABE', '2': 7},
    {'1': 'FOOD_CATEGORY_DON', '2': 8},
    {'1': 'FOOD_CATEGORY_MEN', '2': 9},
    {'1': 'FOOD_CATEGORY_RAMEN', '2': 10},
    {'1': 'FOOD_CATEGORY_KONAMONO', '2': 11},
    {'1': 'FOOD_CATEGORY_YOSHOKU', '2': 12},
    {'1': 'FOOD_CATEGORY_EUROPEAN', '2': 13},
    {'1': 'FOOD_CATEGORY_CHINESE', '2': 14},
    {'1': 'FOOD_CATEGORY_KOREAN', '2': 15},
    {'1': 'FOOD_CATEGORY_ETHNIC', '2': 16},
    {'1': 'FOOD_CATEGORY_CURRY', '2': 17},
    {'1': 'FOOD_CATEGORY_IZAKAYA', '2': 18},
    {'1': 'FOOD_CATEGORY_BAR', '2': 19},
    {'1': 'FOOD_CATEGORY_CAFE', '2': 20},
    {'1': 'FOOD_CATEGORY_SWEETS', '2': 21},
  ],
};

/// Descriptor for `FoodCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List foodCategoryDescriptor = $convert.base64Decode(
    'CgxGb29kQ2F0ZWdvcnkSHQoZRk9PRF9DQVRFR09SWV9VTlNQRUNJRklFRBAAEhkKFUZPT0RfQ0'
    'FURUdPUllfV0FTSE9LVRABEhcKE0ZPT0RfQ0FURUdPUllfU1VTSEkQAhIZChVGT09EX0NBVEVH'
    'T1JZX0FHRU1PTk8QAxIaChZGT09EX0NBVEVHT1JZX1lBS0lUT1JJEAQSGgoWRk9PRF9DQVRFR0'
    '9SWV9ZQUtJTklLVRAFEhwKGEZPT0RfQ0FURUdPUllfTklLVVJZT1VSSRAGEhYKEkZPT0RfQ0FU'
    'RUdPUllfTkFCRRAHEhUKEUZPT0RfQ0FURUdPUllfRE9OEAgSFQoRRk9PRF9DQVRFR09SWV9NRU'
    '4QCRIXChNGT09EX0NBVEVHT1JZX1JBTUVOEAoSGgoWRk9PRF9DQVRFR09SWV9LT05BTU9OTxAL'
    'EhkKFUZPT0RfQ0FURUdPUllfWU9TSE9LVRAMEhoKFkZPT0RfQ0FURUdPUllfRVVST1BFQU4QDR'
    'IZChVGT09EX0NBVEVHT1JZX0NISU5FU0UQDhIYChRGT09EX0NBVEVHT1JZX0tPUkVBThAPEhgK'
    'FEZPT0RfQ0FURUdPUllfRVRITklDEBASFwoTRk9PRF9DQVRFR09SWV9DVVJSWRAREhkKFUZPT0'
    'RfQ0FURUdPUllfSVpBS0FZQRASEhUKEUZPT0RfQ0FURUdPUllfQkFSEBMSFgoSRk9PRF9DQVRF'
    'R09SWV9DQUZFEBQSGAoURk9PRF9DQVRFR09SWV9TV0VFVFMQFQ==');

@$core.Deprecated('Use latLngDescriptor instead')
const LatLng$json = {
  '1': 'LatLng',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
  ],
};

/// Descriptor for `LatLng`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List latLngDescriptor = $convert.base64Decode(
    'CgZMYXRMbmcSEAoDbGF0GAEgASgBUgNsYXQSEAoDbG5nGAIgASgBUgNsbmc=');

@$core.Deprecated('Use getClearedAreaRequestDescriptor instead')
const GetClearedAreaRequest$json = {
  '1': 'GetClearedAreaRequest',
};

/// Descriptor for `GetClearedAreaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClearedAreaRequestDescriptor = $convert.base64Decode(
    'ChVHZXRDbGVhcmVkQXJlYVJlcXVlc3Q=');

@$core.Deprecated('Use getClearedAreaResponseDescriptor instead')
const GetClearedAreaResponse$json = {
  '1': 'GetClearedAreaResponse',
  '2': [
    {'1': 'cleared_area_geojson', '3': 1, '4': 1, '5': 9, '10': 'clearedAreaGeojson'},
  ],
};

/// Descriptor for `GetClearedAreaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClearedAreaResponseDescriptor = $convert.base64Decode(
    'ChZHZXRDbGVhcmVkQXJlYVJlc3BvbnNlEjAKFGNsZWFyZWRfYXJlYV9nZW9qc29uGAEgASgJUh'
    'JjbGVhcmVkQXJlYUdlb2pzb24=');

@$core.Deprecated('Use createVisitRequestDescriptor instead')
const CreateVisitRequest$json = {
  '1': 'CreateVisitRequest',
  '2': [
    {'1': 'shop_id', '3': 1, '4': 1, '5': 9, '10': 'shopId'},
    {'1': 'rating', '3': 2, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'comment', '3': 3, '4': 1, '5': 9, '10': 'comment'},
  ],
};

/// Descriptor for `CreateVisitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVisitRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVWaXNpdFJlcXVlc3QSFwoHc2hvcF9pZBgBIAEoCVIGc2hvcElkEhYKBnJhdGluZx'
    'gCIAEoBVIGcmF0aW5nEhgKB2NvbW1lbnQYAyABKAlSB2NvbW1lbnQ=');

@$core.Deprecated('Use createVisitResponseDescriptor instead')
const CreateVisitResponse$json = {
  '1': 'CreateVisitResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'cleared_area_geojson', '3': 2, '4': 1, '5': 9, '10': 'clearedAreaGeojson'},
    {'1': 'exp_gained', '3': 3, '4': 1, '5': 5, '10': 'expGained'},
    {'1': 'current_exp', '3': 4, '4': 1, '5': 5, '10': 'currentExp'},
    {'1': 'current_level', '3': 5, '4': 1, '5': 5, '10': 'currentLevel'},
    {'1': 'unlocked_achievements', '3': 6, '4': 3, '5': 11, '6': '.fof.v1.Achievement', '10': 'unlockedAchievements'},
  ],
};

/// Descriptor for `CreateVisitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVisitResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVWaXNpdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMAoUY2xlYX'
    'JlZF9hcmVhX2dlb2pzb24YAiABKAlSEmNsZWFyZWRBcmVhR2VvanNvbhIdCgpleHBfZ2FpbmVk'
    'GAMgASgFUglleHBHYWluZWQSHwoLY3VycmVudF9leHAYBCABKAVSCmN1cnJlbnRFeHASIwoNY3'
    'VycmVudF9sZXZlbBgFIAEoBVIMY3VycmVudExldmVsEkgKFXVubG9ja2VkX2FjaGlldmVtZW50'
    'cxgGIAMoCzITLmZvZi52MS5BY2hpZXZlbWVudFIUdW5sb2NrZWRBY2hpZXZlbWVudHM=');

@$core.Deprecated('Use achievementDescriptor instead')
const Achievement$json = {
  '1': 'Achievement',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'exp_reward', '3': 4, '4': 1, '5': 5, '10': 'expReward'},
    {'1': 'title_reward', '3': 5, '4': 1, '5': 9, '10': 'titleReward'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `Achievement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List achievementDescriptor = $convert.base64Decode(
    'CgtBY2hpZXZlbWVudBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZX'
    'NjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHQoKZXhwX3Jld2FyZBgEIAEoBVIJZXhwUmV3'
    'YXJkEiEKDHRpdGxlX3Jld2FyZBgFIAEoCVILdGl0bGVSZXdhcmQSGgoIY2F0ZWdvcnkYBiABKA'
    'lSCGNhdGVnb3J5');

@$core.Deprecated('Use updateLocationRequestDescriptor instead')
const UpdateLocationRequest$json = {
  '1': 'UpdateLocationRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.LatLng', '10': 'path'},
    {'1': 'accuracy', '3': 2, '4': 1, '5': 1, '10': 'accuracy'},
  ],
};

/// Descriptor for `UpdateLocationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLocationRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVMb2NhdGlvblJlcXVlc3QSIgoEcGF0aBgBIAMoCzIOLmZvZi52MS5MYXRMbmdSBH'
    'BhdGgSGgoIYWNjdXJhY3kYAiABKAFSCGFjY3VyYWN5');

@$core.Deprecated('Use updateLocationResponseDescriptor instead')
const UpdateLocationResponse$json = {
  '1': 'UpdateLocationResponse',
  '2': [
    {'1': 'newly_cleared', '3': 1, '4': 1, '5': 8, '10': 'newlyCleared'},
    {'1': 'cleared_area_geojson', '3': 2, '4': 1, '5': 9, '10': 'clearedAreaGeojson'},
  ],
};

/// Descriptor for `UpdateLocationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLocationResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVMb2NhdGlvblJlc3BvbnNlEiMKDW5ld2x5X2NsZWFyZWQYASABKAhSDG5ld2x5Q2'
    'xlYXJlZBIwChRjbGVhcmVkX2FyZWFfZ2VvanNvbhgCIAEoCVISY2xlYXJlZEFyZWFHZW9qc29u');

@$core.Deprecated('Use getNearbyShopsRequestDescriptor instead')
const GetNearbyShopsRequest$json = {
  '1': 'GetNearbyShopsRequest',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
    {'1': 'radius_meters', '3': 3, '4': 1, '5': 1, '10': 'radiusMeters'},
    {'1': 'exclusive_independent', '3': 4, '4': 1, '5': 8, '10': 'exclusiveIndependent'},
  ],
};

/// Descriptor for `GetNearbyShopsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNearbyShopsRequestDescriptor = $convert.base64Decode(
    'ChVHZXROZWFyYnlTaG9wc1JlcXVlc3QSEAoDbGF0GAEgASgBUgNsYXQSEAoDbG5nGAIgASgBUg'
    'NsbmcSIwoNcmFkaXVzX21ldGVycxgDIAEoAVIMcmFkaXVzTWV0ZXJzEjMKFWV4Y2x1c2l2ZV9p'
    'bmRlcGVuZGVudBgEIAEoCFIUZXhjbHVzaXZlSW5kZXBlbmRlbnQ=');

@$core.Deprecated('Use getNearbyShopsResponseDescriptor instead')
const GetNearbyShopsResponse$json = {
  '1': 'GetNearbyShopsResponse',
  '2': [
    {'1': 'shops', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.Shop', '10': 'shops'},
  ],
};

/// Descriptor for `GetNearbyShopsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNearbyShopsResponseDescriptor = $convert.base64Decode(
    'ChZHZXROZWFyYnlTaG9wc1Jlc3BvbnNlEiIKBXNob3BzGAEgAygLMgwuZm9mLnYxLlNob3BSBX'
    'Nob3Bz');

@$core.Deprecated('Use getVisitedShopsRequestDescriptor instead')
const GetVisitedShopsRequest$json = {
  '1': 'GetVisitedShopsRequest',
};

/// Descriptor for `GetVisitedShopsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVisitedShopsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRWaXNpdGVkU2hvcHNSZXF1ZXN0');

@$core.Deprecated('Use getVisitedShopsResponseDescriptor instead')
const GetVisitedShopsResponse$json = {
  '1': 'GetVisitedShopsResponse',
  '2': [
    {'1': 'visited_shops', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.VisitedShop', '10': 'visitedShops'},
  ],
};

/// Descriptor for `GetVisitedShopsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVisitedShopsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRWaXNpdGVkU2hvcHNSZXNwb25zZRI4Cg12aXNpdGVkX3Nob3BzGAEgAygLMhMuZm9mLn'
    'YxLlZpc2l0ZWRTaG9wUgx2aXNpdGVkU2hvcHM=');

@$core.Deprecated('Use visitedShopDescriptor instead')
const VisitedShop$json = {
  '1': 'VisitedShop',
  '2': [
    {'1': 'shop', '3': 1, '4': 1, '5': 11, '6': '.fof.v1.Shop', '10': 'shop'},
    {'1': 'visited_at', '3': 2, '4': 1, '5': 9, '10': 'visitedAt'},
    {'1': 'rating', '3': 3, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'comment', '3': 4, '4': 1, '5': 9, '10': 'comment'},
  ],
};

/// Descriptor for `VisitedShop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List visitedShopDescriptor = $convert.base64Decode(
    'CgtWaXNpdGVkU2hvcBIgCgRzaG9wGAEgASgLMgwuZm9mLnYxLlNob3BSBHNob3ASHQoKdmlzaX'
    'RlZF9hdBgCIAEoCVIJdmlzaXRlZEF0EhYKBnJhdGluZxgDIAEoBVIGcmF0aW5nEhgKB2NvbW1l'
    'bnQYBCABKAlSB2NvbW1lbnQ=');

@$core.Deprecated('Use shopDescriptor instead')
const Shop$json = {
  '1': 'Shop',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'lat', '3': 3, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 4, '4': 1, '5': 1, '10': 'lng'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'is_visited', '3': 6, '4': 1, '5': 8, '10': 'isVisited'},
    {'1': 'is_chain', '3': 7, '4': 1, '5': 8, '10': 'isChain'},
    {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
    {'1': 'phone', '3': 9, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'opening_hours', '3': 10, '4': 1, '5': 9, '10': 'openingHours'},
    {'1': 'image_urls', '3': 11, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'rating', '3': 12, '4': 1, '5': 1, '10': 'rating'},
    {'1': 'source_url', '3': 13, '4': 1, '5': 9, '10': 'sourceUrl'},
    {'1': 'clearance_radius', '3': 14, '4': 1, '5': 1, '10': 'clearanceRadius'},
    {'1': 'food_category', '3': 15, '4': 1, '5': 14, '6': '.fof.v1.FoodCategory', '10': 'foodCategory'},
    {'1': 'reservable', '3': 16, '4': 1, '5': 8, '10': 'reservable'},
  ],
};

/// Descriptor for `Shop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shopDescriptor = $convert.base64Decode(
    'CgRTaG9wEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhAKA2xhdBgDIAEoAV'
    'IDbGF0EhAKA2xuZxgEIAEoAVIDbG5nEhoKCGNhdGVnb3J5GAUgASgJUghjYXRlZ29yeRIdCgpp'
    'c192aXNpdGVkGAYgASgIUglpc1Zpc2l0ZWQSGQoIaXNfY2hhaW4YByABKAhSB2lzQ2hhaW4SGA'
    'oHYWRkcmVzcxgIIAEoCVIHYWRkcmVzcxIUCgVwaG9uZRgJIAEoCVIFcGhvbmUSIwoNb3Blbmlu'
    'Z19ob3VycxgKIAEoCVIMb3BlbmluZ0hvdXJzEh0KCmltYWdlX3VybHMYCyADKAlSCWltYWdlVX'
    'JscxIWCgZyYXRpbmcYDCABKAFSBnJhdGluZxIdCgpzb3VyY2VfdXJsGA0gASgJUglzb3VyY2VV'
    'cmwSKQoQY2xlYXJhbmNlX3JhZGl1cxgOIAEoAVIPY2xlYXJhbmNlUmFkaXVzEjkKDWZvb2RfY2'
    'F0ZWdvcnkYDyABKA4yFC5mb2YudjEuRm9vZENhdGVnb3J5Ugxmb29kQ2F0ZWdvcnkSHgoKcmVz'
    'ZXJ2YWJsZRgQIAEoCFIKcmVzZXJ2YWJsZQ==');

@$core.Deprecated('Use getAchievementsRequestDescriptor instead')
const GetAchievementsRequest$json = {
  '1': 'GetAchievementsRequest',
};

/// Descriptor for `GetAchievementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAchievementsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRBY2hpZXZlbWVudHNSZXF1ZXN0');

@$core.Deprecated('Use getAchievementsResponseDescriptor instead')
const GetAchievementsResponse$json = {
  '1': 'GetAchievementsResponse',
  '2': [
    {'1': 'achievements', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.UserAchievementStatus', '10': 'achievements'},
  ],
};

/// Descriptor for `GetAchievementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAchievementsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRBY2hpZXZlbWVudHNSZXNwb25zZRJBCgxhY2hpZXZlbWVudHMYASADKAsyHS5mb2Yudj'
    'EuVXNlckFjaGlldmVtZW50U3RhdHVzUgxhY2hpZXZlbWVudHM=');

@$core.Deprecated('Use userAchievementStatusDescriptor instead')
const UserAchievementStatus$json = {
  '1': 'UserAchievementStatus',
  '2': [
    {'1': 'achievement', '3': 1, '4': 1, '5': 11, '6': '.fof.v1.Achievement', '10': 'achievement'},
    {'1': 'is_unlocked', '3': 2, '4': 1, '5': 8, '10': 'isUnlocked'},
    {'1': 'current_value', '3': 3, '4': 1, '5': 5, '10': 'currentValue'},
    {'1': 'target_value', '3': 4, '4': 1, '5': 5, '10': 'targetValue'},
    {'1': 'unlocked_at', '3': 5, '4': 1, '5': 9, '10': 'unlockedAt'},
  ],
};

/// Descriptor for `UserAchievementStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAchievementStatusDescriptor = $convert.base64Decode(
    'ChVVc2VyQWNoaWV2ZW1lbnRTdGF0dXMSNQoLYWNoaWV2ZW1lbnQYASABKAsyEy5mb2YudjEuQW'
    'NoaWV2ZW1lbnRSC2FjaGlldmVtZW50Eh8KC2lzX3VubG9ja2VkGAIgASgIUgppc1VubG9ja2Vk'
    'EiMKDWN1cnJlbnRfdmFsdWUYAyABKAVSDGN1cnJlbnRWYWx1ZRIhCgx0YXJnZXRfdmFsdWUYBC'
    'ABKAVSC3RhcmdldFZhbHVlEh8KC3VubG9ja2VkX2F0GAUgASgJUgp1bmxvY2tlZEF0');


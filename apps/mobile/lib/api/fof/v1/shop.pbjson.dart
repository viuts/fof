//
//  Generated code. Do not modify.
//  source: fof/v1/shop.proto
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


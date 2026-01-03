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
  ],
};

/// Descriptor for `CreateVisitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVisitRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVWaXNpdFJlcXVlc3QSFwoHc2hvcF9pZBgBIAEoCVIGc2hvcElk');

@$core.Deprecated('Use createVisitResponseDescriptor instead')
const CreateVisitResponse$json = {
  '1': 'CreateVisitResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'cleared_area_geojson', '3': 2, '4': 1, '5': 9, '10': 'clearedAreaGeojson'},
  ],
};

/// Descriptor for `CreateVisitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVisitResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVWaXNpdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMAoUY2xlYX'
    'JlZF9hcmVhX2dlb2pzb24YAiABKAlSEmNsZWFyZWRBcmVhR2VvanNvbg==');

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
    {'1': 'shops', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.Shop', '10': 'shops'},
  ],
};

/// Descriptor for `GetVisitedShopsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVisitedShopsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRWaXNpdGVkU2hvcHNSZXNwb25zZRIiCgVzaG9wcxgBIAMoCzIMLmZvZi52MS5TaG9wUg'
    'VzaG9wcw==');

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
    'cmw=');


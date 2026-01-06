//
//  Generated code. Do not modify.
//  source: fof/v1/visit.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

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


//
//  Generated code. Do not modify.
//  source: fof/v1/location.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getFogStatsRequestDescriptor instead')
const GetFogStatsRequest$json = {
  '1': 'GetFogStatsRequest',
};

/// Descriptor for `GetFogStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFogStatsRequestDescriptor = $convert.base64Decode(
    'ChJHZXRGb2dTdGF0c1JlcXVlc3Q=');

@$core.Deprecated('Use getFogStatsResponseDescriptor instead')
const GetFogStatsResponse$json = {
  '1': 'GetFogStatsResponse',
  '2': [
    {'1': 'cleared_area_meters', '3': 1, '4': 1, '5': 1, '10': 'clearedAreaMeters'},
    {'1': 'world_coverage_percentage', '3': 2, '4': 1, '5': 1, '10': 'worldCoveragePercentage'},
  ],
};

/// Descriptor for `GetFogStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFogStatsResponseDescriptor = $convert.base64Decode(
    'ChNHZXRGb2dTdGF0c1Jlc3BvbnNlEi4KE2NsZWFyZWRfYXJlYV9tZXRlcnMYASABKAFSEWNsZW'
    'FyZWRBcmVhTWV0ZXJzEjoKGXdvcmxkX2NvdmVyYWdlX3BlcmNlbnRhZ2UYAiABKAFSF3dvcmxk'
    'Q292ZXJhZ2VQZXJjZW50YWdl');

@$core.Deprecated('Use getClearedAreaRequestDescriptor instead')
const GetClearedAreaRequest$json = {
  '1': 'GetClearedAreaRequest',
  '2': [
    {'1': 'min_lat', '3': 1, '4': 1, '5': 1, '10': 'minLat'},
    {'1': 'min_lng', '3': 2, '4': 1, '5': 1, '10': 'minLng'},
    {'1': 'max_lat', '3': 3, '4': 1, '5': 1, '10': 'maxLat'},
    {'1': 'max_lng', '3': 4, '4': 1, '5': 1, '10': 'maxLng'},
  ],
};

/// Descriptor for `GetClearedAreaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClearedAreaRequestDescriptor = $convert.base64Decode(
    'ChVHZXRDbGVhcmVkQXJlYVJlcXVlc3QSFwoHbWluX2xhdBgBIAEoAVIGbWluTGF0EhcKB21pbl'
    '9sbmcYAiABKAFSBm1pbkxuZxIXCgdtYXhfbGF0GAMgASgBUgZtYXhMYXQSFwoHbWF4X2xuZxgE'
    'IAEoAVIGbWF4TG5n');

@$core.Deprecated('Use getClearedAreaResponseDescriptor instead')
const GetClearedAreaResponse$json = {
  '1': 'GetClearedAreaResponse',
  '2': [
    {'1': 'cleared_area_geojson', '3': 1, '4': 1, '5': 9, '10': 'clearedAreaGeojson'},
    {'1': 'cleared_area_meters', '3': 2, '4': 1, '5': 1, '10': 'clearedAreaMeters'},
    {'1': 'world_coverage_percentage', '3': 3, '4': 1, '5': 1, '10': 'worldCoveragePercentage'},
  ],
};

/// Descriptor for `GetClearedAreaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClearedAreaResponseDescriptor = $convert.base64Decode(
    'ChZHZXRDbGVhcmVkQXJlYVJlc3BvbnNlEjAKFGNsZWFyZWRfYXJlYV9nZW9qc29uGAEgASgJUh'
    'JjbGVhcmVkQXJlYUdlb2pzb24SLgoTY2xlYXJlZF9hcmVhX21ldGVycxgCIAEoAVIRY2xlYXJl'
    'ZEFyZWFNZXRlcnMSOgoZd29ybGRfY292ZXJhZ2VfcGVyY2VudGFnZRgDIAEoAVIXd29ybGRDb3'
    'ZlcmFnZVBlcmNlbnRhZ2U=');

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
};

/// Descriptor for `UpdateLocationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLocationResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVMb2NhdGlvblJlc3BvbnNl');


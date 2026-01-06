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


//
//  Generated code. Do not modify.
//  source: fof/v1/ranking.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getRankingRequestDescriptor instead')
const GetRankingRequest$json = {
  '1': 'GetRankingRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRankingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRankingRequestDescriptor = $convert.base64Decode(
    'ChFHZXRSYW5raW5nUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getCategoryRankingRequestDescriptor instead')
const GetCategoryRankingRequest$json = {
  '1': 'GetCategoryRankingRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetCategoryRankingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryRankingRequestDescriptor = $convert.base64Decode(
    'ChlHZXRDYXRlZ29yeVJhbmtpbmdSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeR'
    'IUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getRankingResponseDescriptor instead')
const GetRankingResponse$json = {
  '1': 'GetRankingResponse',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.RankingEntry', '10': 'entries'},
  ],
};

/// Descriptor for `GetRankingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRankingResponseDescriptor = $convert.base64Decode(
    'ChJHZXRSYW5raW5nUmVzcG9uc2USLgoHZW50cmllcxgBIAMoCzIULmZvZi52MS5SYW5raW5nRW'
    '50cnlSB2VudHJpZXM=');

@$core.Deprecated('Use rankingEntryDescriptor instead')
const RankingEntry$json = {
  '1': 'RankingEntry',
  '2': [
    {'1': 'rank', '3': 1, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_image', '3': 5, '4': 1, '5': 9, '10': 'profileImage'},
    {'1': 'score', '3': 6, '4': 1, '5': 1, '10': 'score'},
    {'1': 'level', '3': 7, '4': 1, '5': 5, '10': 'level'},
  ],
};

/// Descriptor for `RankingEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rankingEntryDescriptor = $convert.base64Decode(
    'CgxSYW5raW5nRW50cnkSEgoEcmFuaxgBIAEoBVIEcmFuaxIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSGgoIdXNlcm5hbWUYAyABKAlSCHVzZXJuYW1lEiEKDGRpc3BsYXlfbmFtZRgEIAEoCVIL'
    'ZGlzcGxheU5hbWUSIwoNcHJvZmlsZV9pbWFnZRgFIAEoCVIMcHJvZmlsZUltYWdlEhQKBXNjb3'
    'JlGAYgASgBUgVzY29yZRIUCgVsZXZlbBgHIAEoBVIFbGV2ZWw=');


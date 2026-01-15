//
//  Generated code. Do not modify.
//  source: fof/v1/quest.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use questStatusDescriptor instead')
const QuestStatus$json = {
  '1': 'QuestStatus',
  '2': [
    {'1': 'QUEST_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'QUEST_STATUS_ACTIVE', '2': 1},
    {'1': 'QUEST_STATUS_COMPLETED', '2': 2},
    {'1': 'QUEST_STATUS_CANCELLED', '2': 3},
  ],
};

/// Descriptor for `QuestStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List questStatusDescriptor = $convert.base64Decode(
    'CgtRdWVzdFN0YXR1cxIcChhRVUVTVF9TVEFUVVNfVU5TUEVDSUZJRUQQABIXChNRVUVTVF9TVE'
    'FUVVNfQUNUSVZFEAESGgoWUVVFU1RfU1RBVFVTX0NPTVBMRVRFRBACEhoKFlFVRVNUX1NUQVRV'
    'U19DQU5DRUxMRUQQAw==');

@$core.Deprecated('Use questDescriptor instead')
const Quest$json = {
  '1': 'Quest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'shop', '3': 3, '4': 1, '5': 11, '6': '.fof.v1.Shop', '10': 'shop'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.fof.v1.QuestStatus', '10': 'status'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'completed_at', '3': 7, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `Quest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questDescriptor = $convert.base64Decode(
    'CgVRdWVzdBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiAKBHNob3'
    'AYAyABKAsyDC5mb2YudjEuU2hvcFIEc2hvcBIrCgZzdGF0dXMYBCABKA4yEy5mb2YudjEuUXVl'
    'c3RTdGF0dXNSBnN0YXR1cxIdCgpjcmVhdGVkX2F0GAUgASgJUgljcmVhdGVkQXQSHQoKdXBkYX'
    'RlZF9hdBgGIAEoCVIJdXBkYXRlZEF0EiEKDGNvbXBsZXRlZF9hdBgHIAEoCVILY29tcGxldGVk'
    'QXQ=');

@$core.Deprecated('Use startQuestRequestDescriptor instead')
const StartQuestRequest$json = {
  '1': 'StartQuestRequest',
  '2': [
    {'1': 'shop_id', '3': 1, '4': 1, '5': 9, '10': 'shopId'},
    {'1': 'lat', '3': 2, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 3, '4': 1, '5': 1, '10': 'lng'},
    {'1': 'radius_meters', '3': 4, '4': 1, '5': 1, '10': 'radiusMeters'},
    {'1': 'categories', '3': 5, '4': 3, '5': 9, '10': 'categories'},
    {'1': 'keyword', '3': 6, '4': 1, '5': 9, '10': 'keyword'},
    {'1': 'rating_filter', '3': 7, '4': 1, '5': 14, '6': '.fof.v1.QuestRatingFilter', '10': 'ratingFilter'},
    {'1': 'open_at_time', '3': 8, '4': 1, '5': 3, '10': 'openAtTime'},
    {'1': 'exclusive_independent', '3': 9, '4': 1, '5': 8, '10': 'exclusiveIndependent'},
  ],
};

/// Descriptor for `StartQuestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startQuestRequestDescriptor = $convert.base64Decode(
    'ChFTdGFydFF1ZXN0UmVxdWVzdBIXCgdzaG9wX2lkGAEgASgJUgZzaG9wSWQSEAoDbGF0GAIgAS'
    'gBUgNsYXQSEAoDbG5nGAMgASgBUgNsbmcSIwoNcmFkaXVzX21ldGVycxgEIAEoAVIMcmFkaXVz'
    'TWV0ZXJzEh4KCmNhdGVnb3JpZXMYBSADKAlSCmNhdGVnb3JpZXMSGAoHa2V5d29yZBgGIAEoCV'
    'IHa2V5d29yZBI+Cg1yYXRpbmdfZmlsdGVyGAcgASgOMhkuZm9mLnYxLlF1ZXN0UmF0aW5nRmls'
    'dGVyUgxyYXRpbmdGaWx0ZXISIAoMb3Blbl9hdF90aW1lGAggASgDUgpvcGVuQXRUaW1lEjMKFW'
    'V4Y2x1c2l2ZV9pbmRlcGVuZGVudBgJIAEoCFIUZXhjbHVzaXZlSW5kZXBlbmRlbnQ=');

@$core.Deprecated('Use startQuestResponseDescriptor instead')
const StartQuestResponse$json = {
  '1': 'StartQuestResponse',
  '2': [
    {'1': 'quest', '3': 1, '4': 1, '5': 11, '6': '.fof.v1.Quest', '10': 'quest'},
  ],
};

/// Descriptor for `StartQuestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startQuestResponseDescriptor = $convert.base64Decode(
    'ChJTdGFydFF1ZXN0UmVzcG9uc2USIwoFcXVlc3QYASABKAsyDS5mb2YudjEuUXVlc3RSBXF1ZX'
    'N0');

@$core.Deprecated('Use completeQuestRequestDescriptor instead')
const CompleteQuestRequest$json = {
  '1': 'CompleteQuestRequest',
  '2': [
    {'1': 'quest_id', '3': 1, '4': 1, '5': 9, '10': 'questId'},
  ],
};

/// Descriptor for `CompleteQuestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeQuestRequestDescriptor = $convert.base64Decode(
    'ChRDb21wbGV0ZVF1ZXN0UmVxdWVzdBIZCghxdWVzdF9pZBgBIAEoCVIHcXVlc3RJZA==');

@$core.Deprecated('Use completeQuestResponseDescriptor instead')
const CompleteQuestResponse$json = {
  '1': 'CompleteQuestResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'quest', '3': 2, '4': 1, '5': 11, '6': '.fof.v1.Quest', '10': 'quest'},
  ],
};

/// Descriptor for `CompleteQuestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeQuestResponseDescriptor = $convert.base64Decode(
    'ChVDb21wbGV0ZVF1ZXN0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIjCgVxdW'
    'VzdBgCIAEoCzINLmZvZi52MS5RdWVzdFIFcXVlc3Q=');

@$core.Deprecated('Use cancelQuestRequestDescriptor instead')
const CancelQuestRequest$json = {
  '1': 'CancelQuestRequest',
  '2': [
    {'1': 'quest_id', '3': 1, '4': 1, '5': 9, '10': 'questId'},
  ],
};

/// Descriptor for `CancelQuestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelQuestRequestDescriptor = $convert.base64Decode(
    'ChJDYW5jZWxRdWVzdFJlcXVlc3QSGQoIcXVlc3RfaWQYASABKAlSB3F1ZXN0SWQ=');

@$core.Deprecated('Use cancelQuestResponseDescriptor instead')
const CancelQuestResponse$json = {
  '1': 'CancelQuestResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'quest', '3': 2, '4': 1, '5': 11, '6': '.fof.v1.Quest', '10': 'quest'},
  ],
};

/// Descriptor for `CancelQuestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelQuestResponseDescriptor = $convert.base64Decode(
    'ChNDYW5jZWxRdWVzdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIwoFcXVlc3'
    'QYAiABKAsyDS5mb2YudjEuUXVlc3RSBXF1ZXN0');

@$core.Deprecated('Use getActiveQuestRequestDescriptor instead')
const GetActiveQuestRequest$json = {
  '1': 'GetActiveQuestRequest',
};

/// Descriptor for `GetActiveQuestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveQuestRequestDescriptor = $convert.base64Decode(
    'ChVHZXRBY3RpdmVRdWVzdFJlcXVlc3Q=');

@$core.Deprecated('Use getActiveQuestResponseDescriptor instead')
const GetActiveQuestResponse$json = {
  '1': 'GetActiveQuestResponse',
  '2': [
    {'1': 'quest', '3': 1, '4': 1, '5': 11, '6': '.fof.v1.Quest', '10': 'quest'},
    {'1': 'has_active_quest', '3': 2, '4': 1, '5': 8, '10': 'hasActiveQuest'},
  ],
};

/// Descriptor for `GetActiveQuestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveQuestResponseDescriptor = $convert.base64Decode(
    'ChZHZXRBY3RpdmVRdWVzdFJlc3BvbnNlEiMKBXF1ZXN0GAEgASgLMg0uZm9mLnYxLlF1ZXN0Ug'
    'VxdWVzdBIoChBoYXNfYWN0aXZlX3F1ZXN0GAIgASgIUg5oYXNBY3RpdmVRdWVzdA==');

@$core.Deprecated('Use getQuestHistoryRequestDescriptor instead')
const GetQuestHistoryRequest$json = {
  '1': 'GetQuestHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetQuestHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuestHistoryRequestDescriptor = $convert.base64Decode(
    'ChZHZXRRdWVzdEhpc3RvcnlSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZX'
    'QYAiABKAVSBm9mZnNldA==');

@$core.Deprecated('Use getQuestHistoryResponseDescriptor instead')
const GetQuestHistoryResponse$json = {
  '1': 'GetQuestHistoryResponse',
  '2': [
    {'1': 'quests', '3': 1, '4': 3, '5': 11, '6': '.fof.v1.Quest', '10': 'quests'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetQuestHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuestHistoryResponseDescriptor = $convert.base64Decode(
    'ChdHZXRRdWVzdEhpc3RvcnlSZXNwb25zZRIlCgZxdWVzdHMYASADKAsyDS5mb2YudjEuUXVlc3'
    'RSBnF1ZXN0cxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');


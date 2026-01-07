//
//  Generated code. Do not modify.
//  source: fof/v1/achievement.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use achievementTierDescriptor instead')
const AchievementTier$json = {
  '1': 'AchievementTier',
  '2': [
    {'1': 'ACHIEVEMENT_TIER_UNSPECIFIED', '2': 0},
    {'1': 'ACHIEVEMENT_TIER_BRONZE', '2': 1},
    {'1': 'ACHIEVEMENT_TIER_SILVER', '2': 2},
    {'1': 'ACHIEVEMENT_TIER_GOLD', '2': 3},
    {'1': 'ACHIEVEMENT_TIER_PLATINUM', '2': 4},
  ],
};

/// Descriptor for `AchievementTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List achievementTierDescriptor = $convert.base64Decode(
    'Cg9BY2hpZXZlbWVudFRpZXISIAocQUNISUVWRU1FTlRfVElFUl9VTlNQRUNJRklFRBAAEhsKF0'
    'FDSElFVkVNRU5UX1RJRVJfQlJPTlpFEAESGwoXQUNISUVWRU1FTlRfVElFUl9TSUxWRVIQAhIZ'
    'ChVBQ0hJRVZFTUVOVF9USUVSX0dPTEQQAxIdChlBQ0hJRVZFTUVOVF9USUVSX1BMQVRJTlVNEA'
    'Q=');

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
    {'1': 'tier', '3': 7, '4': 1, '5': 14, '6': '.fof.v1.AchievementTier', '10': 'tier'},
  ],
};

/// Descriptor for `Achievement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List achievementDescriptor = $convert.base64Decode(
    'CgtBY2hpZXZlbWVudBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZX'
    'NjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHQoKZXhwX3Jld2FyZBgEIAEoBVIJZXhwUmV3'
    'YXJkEiEKDHRpdGxlX3Jld2FyZBgFIAEoCVILdGl0bGVSZXdhcmQSGgoIY2F0ZWdvcnkYBiABKA'
    'lSCGNhdGVnb3J5EisKBHRpZXIYByABKA4yFy5mb2YudjEuQWNoaWV2ZW1lbnRUaWVyUgR0aWVy');

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


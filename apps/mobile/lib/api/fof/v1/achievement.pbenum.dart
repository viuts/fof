//
//  Generated code. Do not modify.
//  source: fof/v1/achievement.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AchievementTier extends $pb.ProtobufEnum {
  static const AchievementTier ACHIEVEMENT_TIER_UNSPECIFIED = AchievementTier._(0, _omitEnumNames ? '' : 'ACHIEVEMENT_TIER_UNSPECIFIED');
  static const AchievementTier ACHIEVEMENT_TIER_BRONZE = AchievementTier._(1, _omitEnumNames ? '' : 'ACHIEVEMENT_TIER_BRONZE');
  static const AchievementTier ACHIEVEMENT_TIER_SILVER = AchievementTier._(2, _omitEnumNames ? '' : 'ACHIEVEMENT_TIER_SILVER');
  static const AchievementTier ACHIEVEMENT_TIER_GOLD = AchievementTier._(3, _omitEnumNames ? '' : 'ACHIEVEMENT_TIER_GOLD');
  static const AchievementTier ACHIEVEMENT_TIER_PLATINUM = AchievementTier._(4, _omitEnumNames ? '' : 'ACHIEVEMENT_TIER_PLATINUM');

  static const $core.List<AchievementTier> values = <AchievementTier> [
    ACHIEVEMENT_TIER_UNSPECIFIED,
    ACHIEVEMENT_TIER_BRONZE,
    ACHIEVEMENT_TIER_SILVER,
    ACHIEVEMENT_TIER_GOLD,
    ACHIEVEMENT_TIER_PLATINUM,
  ];

  static final $core.Map<$core.int, AchievementTier> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AchievementTier? valueOf($core.int value) => _byValue[value];

  const AchievementTier._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');

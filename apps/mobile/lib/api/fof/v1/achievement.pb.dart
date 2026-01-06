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

class Achievement extends $pb.GeneratedMessage {
  factory Achievement({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.int? expReward,
    $core.String? titleReward,
    $core.String? category,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (expReward != null) {
      $result.expReward = expReward;
    }
    if (titleReward != null) {
      $result.titleReward = titleReward;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  Achievement._() : super();
  factory Achievement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Achievement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Achievement', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'expReward', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'titleReward')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Achievement clone() => Achievement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Achievement copyWith(void Function(Achievement) updates) => super.copyWith((message) => updates(message as Achievement)) as Achievement;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Achievement create() => Achievement._();
  Achievement createEmptyInstance() => create();
  static $pb.PbList<Achievement> createRepeated() => $pb.PbList<Achievement>();
  @$core.pragma('dart2js:noInline')
  static Achievement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Achievement>(create);
  static Achievement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get expReward => $_getIZ(3);
  @$pb.TagNumber(4)
  set expReward($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpReward() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpReward() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get titleReward => $_getSZ(4);
  @$pb.TagNumber(5)
  set titleReward($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTitleReward() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitleReward() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);
}

class GetAchievementsRequest extends $pb.GeneratedMessage {
  factory GetAchievementsRequest() => create();
  GetAchievementsRequest._() : super();
  factory GetAchievementsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAchievementsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAchievementsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAchievementsRequest clone() => GetAchievementsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAchievementsRequest copyWith(void Function(GetAchievementsRequest) updates) => super.copyWith((message) => updates(message as GetAchievementsRequest)) as GetAchievementsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAchievementsRequest create() => GetAchievementsRequest._();
  GetAchievementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAchievementsRequest> createRepeated() => $pb.PbList<GetAchievementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAchievementsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAchievementsRequest>(create);
  static GetAchievementsRequest? _defaultInstance;
}

class GetAchievementsResponse extends $pb.GeneratedMessage {
  factory GetAchievementsResponse({
    $core.Iterable<UserAchievementStatus>? achievements,
  }) {
    final $result = create();
    if (achievements != null) {
      $result.achievements.addAll(achievements);
    }
    return $result;
  }
  GetAchievementsResponse._() : super();
  factory GetAchievementsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAchievementsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAchievementsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..pc<UserAchievementStatus>(1, _omitFieldNames ? '' : 'achievements', $pb.PbFieldType.PM, subBuilder: UserAchievementStatus.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAchievementsResponse clone() => GetAchievementsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAchievementsResponse copyWith(void Function(GetAchievementsResponse) updates) => super.copyWith((message) => updates(message as GetAchievementsResponse)) as GetAchievementsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAchievementsResponse create() => GetAchievementsResponse._();
  GetAchievementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAchievementsResponse> createRepeated() => $pb.PbList<GetAchievementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAchievementsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAchievementsResponse>(create);
  static GetAchievementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserAchievementStatus> get achievements => $_getList(0);
}

class UserAchievementStatus extends $pb.GeneratedMessage {
  factory UserAchievementStatus({
    Achievement? achievement,
    $core.bool? isUnlocked,
    $core.int? currentValue,
    $core.int? targetValue,
    $core.String? unlockedAt,
  }) {
    final $result = create();
    if (achievement != null) {
      $result.achievement = achievement;
    }
    if (isUnlocked != null) {
      $result.isUnlocked = isUnlocked;
    }
    if (currentValue != null) {
      $result.currentValue = currentValue;
    }
    if (targetValue != null) {
      $result.targetValue = targetValue;
    }
    if (unlockedAt != null) {
      $result.unlockedAt = unlockedAt;
    }
    return $result;
  }
  UserAchievementStatus._() : super();
  factory UserAchievementStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAchievementStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserAchievementStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOM<Achievement>(1, _omitFieldNames ? '' : 'achievement', subBuilder: Achievement.create)
    ..aOB(2, _omitFieldNames ? '' : 'isUnlocked')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'unlockedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserAchievementStatus clone() => UserAchievementStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserAchievementStatus copyWith(void Function(UserAchievementStatus) updates) => super.copyWith((message) => updates(message as UserAchievementStatus)) as UserAchievementStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserAchievementStatus create() => UserAchievementStatus._();
  UserAchievementStatus createEmptyInstance() => create();
  static $pb.PbList<UserAchievementStatus> createRepeated() => $pb.PbList<UserAchievementStatus>();
  @$core.pragma('dart2js:noInline')
  static UserAchievementStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserAchievementStatus>(create);
  static UserAchievementStatus? _defaultInstance;

  @$pb.TagNumber(1)
  Achievement get achievement => $_getN(0);
  @$pb.TagNumber(1)
  set achievement(Achievement v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAchievement() => $_has(0);
  @$pb.TagNumber(1)
  void clearAchievement() => clearField(1);
  @$pb.TagNumber(1)
  Achievement ensureAchievement() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get isUnlocked => $_getBF(1);
  @$pb.TagNumber(2)
  set isUnlocked($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsUnlocked() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsUnlocked() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get currentValue => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentValue($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get targetValue => $_getIZ(3);
  @$pb.TagNumber(4)
  set targetValue($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetValue() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get unlockedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set unlockedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnlockedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnlockedAt() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

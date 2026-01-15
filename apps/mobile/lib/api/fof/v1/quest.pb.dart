//
//  Generated code. Do not modify.
//  source: fof/v1/quest.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'quest.pbenum.dart';
import 'shop.pb.dart' as $2;
import 'shop.pbenum.dart' as $2;

export 'quest.pbenum.dart';

/// Quest message
class Quest extends $pb.GeneratedMessage {
  factory Quest({
    $core.String? id,
    $core.String? userId,
    $2.Shop? shop,
    QuestStatus? status,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? completedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (shop != null) {
      $result.shop = shop;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    return $result;
  }
  Quest._() : super();
  factory Quest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Quest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Quest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<$2.Shop>(3, _omitFieldNames ? '' : 'shop', subBuilder: $2.Shop.create)
    ..e<QuestStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: QuestStatus.QUEST_STATUS_UNSPECIFIED, valueOf: QuestStatus.valueOf, enumValues: QuestStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'createdAt')
    ..aOS(6, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(7, _omitFieldNames ? '' : 'completedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Quest clone() => Quest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Quest copyWith(void Function(Quest) updates) => super.copyWith((message) => updates(message as Quest)) as Quest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Quest create() => Quest._();
  Quest createEmptyInstance() => create();
  static $pb.PbList<Quest> createRepeated() => $pb.PbList<Quest>();
  @$core.pragma('dart2js:noInline')
  static Quest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Quest>(create);
  static Quest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $2.Shop get shop => $_getN(2);
  @$pb.TagNumber(3)
  set shop($2.Shop v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasShop() => $_has(2);
  @$pb.TagNumber(3)
  void clearShop() => clearField(3);
  @$pb.TagNumber(3)
  $2.Shop ensureShop() => $_ensure(2);

  @$pb.TagNumber(4)
  QuestStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(QuestStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get updatedAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set updatedAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get completedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set completedAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCompletedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletedAt() => clearField(7);
}

/// Start quest request and response
class StartQuestRequest extends $pb.GeneratedMessage {
  factory StartQuestRequest({
    $core.String? shopId,
    $core.double? lat,
    $core.double? lng,
    $core.double? radiusMeters,
    $core.Iterable<$core.String>? categories,
    $core.String? keyword,
    $2.QuestRatingFilter? ratingFilter,
    $fixnum.Int64? openAtTime,
    $core.bool? exclusiveIndependent,
  }) {
    final $result = create();
    if (shopId != null) {
      $result.shopId = shopId;
    }
    if (lat != null) {
      $result.lat = lat;
    }
    if (lng != null) {
      $result.lng = lng;
    }
    if (radiusMeters != null) {
      $result.radiusMeters = radiusMeters;
    }
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    if (keyword != null) {
      $result.keyword = keyword;
    }
    if (ratingFilter != null) {
      $result.ratingFilter = ratingFilter;
    }
    if (openAtTime != null) {
      $result.openAtTime = openAtTime;
    }
    if (exclusiveIndependent != null) {
      $result.exclusiveIndependent = exclusiveIndependent;
    }
    return $result;
  }
  StartQuestRequest._() : super();
  factory StartQuestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartQuestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartQuestRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shopId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'radiusMeters', $pb.PbFieldType.OD)
    ..pPS(5, _omitFieldNames ? '' : 'categories')
    ..aOS(6, _omitFieldNames ? '' : 'keyword')
    ..e<$2.QuestRatingFilter>(7, _omitFieldNames ? '' : 'ratingFilter', $pb.PbFieldType.OE, defaultOrMaker: $2.QuestRatingFilter.QUEST_RATING_FILTER_UNSPECIFIED, valueOf: $2.QuestRatingFilter.valueOf, enumValues: $2.QuestRatingFilter.values)
    ..aInt64(8, _omitFieldNames ? '' : 'openAtTime')
    ..aOB(9, _omitFieldNames ? '' : 'exclusiveIndependent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartQuestRequest clone() => StartQuestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartQuestRequest copyWith(void Function(StartQuestRequest) updates) => super.copyWith((message) => updates(message as StartQuestRequest)) as StartQuestRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartQuestRequest create() => StartQuestRequest._();
  StartQuestRequest createEmptyInstance() => create();
  static $pb.PbList<StartQuestRequest> createRepeated() => $pb.PbList<StartQuestRequest>();
  @$core.pragma('dart2js:noInline')
  static StartQuestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartQuestRequest>(create);
  static StartQuestRequest? _defaultInstance;

  /// Optional: if provided, start quest with this specific shop ID
  @$pb.TagNumber(1)
  $core.String get shopId => $_getSZ(0);
  @$pb.TagNumber(1)
  set shopId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShopId() => $_has(0);
  @$pb.TagNumber(1)
  void clearShopId() => clearField(1);

  /// Quest shop search filters (used if shop_id is not provided)
  @$pb.TagNumber(2)
  $core.double get lat => $_getN(1);
  @$pb.TagNumber(2)
  set lat($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLat() => $_has(1);
  @$pb.TagNumber(2)
  void clearLat() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get lng => $_getN(2);
  @$pb.TagNumber(3)
  set lng($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLng() => $_has(2);
  @$pb.TagNumber(3)
  void clearLng() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get radiusMeters => $_getN(3);
  @$pb.TagNumber(4)
  set radiusMeters($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRadiusMeters() => $_has(3);
  @$pb.TagNumber(4)
  void clearRadiusMeters() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get categories => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get keyword => $_getSZ(5);
  @$pb.TagNumber(6)
  set keyword($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasKeyword() => $_has(5);
  @$pb.TagNumber(6)
  void clearKeyword() => clearField(6);

  @$pb.TagNumber(7)
  $2.QuestRatingFilter get ratingFilter => $_getN(6);
  @$pb.TagNumber(7)
  set ratingFilter($2.QuestRatingFilter v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRatingFilter() => $_has(6);
  @$pb.TagNumber(7)
  void clearRatingFilter() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get openAtTime => $_getI64(7);
  @$pb.TagNumber(8)
  set openAtTime($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOpenAtTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearOpenAtTime() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get exclusiveIndependent => $_getBF(8);
  @$pb.TagNumber(9)
  set exclusiveIndependent($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasExclusiveIndependent() => $_has(8);
  @$pb.TagNumber(9)
  void clearExclusiveIndependent() => clearField(9);
}

class StartQuestResponse extends $pb.GeneratedMessage {
  factory StartQuestResponse({
    Quest? quest,
  }) {
    final $result = create();
    if (quest != null) {
      $result.quest = quest;
    }
    return $result;
  }
  StartQuestResponse._() : super();
  factory StartQuestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartQuestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StartQuestResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOM<Quest>(1, _omitFieldNames ? '' : 'quest', subBuilder: Quest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartQuestResponse clone() => StartQuestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartQuestResponse copyWith(void Function(StartQuestResponse) updates) => super.copyWith((message) => updates(message as StartQuestResponse)) as StartQuestResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartQuestResponse create() => StartQuestResponse._();
  StartQuestResponse createEmptyInstance() => create();
  static $pb.PbList<StartQuestResponse> createRepeated() => $pb.PbList<StartQuestResponse>();
  @$core.pragma('dart2js:noInline')
  static StartQuestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartQuestResponse>(create);
  static StartQuestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Quest get quest => $_getN(0);
  @$pb.TagNumber(1)
  set quest(Quest v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuest() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuest() => clearField(1);
  @$pb.TagNumber(1)
  Quest ensureQuest() => $_ensure(0);
}

/// Complete quest request and response
class CompleteQuestRequest extends $pb.GeneratedMessage {
  factory CompleteQuestRequest({
    $core.String? questId,
  }) {
    final $result = create();
    if (questId != null) {
      $result.questId = questId;
    }
    return $result;
  }
  CompleteQuestRequest._() : super();
  factory CompleteQuestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteQuestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompleteQuestRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'questId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteQuestRequest clone() => CompleteQuestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteQuestRequest copyWith(void Function(CompleteQuestRequest) updates) => super.copyWith((message) => updates(message as CompleteQuestRequest)) as CompleteQuestRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteQuestRequest create() => CompleteQuestRequest._();
  CompleteQuestRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteQuestRequest> createRepeated() => $pb.PbList<CompleteQuestRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteQuestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteQuestRequest>(create);
  static CompleteQuestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get questId => $_getSZ(0);
  @$pb.TagNumber(1)
  set questId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuestId() => clearField(1);
}

class CompleteQuestResponse extends $pb.GeneratedMessage {
  factory CompleteQuestResponse({
    $core.bool? success,
    Quest? quest,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (quest != null) {
      $result.quest = quest;
    }
    return $result;
  }
  CompleteQuestResponse._() : super();
  factory CompleteQuestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteQuestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompleteQuestResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<Quest>(2, _omitFieldNames ? '' : 'quest', subBuilder: Quest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteQuestResponse clone() => CompleteQuestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteQuestResponse copyWith(void Function(CompleteQuestResponse) updates) => super.copyWith((message) => updates(message as CompleteQuestResponse)) as CompleteQuestResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteQuestResponse create() => CompleteQuestResponse._();
  CompleteQuestResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteQuestResponse> createRepeated() => $pb.PbList<CompleteQuestResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteQuestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteQuestResponse>(create);
  static CompleteQuestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  Quest get quest => $_getN(1);
  @$pb.TagNumber(2)
  set quest(Quest v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuest() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuest() => clearField(2);
  @$pb.TagNumber(2)
  Quest ensureQuest() => $_ensure(1);
}

/// Cancel quest request and response
class CancelQuestRequest extends $pb.GeneratedMessage {
  factory CancelQuestRequest({
    $core.String? questId,
  }) {
    final $result = create();
    if (questId != null) {
      $result.questId = questId;
    }
    return $result;
  }
  CancelQuestRequest._() : super();
  factory CancelQuestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelQuestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelQuestRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'questId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelQuestRequest clone() => CancelQuestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelQuestRequest copyWith(void Function(CancelQuestRequest) updates) => super.copyWith((message) => updates(message as CancelQuestRequest)) as CancelQuestRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelQuestRequest create() => CancelQuestRequest._();
  CancelQuestRequest createEmptyInstance() => create();
  static $pb.PbList<CancelQuestRequest> createRepeated() => $pb.PbList<CancelQuestRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelQuestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelQuestRequest>(create);
  static CancelQuestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get questId => $_getSZ(0);
  @$pb.TagNumber(1)
  set questId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuestId() => clearField(1);
}

class CancelQuestResponse extends $pb.GeneratedMessage {
  factory CancelQuestResponse({
    $core.bool? success,
    Quest? quest,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (quest != null) {
      $result.quest = quest;
    }
    return $result;
  }
  CancelQuestResponse._() : super();
  factory CancelQuestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelQuestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelQuestResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<Quest>(2, _omitFieldNames ? '' : 'quest', subBuilder: Quest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelQuestResponse clone() => CancelQuestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelQuestResponse copyWith(void Function(CancelQuestResponse) updates) => super.copyWith((message) => updates(message as CancelQuestResponse)) as CancelQuestResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelQuestResponse create() => CancelQuestResponse._();
  CancelQuestResponse createEmptyInstance() => create();
  static $pb.PbList<CancelQuestResponse> createRepeated() => $pb.PbList<CancelQuestResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelQuestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelQuestResponse>(create);
  static CancelQuestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  Quest get quest => $_getN(1);
  @$pb.TagNumber(2)
  set quest(Quest v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuest() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuest() => clearField(2);
  @$pb.TagNumber(2)
  Quest ensureQuest() => $_ensure(1);
}

/// Get active quest request and response
class GetActiveQuestRequest extends $pb.GeneratedMessage {
  factory GetActiveQuestRequest() => create();
  GetActiveQuestRequest._() : super();
  factory GetActiveQuestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetActiveQuestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetActiveQuestRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetActiveQuestRequest clone() => GetActiveQuestRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetActiveQuestRequest copyWith(void Function(GetActiveQuestRequest) updates) => super.copyWith((message) => updates(message as GetActiveQuestRequest)) as GetActiveQuestRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActiveQuestRequest create() => GetActiveQuestRequest._();
  GetActiveQuestRequest createEmptyInstance() => create();
  static $pb.PbList<GetActiveQuestRequest> createRepeated() => $pb.PbList<GetActiveQuestRequest>();
  @$core.pragma('dart2js:noInline')
  static GetActiveQuestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetActiveQuestRequest>(create);
  static GetActiveQuestRequest? _defaultInstance;
}

class GetActiveQuestResponse extends $pb.GeneratedMessage {
  factory GetActiveQuestResponse({
    Quest? quest,
    $core.bool? hasActiveQuest,
  }) {
    final $result = create();
    if (quest != null) {
      $result.quest = quest;
    }
    if (hasActiveQuest != null) {
      $result.hasActiveQuest = hasActiveQuest;
    }
    return $result;
  }
  GetActiveQuestResponse._() : super();
  factory GetActiveQuestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetActiveQuestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetActiveQuestResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOM<Quest>(1, _omitFieldNames ? '' : 'quest', subBuilder: Quest.create)
    ..aOB(2, _omitFieldNames ? '' : 'hasActiveQuest')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetActiveQuestResponse clone() => GetActiveQuestResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetActiveQuestResponse copyWith(void Function(GetActiveQuestResponse) updates) => super.copyWith((message) => updates(message as GetActiveQuestResponse)) as GetActiveQuestResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActiveQuestResponse create() => GetActiveQuestResponse._();
  GetActiveQuestResponse createEmptyInstance() => create();
  static $pb.PbList<GetActiveQuestResponse> createRepeated() => $pb.PbList<GetActiveQuestResponse>();
  @$core.pragma('dart2js:noInline')
  static GetActiveQuestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetActiveQuestResponse>(create);
  static GetActiveQuestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Quest get quest => $_getN(0);
  @$pb.TagNumber(1)
  set quest(Quest v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuest() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuest() => clearField(1);
  @$pb.TagNumber(1)
  Quest ensureQuest() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get hasActiveQuest => $_getBF(1);
  @$pb.TagNumber(2)
  set hasActiveQuest($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasActiveQuest() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasActiveQuest() => clearField(2);
}

/// Get quest history request and response
class GetQuestHistoryRequest extends $pb.GeneratedMessage {
  factory GetQuestHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetQuestHistoryRequest._() : super();
  factory GetQuestHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQuestHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQuestHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQuestHistoryRequest clone() => GetQuestHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQuestHistoryRequest copyWith(void Function(GetQuestHistoryRequest) updates) => super.copyWith((message) => updates(message as GetQuestHistoryRequest)) as GetQuestHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuestHistoryRequest create() => GetQuestHistoryRequest._();
  GetQuestHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetQuestHistoryRequest> createRepeated() => $pb.PbList<GetQuestHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQuestHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQuestHistoryRequest>(create);
  static GetQuestHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetQuestHistoryResponse extends $pb.GeneratedMessage {
  factory GetQuestHistoryResponse({
    $core.Iterable<Quest>? quests,
    $core.int? total,
  }) {
    final $result = create();
    if (quests != null) {
      $result.quests.addAll(quests);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetQuestHistoryResponse._() : super();
  factory GetQuestHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQuestHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQuestHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..pc<Quest>(1, _omitFieldNames ? '' : 'quests', $pb.PbFieldType.PM, subBuilder: Quest.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQuestHistoryResponse clone() => GetQuestHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQuestHistoryResponse copyWith(void Function(GetQuestHistoryResponse) updates) => super.copyWith((message) => updates(message as GetQuestHistoryResponse)) as GetQuestHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuestHistoryResponse create() => GetQuestHistoryResponse._();
  GetQuestHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetQuestHistoryResponse> createRepeated() => $pb.PbList<GetQuestHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetQuestHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQuestHistoryResponse>(create);
  static GetQuestHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Quest> get quests => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

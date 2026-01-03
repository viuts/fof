//
//  Generated code. Do not modify.
//  source: fof/v1/fof.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LatLng extends $pb.GeneratedMessage {
  factory LatLng({
    $core.double? lat,
    $core.double? lng,
  }) {
    final $result = create();
    if (lat != null) {
      $result.lat = lat;
    }
    if (lng != null) {
      $result.lng = lng;
    }
    return $result;
  }
  LatLng._() : super();
  factory LatLng.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LatLng.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LatLng', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LatLng clone() => LatLng()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LatLng copyWith(void Function(LatLng) updates) => super.copyWith((message) => updates(message as LatLng)) as LatLng;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LatLng create() => LatLng._();
  LatLng createEmptyInstance() => create();
  static $pb.PbList<LatLng> createRepeated() => $pb.PbList<LatLng>();
  @$core.pragma('dart2js:noInline')
  static LatLng getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LatLng>(create);
  static LatLng? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => clearField(2);
}

class GetClearedAreaRequest extends $pb.GeneratedMessage {
  factory GetClearedAreaRequest() => create();
  GetClearedAreaRequest._() : super();
  factory GetClearedAreaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClearedAreaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetClearedAreaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetClearedAreaRequest clone() => GetClearedAreaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetClearedAreaRequest copyWith(void Function(GetClearedAreaRequest) updates) => super.copyWith((message) => updates(message as GetClearedAreaRequest)) as GetClearedAreaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetClearedAreaRequest create() => GetClearedAreaRequest._();
  GetClearedAreaRequest createEmptyInstance() => create();
  static $pb.PbList<GetClearedAreaRequest> createRepeated() => $pb.PbList<GetClearedAreaRequest>();
  @$core.pragma('dart2js:noInline')
  static GetClearedAreaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetClearedAreaRequest>(create);
  static GetClearedAreaRequest? _defaultInstance;
}

class GetClearedAreaResponse extends $pb.GeneratedMessage {
  factory GetClearedAreaResponse({
    $core.String? clearedAreaGeojson,
  }) {
    final $result = create();
    if (clearedAreaGeojson != null) {
      $result.clearedAreaGeojson = clearedAreaGeojson;
    }
    return $result;
  }
  GetClearedAreaResponse._() : super();
  factory GetClearedAreaResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClearedAreaResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetClearedAreaResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clearedAreaGeojson')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetClearedAreaResponse clone() => GetClearedAreaResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetClearedAreaResponse copyWith(void Function(GetClearedAreaResponse) updates) => super.copyWith((message) => updates(message as GetClearedAreaResponse)) as GetClearedAreaResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetClearedAreaResponse create() => GetClearedAreaResponse._();
  GetClearedAreaResponse createEmptyInstance() => create();
  static $pb.PbList<GetClearedAreaResponse> createRepeated() => $pb.PbList<GetClearedAreaResponse>();
  @$core.pragma('dart2js:noInline')
  static GetClearedAreaResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetClearedAreaResponse>(create);
  static GetClearedAreaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clearedAreaGeojson => $_getSZ(0);
  @$pb.TagNumber(1)
  set clearedAreaGeojson($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClearedAreaGeojson() => $_has(0);
  @$pb.TagNumber(1)
  void clearClearedAreaGeojson() => clearField(1);
}

class CreateVisitRequest extends $pb.GeneratedMessage {
  factory CreateVisitRequest({
    $core.String? shopId,
    $core.int? rating,
    $core.String? comment,
  }) {
    final $result = create();
    if (shopId != null) {
      $result.shopId = shopId;
    }
    if (rating != null) {
      $result.rating = rating;
    }
    if (comment != null) {
      $result.comment = comment;
    }
    return $result;
  }
  CreateVisitRequest._() : super();
  factory CreateVisitRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVisitRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateVisitRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shopId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVisitRequest clone() => CreateVisitRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVisitRequest copyWith(void Function(CreateVisitRequest) updates) => super.copyWith((message) => updates(message as CreateVisitRequest)) as CreateVisitRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVisitRequest create() => CreateVisitRequest._();
  CreateVisitRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVisitRequest> createRepeated() => $pb.PbList<CreateVisitRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVisitRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVisitRequest>(create);
  static CreateVisitRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shopId => $_getSZ(0);
  @$pb.TagNumber(1)
  set shopId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShopId() => $_has(0);
  @$pb.TagNumber(1)
  void clearShopId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get rating => $_getIZ(1);
  @$pb.TagNumber(2)
  set rating($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRating() => $_has(1);
  @$pb.TagNumber(2)
  void clearRating() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get comment => $_getSZ(2);
  @$pb.TagNumber(3)
  set comment($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasComment() => $_has(2);
  @$pb.TagNumber(3)
  void clearComment() => clearField(3);
}

class CreateVisitResponse extends $pb.GeneratedMessage {
  factory CreateVisitResponse({
    $core.bool? success,
    $core.String? clearedAreaGeojson,
    $core.int? expGained,
    $core.int? currentExp,
    $core.int? currentLevel,
    $core.Iterable<Achievement>? unlockedAchievements,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (clearedAreaGeojson != null) {
      $result.clearedAreaGeojson = clearedAreaGeojson;
    }
    if (expGained != null) {
      $result.expGained = expGained;
    }
    if (currentExp != null) {
      $result.currentExp = currentExp;
    }
    if (currentLevel != null) {
      $result.currentLevel = currentLevel;
    }
    if (unlockedAchievements != null) {
      $result.unlockedAchievements.addAll(unlockedAchievements);
    }
    return $result;
  }
  CreateVisitResponse._() : super();
  factory CreateVisitResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateVisitResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateVisitResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'clearedAreaGeojson')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expGained', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'currentExp', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'currentLevel', $pb.PbFieldType.O3)
    ..pc<Achievement>(6, _omitFieldNames ? '' : 'unlockedAchievements', $pb.PbFieldType.PM, subBuilder: Achievement.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateVisitResponse clone() => CreateVisitResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateVisitResponse copyWith(void Function(CreateVisitResponse) updates) => super.copyWith((message) => updates(message as CreateVisitResponse)) as CreateVisitResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVisitResponse create() => CreateVisitResponse._();
  CreateVisitResponse createEmptyInstance() => create();
  static $pb.PbList<CreateVisitResponse> createRepeated() => $pb.PbList<CreateVisitResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateVisitResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateVisitResponse>(create);
  static CreateVisitResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get clearedAreaGeojson => $_getSZ(1);
  @$pb.TagNumber(2)
  set clearedAreaGeojson($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClearedAreaGeojson() => $_has(1);
  @$pb.TagNumber(2)
  void clearClearedAreaGeojson() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get expGained => $_getIZ(2);
  @$pb.TagNumber(3)
  set expGained($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpGained() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpGained() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentExp => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentExp($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentExp() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentExp() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get currentLevel => $_getIZ(4);
  @$pb.TagNumber(5)
  set currentLevel($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentLevel() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentLevel() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<Achievement> get unlockedAchievements => $_getList(5);
}

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

class UpdateLocationRequest extends $pb.GeneratedMessage {
  factory UpdateLocationRequest({
    $core.Iterable<LatLng>? path,
    $core.double? accuracy,
  }) {
    final $result = create();
    if (path != null) {
      $result.path.addAll(path);
    }
    if (accuracy != null) {
      $result.accuracy = accuracy;
    }
    return $result;
  }
  UpdateLocationRequest._() : super();
  factory UpdateLocationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLocationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLocationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..pc<LatLng>(1, _omitFieldNames ? '' : 'path', $pb.PbFieldType.PM, subBuilder: LatLng.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'accuracy', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLocationRequest clone() => UpdateLocationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLocationRequest copyWith(void Function(UpdateLocationRequest) updates) => super.copyWith((message) => updates(message as UpdateLocationRequest)) as UpdateLocationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLocationRequest create() => UpdateLocationRequest._();
  UpdateLocationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateLocationRequest> createRepeated() => $pb.PbList<UpdateLocationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateLocationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLocationRequest>(create);
  static UpdateLocationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LatLng> get path => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get accuracy => $_getN(1);
  @$pb.TagNumber(2)
  set accuracy($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccuracy() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccuracy() => clearField(2);
}

class UpdateLocationResponse extends $pb.GeneratedMessage {
  factory UpdateLocationResponse({
    $core.bool? newlyCleared,
    $core.String? clearedAreaGeojson,
  }) {
    final $result = create();
    if (newlyCleared != null) {
      $result.newlyCleared = newlyCleared;
    }
    if (clearedAreaGeojson != null) {
      $result.clearedAreaGeojson = clearedAreaGeojson;
    }
    return $result;
  }
  UpdateLocationResponse._() : super();
  factory UpdateLocationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLocationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLocationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'newlyCleared')
    ..aOS(2, _omitFieldNames ? '' : 'clearedAreaGeojson')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLocationResponse clone() => UpdateLocationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLocationResponse copyWith(void Function(UpdateLocationResponse) updates) => super.copyWith((message) => updates(message as UpdateLocationResponse)) as UpdateLocationResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLocationResponse create() => UpdateLocationResponse._();
  UpdateLocationResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateLocationResponse> createRepeated() => $pb.PbList<UpdateLocationResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateLocationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLocationResponse>(create);
  static UpdateLocationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get newlyCleared => $_getBF(0);
  @$pb.TagNumber(1)
  set newlyCleared($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNewlyCleared() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewlyCleared() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get clearedAreaGeojson => $_getSZ(1);
  @$pb.TagNumber(2)
  set clearedAreaGeojson($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClearedAreaGeojson() => $_has(1);
  @$pb.TagNumber(2)
  void clearClearedAreaGeojson() => clearField(2);
}

class GetNearbyShopsRequest extends $pb.GeneratedMessage {
  factory GetNearbyShopsRequest({
    $core.double? lat,
    $core.double? lng,
    $core.double? radiusMeters,
    $core.bool? exclusiveIndependent,
  }) {
    final $result = create();
    if (lat != null) {
      $result.lat = lat;
    }
    if (lng != null) {
      $result.lng = lng;
    }
    if (radiusMeters != null) {
      $result.radiusMeters = radiusMeters;
    }
    if (exclusiveIndependent != null) {
      $result.exclusiveIndependent = exclusiveIndependent;
    }
    return $result;
  }
  GetNearbyShopsRequest._() : super();
  factory GetNearbyShopsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNearbyShopsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNearbyShopsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'radiusMeters', $pb.PbFieldType.OD)
    ..aOB(4, _omitFieldNames ? '' : 'exclusiveIndependent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNearbyShopsRequest clone() => GetNearbyShopsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNearbyShopsRequest copyWith(void Function(GetNearbyShopsRequest) updates) => super.copyWith((message) => updates(message as GetNearbyShopsRequest)) as GetNearbyShopsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNearbyShopsRequest create() => GetNearbyShopsRequest._();
  GetNearbyShopsRequest createEmptyInstance() => create();
  static $pb.PbList<GetNearbyShopsRequest> createRepeated() => $pb.PbList<GetNearbyShopsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNearbyShopsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNearbyShopsRequest>(create);
  static GetNearbyShopsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get radiusMeters => $_getN(2);
  @$pb.TagNumber(3)
  set radiusMeters($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRadiusMeters() => $_has(2);
  @$pb.TagNumber(3)
  void clearRadiusMeters() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get exclusiveIndependent => $_getBF(3);
  @$pb.TagNumber(4)
  set exclusiveIndependent($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExclusiveIndependent() => $_has(3);
  @$pb.TagNumber(4)
  void clearExclusiveIndependent() => clearField(4);
}

class GetNearbyShopsResponse extends $pb.GeneratedMessage {
  factory GetNearbyShopsResponse({
    $core.Iterable<Shop>? shops,
  }) {
    final $result = create();
    if (shops != null) {
      $result.shops.addAll(shops);
    }
    return $result;
  }
  GetNearbyShopsResponse._() : super();
  factory GetNearbyShopsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNearbyShopsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNearbyShopsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..pc<Shop>(1, _omitFieldNames ? '' : 'shops', $pb.PbFieldType.PM, subBuilder: Shop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNearbyShopsResponse clone() => GetNearbyShopsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNearbyShopsResponse copyWith(void Function(GetNearbyShopsResponse) updates) => super.copyWith((message) => updates(message as GetNearbyShopsResponse)) as GetNearbyShopsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNearbyShopsResponse create() => GetNearbyShopsResponse._();
  GetNearbyShopsResponse createEmptyInstance() => create();
  static $pb.PbList<GetNearbyShopsResponse> createRepeated() => $pb.PbList<GetNearbyShopsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNearbyShopsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNearbyShopsResponse>(create);
  static GetNearbyShopsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Shop> get shops => $_getList(0);
}

class GetVisitedShopsRequest extends $pb.GeneratedMessage {
  factory GetVisitedShopsRequest() => create();
  GetVisitedShopsRequest._() : super();
  factory GetVisitedShopsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVisitedShopsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVisitedShopsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVisitedShopsRequest clone() => GetVisitedShopsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVisitedShopsRequest copyWith(void Function(GetVisitedShopsRequest) updates) => super.copyWith((message) => updates(message as GetVisitedShopsRequest)) as GetVisitedShopsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVisitedShopsRequest create() => GetVisitedShopsRequest._();
  GetVisitedShopsRequest createEmptyInstance() => create();
  static $pb.PbList<GetVisitedShopsRequest> createRepeated() => $pb.PbList<GetVisitedShopsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVisitedShopsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVisitedShopsRequest>(create);
  static GetVisitedShopsRequest? _defaultInstance;
}

class GetVisitedShopsResponse extends $pb.GeneratedMessage {
  factory GetVisitedShopsResponse({
    $core.Iterable<VisitedShop>? visitedShops,
  }) {
    final $result = create();
    if (visitedShops != null) {
      $result.visitedShops.addAll(visitedShops);
    }
    return $result;
  }
  GetVisitedShopsResponse._() : super();
  factory GetVisitedShopsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVisitedShopsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVisitedShopsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..pc<VisitedShop>(1, _omitFieldNames ? '' : 'visitedShops', $pb.PbFieldType.PM, subBuilder: VisitedShop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVisitedShopsResponse clone() => GetVisitedShopsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVisitedShopsResponse copyWith(void Function(GetVisitedShopsResponse) updates) => super.copyWith((message) => updates(message as GetVisitedShopsResponse)) as GetVisitedShopsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVisitedShopsResponse create() => GetVisitedShopsResponse._();
  GetVisitedShopsResponse createEmptyInstance() => create();
  static $pb.PbList<GetVisitedShopsResponse> createRepeated() => $pb.PbList<GetVisitedShopsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVisitedShopsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVisitedShopsResponse>(create);
  static GetVisitedShopsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<VisitedShop> get visitedShops => $_getList(0);
}

class VisitedShop extends $pb.GeneratedMessage {
  factory VisitedShop({
    Shop? shop,
    $core.String? visitedAt,
    $core.int? rating,
    $core.String? comment,
  }) {
    final $result = create();
    if (shop != null) {
      $result.shop = shop;
    }
    if (visitedAt != null) {
      $result.visitedAt = visitedAt;
    }
    if (rating != null) {
      $result.rating = rating;
    }
    if (comment != null) {
      $result.comment = comment;
    }
    return $result;
  }
  VisitedShop._() : super();
  factory VisitedShop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VisitedShop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VisitedShop', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOM<Shop>(1, _omitFieldNames ? '' : 'shop', subBuilder: Shop.create)
    ..aOS(2, _omitFieldNames ? '' : 'visitedAt')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VisitedShop clone() => VisitedShop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VisitedShop copyWith(void Function(VisitedShop) updates) => super.copyWith((message) => updates(message as VisitedShop)) as VisitedShop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VisitedShop create() => VisitedShop._();
  VisitedShop createEmptyInstance() => create();
  static $pb.PbList<VisitedShop> createRepeated() => $pb.PbList<VisitedShop>();
  @$core.pragma('dart2js:noInline')
  static VisitedShop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VisitedShop>(create);
  static VisitedShop? _defaultInstance;

  @$pb.TagNumber(1)
  Shop get shop => $_getN(0);
  @$pb.TagNumber(1)
  set shop(Shop v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShop() => $_has(0);
  @$pb.TagNumber(1)
  void clearShop() => clearField(1);
  @$pb.TagNumber(1)
  Shop ensureShop() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get visitedAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set visitedAt($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVisitedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearVisitedAt() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get rating => $_getIZ(2);
  @$pb.TagNumber(3)
  set rating($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRating() => $_has(2);
  @$pb.TagNumber(3)
  void clearRating() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get comment => $_getSZ(3);
  @$pb.TagNumber(4)
  set comment($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasComment() => $_has(3);
  @$pb.TagNumber(4)
  void clearComment() => clearField(4);
}

class Shop extends $pb.GeneratedMessage {
  factory Shop({
    $core.String? id,
    $core.String? name,
    $core.double? lat,
    $core.double? lng,
    $core.String? category,
    $core.bool? isVisited,
    $core.bool? isChain,
    $core.String? address,
    $core.String? phone,
    $core.String? openingHours,
    $core.Iterable<$core.String>? imageUrls,
    $core.double? rating,
    $core.String? sourceUrl,
    $core.double? clearanceRadius,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (lat != null) {
      $result.lat = lat;
    }
    if (lng != null) {
      $result.lng = lng;
    }
    if (category != null) {
      $result.category = category;
    }
    if (isVisited != null) {
      $result.isVisited = isVisited;
    }
    if (isChain != null) {
      $result.isChain = isChain;
    }
    if (address != null) {
      $result.address = address;
    }
    if (phone != null) {
      $result.phone = phone;
    }
    if (openingHours != null) {
      $result.openingHours = openingHours;
    }
    if (imageUrls != null) {
      $result.imageUrls.addAll(imageUrls);
    }
    if (rating != null) {
      $result.rating = rating;
    }
    if (sourceUrl != null) {
      $result.sourceUrl = sourceUrl;
    }
    if (clearanceRadius != null) {
      $result.clearanceRadius = clearanceRadius;
    }
    return $result;
  }
  Shop._() : super();
  factory Shop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Shop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Shop', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOB(6, _omitFieldNames ? '' : 'isVisited')
    ..aOB(7, _omitFieldNames ? '' : 'isChain')
    ..aOS(8, _omitFieldNames ? '' : 'address')
    ..aOS(9, _omitFieldNames ? '' : 'phone')
    ..aOS(10, _omitFieldNames ? '' : 'openingHours')
    ..pPS(11, _omitFieldNames ? '' : 'imageUrls')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.OD)
    ..aOS(13, _omitFieldNames ? '' : 'sourceUrl')
    ..a<$core.double>(14, _omitFieldNames ? '' : 'clearanceRadius', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Shop clone() => Shop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Shop copyWith(void Function(Shop) updates) => super.copyWith((message) => updates(message as Shop)) as Shop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Shop create() => Shop._();
  Shop createEmptyInstance() => create();
  static $pb.PbList<Shop> createRepeated() => $pb.PbList<Shop>();
  @$core.pragma('dart2js:noInline')
  static Shop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Shop>(create);
  static Shop? _defaultInstance;

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
  $core.double get lat => $_getN(2);
  @$pb.TagNumber(3)
  set lat($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLat() => $_has(2);
  @$pb.TagNumber(3)
  void clearLat() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get lng => $_getN(3);
  @$pb.TagNumber(4)
  set lng($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLng() => $_has(3);
  @$pb.TagNumber(4)
  void clearLng() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isVisited => $_getBF(5);
  @$pb.TagNumber(6)
  set isVisited($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsVisited() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsVisited() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isChain => $_getBF(6);
  @$pb.TagNumber(7)
  set isChain($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsChain() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsChain() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(8)
  set address($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearAddress() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get phone => $_getSZ(8);
  @$pb.TagNumber(9)
  set phone($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPhone() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhone() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get openingHours => $_getSZ(9);
  @$pb.TagNumber(10)
  set openingHours($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasOpeningHours() => $_has(9);
  @$pb.TagNumber(10)
  void clearOpeningHours() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get imageUrls => $_getList(10);

  @$pb.TagNumber(12)
  $core.double get rating => $_getN(11);
  @$pb.TagNumber(12)
  set rating($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasRating() => $_has(11);
  @$pb.TagNumber(12)
  void clearRating() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get sourceUrl => $_getSZ(12);
  @$pb.TagNumber(13)
  set sourceUrl($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSourceUrl() => $_has(12);
  @$pb.TagNumber(13)
  void clearSourceUrl() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get clearanceRadius => $_getN(13);
  @$pb.TagNumber(14)
  set clearanceRadius($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasClearanceRadius() => $_has(13);
  @$pb.TagNumber(14)
  void clearClearanceRadius() => clearField(14);
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

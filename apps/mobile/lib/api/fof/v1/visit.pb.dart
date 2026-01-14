//
//  Generated code. Do not modify.
//  source: fof/v1/visit.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'achievement.pb.dart' as $0;
import 'shop.pb.dart' as $2;

class UpdateVisitRequest extends $pb.GeneratedMessage {
  factory UpdateVisitRequest({
    $core.String? shopId,
    $core.int? rating,
    $core.String? comment,
    $core.Iterable<$core.String>? imageUrls,
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
    if (imageUrls != null) {
      $result.imageUrls.addAll(imageUrls);
    }
    return $result;
  }
  UpdateVisitRequest._() : super();
  factory UpdateVisitRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateVisitRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateVisitRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shopId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'comment')
    ..pPS(4, _omitFieldNames ? '' : 'imageUrls')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateVisitRequest clone() => UpdateVisitRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateVisitRequest copyWith(void Function(UpdateVisitRequest) updates) => super.copyWith((message) => updates(message as UpdateVisitRequest)) as UpdateVisitRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVisitRequest create() => UpdateVisitRequest._();
  UpdateVisitRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateVisitRequest> createRepeated() => $pb.PbList<UpdateVisitRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateVisitRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateVisitRequest>(create);
  static UpdateVisitRequest? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.List<$core.String> get imageUrls => $_getList(3);
}

class UpdateVisitResponse extends $pb.GeneratedMessage {
  factory UpdateVisitResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  UpdateVisitResponse._() : super();
  factory UpdateVisitResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateVisitResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateVisitResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateVisitResponse clone() => UpdateVisitResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateVisitResponse copyWith(void Function(UpdateVisitResponse) updates) => super.copyWith((message) => updates(message as UpdateVisitResponse)) as UpdateVisitResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVisitResponse create() => UpdateVisitResponse._();
  UpdateVisitResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateVisitResponse> createRepeated() => $pb.PbList<UpdateVisitResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateVisitResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateVisitResponse>(create);
  static UpdateVisitResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
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
    $core.int? expGained,
    $core.int? currentExp,
    $core.int? currentLevel,
    $core.Iterable<$0.Achievement>? unlockedAchievements,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
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
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expGained', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'currentExp', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'currentLevel', $pb.PbFieldType.O3)
    ..pc<$0.Achievement>(6, _omitFieldNames ? '' : 'unlockedAchievements', $pb.PbFieldType.PM, subBuilder: $0.Achievement.create)
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

  @$pb.TagNumber(3)
  $core.int get expGained => $_getIZ(1);
  @$pb.TagNumber(3)
  set expGained($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpGained() => $_has(1);
  @$pb.TagNumber(3)
  void clearExpGained() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentExp => $_getIZ(2);
  @$pb.TagNumber(4)
  set currentExp($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentExp() => $_has(2);
  @$pb.TagNumber(4)
  void clearCurrentExp() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get currentLevel => $_getIZ(3);
  @$pb.TagNumber(5)
  set currentLevel($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentLevel() => $_has(3);
  @$pb.TagNumber(5)
  void clearCurrentLevel() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$0.Achievement> get unlockedAchievements => $_getList(4);
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
    $2.Shop? shop,
    $core.String? visitedAt,
    $core.int? rating,
    $core.String? comment,
    $core.Iterable<$core.String>? imageUrls,
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
    if (imageUrls != null) {
      $result.imageUrls.addAll(imageUrls);
    }
    return $result;
  }
  VisitedShop._() : super();
  factory VisitedShop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VisitedShop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VisitedShop', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOM<$2.Shop>(1, _omitFieldNames ? '' : 'shop', subBuilder: $2.Shop.create)
    ..aOS(2, _omitFieldNames ? '' : 'visitedAt')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'comment')
    ..pPS(5, _omitFieldNames ? '' : 'imageUrls')
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
  $2.Shop get shop => $_getN(0);
  @$pb.TagNumber(1)
  set shop($2.Shop v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShop() => $_has(0);
  @$pb.TagNumber(1)
  void clearShop() => clearField(1);
  @$pb.TagNumber(1)
  $2.Shop ensureShop() => $_ensure(0);

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

  @$pb.TagNumber(5)
  $core.List<$core.String> get imageUrls => $_getList(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

//
//  Generated code. Do not modify.
//  source: fof/v1/shop.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'shop.pbenum.dart';

export 'shop.pbenum.dart';

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
    FoodCategory? foodCategory,
    $core.bool? reservable,
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
    if (foodCategory != null) {
      $result.foodCategory = foodCategory;
    }
    if (reservable != null) {
      $result.reservable = reservable;
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
    ..e<FoodCategory>(15, _omitFieldNames ? '' : 'foodCategory', $pb.PbFieldType.OE, defaultOrMaker: FoodCategory.FOOD_CATEGORY_UNSPECIFIED, valueOf: FoodCategory.valueOf, enumValues: FoodCategory.values)
    ..aOB(16, _omitFieldNames ? '' : 'reservable')
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

  @$pb.TagNumber(15)
  FoodCategory get foodCategory => $_getN(14);
  @$pb.TagNumber(15)
  set foodCategory(FoodCategory v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasFoodCategory() => $_has(14);
  @$pb.TagNumber(15)
  void clearFoodCategory() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get reservable => $_getBF(15);
  @$pb.TagNumber(16)
  set reservable($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasReservable() => $_has(15);
  @$pb.TagNumber(16)
  void clearReservable() => clearField(16);
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

class GetQuestShopRequest extends $pb.GeneratedMessage {
  factory GetQuestShopRequest({
    $core.double? lat,
    $core.double? lng,
    $core.double? radiusMeters,
    $core.Iterable<$core.String>? categories,
    $core.String? keyword,
    QuestRatingFilter? ratingFilter,
    $fixnum.Int64? openAtTime,
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
  GetQuestShopRequest._() : super();
  factory GetQuestShopRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQuestShopRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQuestShopRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'radiusMeters', $pb.PbFieldType.OD)
    ..pPS(4, _omitFieldNames ? '' : 'categories')
    ..aOS(5, _omitFieldNames ? '' : 'keyword')
    ..e<QuestRatingFilter>(6, _omitFieldNames ? '' : 'ratingFilter', $pb.PbFieldType.OE, defaultOrMaker: QuestRatingFilter.QUEST_RATING_FILTER_UNSPECIFIED, valueOf: QuestRatingFilter.valueOf, enumValues: QuestRatingFilter.values)
    ..aInt64(7, _omitFieldNames ? '' : 'openAtTime')
    ..aOB(9, _omitFieldNames ? '' : 'exclusiveIndependent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQuestShopRequest clone() => GetQuestShopRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQuestShopRequest copyWith(void Function(GetQuestShopRequest) updates) => super.copyWith((message) => updates(message as GetQuestShopRequest)) as GetQuestShopRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuestShopRequest create() => GetQuestShopRequest._();
  GetQuestShopRequest createEmptyInstance() => create();
  static $pb.PbList<GetQuestShopRequest> createRepeated() => $pb.PbList<GetQuestShopRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQuestShopRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQuestShopRequest>(create);
  static GetQuestShopRequest? _defaultInstance;

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
  $core.List<$core.String> get categories => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get keyword => $_getSZ(4);
  @$pb.TagNumber(5)
  set keyword($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasKeyword() => $_has(4);
  @$pb.TagNumber(5)
  void clearKeyword() => clearField(5);

  @$pb.TagNumber(6)
  QuestRatingFilter get ratingFilter => $_getN(5);
  @$pb.TagNumber(6)
  set ratingFilter(QuestRatingFilter v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRatingFilter() => $_has(5);
  @$pb.TagNumber(6)
  void clearRatingFilter() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get openAtTime => $_getI64(6);
  @$pb.TagNumber(7)
  set openAtTime($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOpenAtTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearOpenAtTime() => clearField(7);

  @$pb.TagNumber(9)
  $core.bool get exclusiveIndependent => $_getBF(7);
  @$pb.TagNumber(9)
  set exclusiveIndependent($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasExclusiveIndependent() => $_has(7);
  @$pb.TagNumber(9)
  void clearExclusiveIndependent() => clearField(9);
}

class GetQuestShopResponse extends $pb.GeneratedMessage {
  factory GetQuestShopResponse({
    Shop? shop,
  }) {
    final $result = create();
    if (shop != null) {
      $result.shop = shop;
    }
    return $result;
  }
  GetQuestShopResponse._() : super();
  factory GetQuestShopResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQuestShopResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQuestShopResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOM<Shop>(1, _omitFieldNames ? '' : 'shop', subBuilder: Shop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQuestShopResponse clone() => GetQuestShopResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQuestShopResponse copyWith(void Function(GetQuestShopResponse) updates) => super.copyWith((message) => updates(message as GetQuestShopResponse)) as GetQuestShopResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuestShopResponse create() => GetQuestShopResponse._();
  GetQuestShopResponse createEmptyInstance() => create();
  static $pb.PbList<GetQuestShopResponse> createRepeated() => $pb.PbList<GetQuestShopResponse>();
  @$core.pragma('dart2js:noInline')
  static GetQuestShopResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQuestShopResponse>(create);
  static GetQuestShopResponse? _defaultInstance;

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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

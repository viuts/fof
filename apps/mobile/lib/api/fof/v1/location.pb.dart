//
//  Generated code. Do not modify.
//  source: fof/v1/location.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $7;

class GetFogStatsRequest extends $pb.GeneratedMessage {
  factory GetFogStatsRequest() => create();
  GetFogStatsRequest._() : super();
  factory GetFogStatsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFogStatsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFogStatsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFogStatsRequest clone() => GetFogStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFogStatsRequest copyWith(void Function(GetFogStatsRequest) updates) => super.copyWith((message) => updates(message as GetFogStatsRequest)) as GetFogStatsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFogStatsRequest create() => GetFogStatsRequest._();
  GetFogStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFogStatsRequest> createRepeated() => $pb.PbList<GetFogStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFogStatsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFogStatsRequest>(create);
  static GetFogStatsRequest? _defaultInstance;
}

class GetFogStatsResponse extends $pb.GeneratedMessage {
  factory GetFogStatsResponse({
    $core.double? clearedAreaMeters,
    $core.double? worldCoveragePercentage,
  }) {
    final $result = create();
    if (clearedAreaMeters != null) {
      $result.clearedAreaMeters = clearedAreaMeters;
    }
    if (worldCoveragePercentage != null) {
      $result.worldCoveragePercentage = worldCoveragePercentage;
    }
    return $result;
  }
  GetFogStatsResponse._() : super();
  factory GetFogStatsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFogStatsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFogStatsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'clearedAreaMeters', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'worldCoveragePercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFogStatsResponse clone() => GetFogStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFogStatsResponse copyWith(void Function(GetFogStatsResponse) updates) => super.copyWith((message) => updates(message as GetFogStatsResponse)) as GetFogStatsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFogStatsResponse create() => GetFogStatsResponse._();
  GetFogStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFogStatsResponse> createRepeated() => $pb.PbList<GetFogStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFogStatsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFogStatsResponse>(create);
  static GetFogStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get clearedAreaMeters => $_getN(0);
  @$pb.TagNumber(1)
  set clearedAreaMeters($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClearedAreaMeters() => $_has(0);
  @$pb.TagNumber(1)
  void clearClearedAreaMeters() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get worldCoveragePercentage => $_getN(1);
  @$pb.TagNumber(2)
  set worldCoveragePercentage($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorldCoveragePercentage() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorldCoveragePercentage() => clearField(2);
}

class GetClearedAreaRequest extends $pb.GeneratedMessage {
  factory GetClearedAreaRequest({
    $core.double? minLat,
    $core.double? minLng,
    $core.double? maxLat,
    $core.double? maxLng,
  }) {
    final $result = create();
    if (minLat != null) {
      $result.minLat = minLat;
    }
    if (minLng != null) {
      $result.minLng = minLng;
    }
    if (maxLat != null) {
      $result.maxLat = maxLat;
    }
    if (maxLng != null) {
      $result.maxLng = maxLng;
    }
    return $result;
  }
  GetClearedAreaRequest._() : super();
  factory GetClearedAreaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClearedAreaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetClearedAreaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'minLat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'minLng', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'maxLat', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'maxLng', $pb.PbFieldType.OD)
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

  @$pb.TagNumber(1)
  $core.double get minLat => $_getN(0);
  @$pb.TagNumber(1)
  set minLat($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinLat() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get minLng => $_getN(1);
  @$pb.TagNumber(2)
  set minLng($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMinLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinLng() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get maxLat => $_getN(2);
  @$pb.TagNumber(3)
  set maxLat($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxLat() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxLat() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get maxLng => $_getN(3);
  @$pb.TagNumber(4)
  set maxLng($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxLng() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxLng() => clearField(4);
}

class GetClearedAreaResponse extends $pb.GeneratedMessage {
  factory GetClearedAreaResponse({
    $core.String? clearedAreaGeojson,
    $core.double? clearedAreaMeters,
    $core.double? worldCoveragePercentage,
  }) {
    final $result = create();
    if (clearedAreaGeojson != null) {
      $result.clearedAreaGeojson = clearedAreaGeojson;
    }
    if (clearedAreaMeters != null) {
      $result.clearedAreaMeters = clearedAreaMeters;
    }
    if (worldCoveragePercentage != null) {
      $result.worldCoveragePercentage = worldCoveragePercentage;
    }
    return $result;
  }
  GetClearedAreaResponse._() : super();
  factory GetClearedAreaResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClearedAreaResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetClearedAreaResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clearedAreaGeojson')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'clearedAreaMeters', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'worldCoveragePercentage', $pb.PbFieldType.OD)
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

  @$pb.TagNumber(2)
  $core.double get clearedAreaMeters => $_getN(1);
  @$pb.TagNumber(2)
  set clearedAreaMeters($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClearedAreaMeters() => $_has(1);
  @$pb.TagNumber(2)
  void clearClearedAreaMeters() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get worldCoveragePercentage => $_getN(2);
  @$pb.TagNumber(3)
  set worldCoveragePercentage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWorldCoveragePercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorldCoveragePercentage() => clearField(3);
}

class UpdateLocationRequest extends $pb.GeneratedMessage {
  factory UpdateLocationRequest({
    $core.Iterable<$7.LatLng>? path,
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
    ..pc<$7.LatLng>(1, _omitFieldNames ? '' : 'path', $pb.PbFieldType.PM, subBuilder: $7.LatLng.create)
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
  $core.List<$7.LatLng> get path => $_getList(0);

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
  factory UpdateLocationResponse() => create();
  UpdateLocationResponse._() : super();
  factory UpdateLocationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLocationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLocationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'fof.v1'), createEmptyInstance: create)
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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

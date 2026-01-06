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

import 'common.pb.dart' as $4;

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

class UpdateLocationRequest extends $pb.GeneratedMessage {
  factory UpdateLocationRequest({
    $core.Iterable<$4.LatLng>? path,
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
    ..pc<$4.LatLng>(1, _omitFieldNames ? '' : 'path', $pb.PbFieldType.PM, subBuilder: $4.LatLng.create)
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
  $core.List<$4.LatLng> get path => $_getList(0);

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

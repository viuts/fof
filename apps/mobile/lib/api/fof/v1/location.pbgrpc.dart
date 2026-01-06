//
//  Generated code. Do not modify.
//  source: fof/v1/location.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'location.pb.dart' as $1;

export 'location.pb.dart';

@$pb.GrpcServiceName('fof.v1.LocationService')
class LocationServiceClient extends $grpc.Client {
  static final _$updateLocation = $grpc.ClientMethod<$1.UpdateLocationRequest, $1.UpdateLocationResponse>(
      '/fof.v1.LocationService/UpdateLocation',
      ($1.UpdateLocationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.UpdateLocationResponse.fromBuffer(value));
  static final _$getClearedArea = $grpc.ClientMethod<$1.GetClearedAreaRequest, $1.GetClearedAreaResponse>(
      '/fof.v1.LocationService/GetClearedArea',
      ($1.GetClearedAreaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetClearedAreaResponse.fromBuffer(value));

  LocationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.UpdateLocationResponse> updateLocation($1.UpdateLocationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLocation, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetClearedAreaResponse> getClearedArea($1.GetClearedAreaRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClearedArea, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.LocationService')
abstract class LocationServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.LocationService';

  LocationServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.UpdateLocationRequest, $1.UpdateLocationResponse>(
        'UpdateLocation',
        updateLocation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UpdateLocationRequest.fromBuffer(value),
        ($1.UpdateLocationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetClearedAreaRequest, $1.GetClearedAreaResponse>(
        'GetClearedArea',
        getClearedArea_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetClearedAreaRequest.fromBuffer(value),
        ($1.GetClearedAreaResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.UpdateLocationResponse> updateLocation_Pre($grpc.ServiceCall call, $async.Future<$1.UpdateLocationRequest> request) async {
    return updateLocation(call, await request);
  }

  $async.Future<$1.GetClearedAreaResponse> getClearedArea_Pre($grpc.ServiceCall call, $async.Future<$1.GetClearedAreaRequest> request) async {
    return getClearedArea(call, await request);
  }

  $async.Future<$1.UpdateLocationResponse> updateLocation($grpc.ServiceCall call, $1.UpdateLocationRequest request);
  $async.Future<$1.GetClearedAreaResponse> getClearedArea($grpc.ServiceCall call, $1.GetClearedAreaRequest request);
}

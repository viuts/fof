//
//  Generated code. Do not modify.
//  source: fof/v1/fof.proto
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

import 'fof.pb.dart' as $0;

export 'fof.pb.dart';

@$pb.GrpcServiceName('fof.v1.FlavorService')
class FlavorServiceClient extends $grpc.Client {
  static final _$updateLocation = $grpc.ClientMethod<$0.UpdateLocationRequest, $0.UpdateLocationResponse>(
      '/fof.v1.FlavorService/UpdateLocation',
      ($0.UpdateLocationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateLocationResponse.fromBuffer(value));
  static final _$getNearbyShops = $grpc.ClientMethod<$0.GetNearbyShopsRequest, $0.GetNearbyShopsResponse>(
      '/fof.v1.FlavorService/GetNearbyShops',
      ($0.GetNearbyShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetNearbyShopsResponse.fromBuffer(value));
  static final _$getVisitedShops = $grpc.ClientMethod<$0.GetVisitedShopsRequest, $0.GetVisitedShopsResponse>(
      '/fof.v1.FlavorService/GetVisitedShops',
      ($0.GetVisitedShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetVisitedShopsResponse.fromBuffer(value));
  static final _$createVisit = $grpc.ClientMethod<$0.CreateVisitRequest, $0.CreateVisitResponse>(
      '/fof.v1.FlavorService/CreateVisit',
      ($0.CreateVisitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateVisitResponse.fromBuffer(value));
  static final _$getClearedArea = $grpc.ClientMethod<$0.GetClearedAreaRequest, $0.GetClearedAreaResponse>(
      '/fof.v1.FlavorService/GetClearedArea',
      ($0.GetClearedAreaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetClearedAreaResponse.fromBuffer(value));
  static final _$getAchievements = $grpc.ClientMethod<$0.GetAchievementsRequest, $0.GetAchievementsResponse>(
      '/fof.v1.FlavorService/GetAchievements',
      ($0.GetAchievementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAchievementsResponse.fromBuffer(value));

  FlavorServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.UpdateLocationResponse> updateLocation($0.UpdateLocationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLocation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetNearbyShopsResponse> getNearbyShops($0.GetNearbyShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNearbyShops, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetVisitedShopsResponse> getVisitedShops($0.GetVisitedShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVisitedShops, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateVisitResponse> createVisit($0.CreateVisitRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVisit, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetClearedAreaResponse> getClearedArea($0.GetClearedAreaRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClearedArea, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAchievementsResponse> getAchievements($0.GetAchievementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAchievements, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.FlavorService')
abstract class FlavorServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.FlavorService';

  FlavorServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UpdateLocationRequest, $0.UpdateLocationResponse>(
        'UpdateLocation',
        updateLocation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateLocationRequest.fromBuffer(value),
        ($0.UpdateLocationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNearbyShopsRequest, $0.GetNearbyShopsResponse>(
        'GetNearbyShops',
        getNearbyShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetNearbyShopsRequest.fromBuffer(value),
        ($0.GetNearbyShopsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVisitedShopsRequest, $0.GetVisitedShopsResponse>(
        'GetVisitedShops',
        getVisitedShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetVisitedShopsRequest.fromBuffer(value),
        ($0.GetVisitedShopsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateVisitRequest, $0.CreateVisitResponse>(
        'CreateVisit',
        createVisit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateVisitRequest.fromBuffer(value),
        ($0.CreateVisitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetClearedAreaRequest, $0.GetClearedAreaResponse>(
        'GetClearedArea',
        getClearedArea_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetClearedAreaRequest.fromBuffer(value),
        ($0.GetClearedAreaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAchievementsRequest, $0.GetAchievementsResponse>(
        'GetAchievements',
        getAchievements_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAchievementsRequest.fromBuffer(value),
        ($0.GetAchievementsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UpdateLocationResponse> updateLocation_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateLocationRequest> request) async {
    return updateLocation(call, await request);
  }

  $async.Future<$0.GetNearbyShopsResponse> getNearbyShops_Pre($grpc.ServiceCall call, $async.Future<$0.GetNearbyShopsRequest> request) async {
    return getNearbyShops(call, await request);
  }

  $async.Future<$0.GetVisitedShopsResponse> getVisitedShops_Pre($grpc.ServiceCall call, $async.Future<$0.GetVisitedShopsRequest> request) async {
    return getVisitedShops(call, await request);
  }

  $async.Future<$0.CreateVisitResponse> createVisit_Pre($grpc.ServiceCall call, $async.Future<$0.CreateVisitRequest> request) async {
    return createVisit(call, await request);
  }

  $async.Future<$0.GetClearedAreaResponse> getClearedArea_Pre($grpc.ServiceCall call, $async.Future<$0.GetClearedAreaRequest> request) async {
    return getClearedArea(call, await request);
  }

  $async.Future<$0.GetAchievementsResponse> getAchievements_Pre($grpc.ServiceCall call, $async.Future<$0.GetAchievementsRequest> request) async {
    return getAchievements(call, await request);
  }

  $async.Future<$0.UpdateLocationResponse> updateLocation($grpc.ServiceCall call, $0.UpdateLocationRequest request);
  $async.Future<$0.GetNearbyShopsResponse> getNearbyShops($grpc.ServiceCall call, $0.GetNearbyShopsRequest request);
  $async.Future<$0.GetVisitedShopsResponse> getVisitedShops($grpc.ServiceCall call, $0.GetVisitedShopsRequest request);
  $async.Future<$0.CreateVisitResponse> createVisit($grpc.ServiceCall call, $0.CreateVisitRequest request);
  $async.Future<$0.GetClearedAreaResponse> getClearedArea($grpc.ServiceCall call, $0.GetClearedAreaRequest request);
  $async.Future<$0.GetAchievementsResponse> getAchievements($grpc.ServiceCall call, $0.GetAchievementsRequest request);
}

//
//  Generated code. Do not modify.
//  source: fof/v1/visit.proto
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

import 'visit.pb.dart' as $6;

export 'visit.pb.dart';

@$pb.GrpcServiceName('fof.v1.VisitService')
class VisitServiceClient extends $grpc.Client {
  static final _$getVisitedShops = $grpc.ClientMethod<$6.GetVisitedShopsRequest, $6.GetVisitedShopsResponse>(
      '/fof.v1.VisitService/GetVisitedShops',
      ($6.GetVisitedShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetVisitedShopsResponse.fromBuffer(value));
  static final _$createVisit = $grpc.ClientMethod<$6.CreateVisitRequest, $6.CreateVisitResponse>(
      '/fof.v1.VisitService/CreateVisit',
      ($6.CreateVisitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.CreateVisitResponse.fromBuffer(value));
  static final _$updateVisit = $grpc.ClientMethod<$6.UpdateVisitRequest, $6.UpdateVisitResponse>(
      '/fof.v1.VisitService/UpdateVisit',
      ($6.UpdateVisitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.UpdateVisitResponse.fromBuffer(value));

  VisitServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$6.GetVisitedShopsResponse> getVisitedShops($6.GetVisitedShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVisitedShops, request, options: options);
  }

  $grpc.ResponseFuture<$6.CreateVisitResponse> createVisit($6.CreateVisitRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVisit, request, options: options);
  }

  $grpc.ResponseFuture<$6.UpdateVisitResponse> updateVisit($6.UpdateVisitRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVisit, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.VisitService')
abstract class VisitServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.VisitService';

  VisitServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.GetVisitedShopsRequest, $6.GetVisitedShopsResponse>(
        'GetVisitedShops',
        getVisitedShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetVisitedShopsRequest.fromBuffer(value),
        ($6.GetVisitedShopsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.CreateVisitRequest, $6.CreateVisitResponse>(
        'CreateVisit',
        createVisit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.CreateVisitRequest.fromBuffer(value),
        ($6.CreateVisitResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.UpdateVisitRequest, $6.UpdateVisitResponse>(
        'UpdateVisit',
        updateVisit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.UpdateVisitRequest.fromBuffer(value),
        ($6.UpdateVisitResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.GetVisitedShopsResponse> getVisitedShops_Pre($grpc.ServiceCall call, $async.Future<$6.GetVisitedShopsRequest> request) async {
    return getVisitedShops(call, await request);
  }

  $async.Future<$6.CreateVisitResponse> createVisit_Pre($grpc.ServiceCall call, $async.Future<$6.CreateVisitRequest> request) async {
    return createVisit(call, await request);
  }

  $async.Future<$6.UpdateVisitResponse> updateVisit_Pre($grpc.ServiceCall call, $async.Future<$6.UpdateVisitRequest> request) async {
    return updateVisit(call, await request);
  }

  $async.Future<$6.GetVisitedShopsResponse> getVisitedShops($grpc.ServiceCall call, $6.GetVisitedShopsRequest request);
  $async.Future<$6.CreateVisitResponse> createVisit($grpc.ServiceCall call, $6.CreateVisitRequest request);
  $async.Future<$6.UpdateVisitResponse> updateVisit($grpc.ServiceCall call, $6.UpdateVisitRequest request);
}

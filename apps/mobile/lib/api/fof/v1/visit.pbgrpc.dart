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

import 'visit.pb.dart' as $4;

export 'visit.pb.dart';

@$pb.GrpcServiceName('fof.v1.VisitService')
class VisitServiceClient extends $grpc.Client {
  static final _$getVisitedShops = $grpc.ClientMethod<$4.GetVisitedShopsRequest, $4.GetVisitedShopsResponse>(
      '/fof.v1.VisitService/GetVisitedShops',
      ($4.GetVisitedShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetVisitedShopsResponse.fromBuffer(value));
  static final _$createVisit = $grpc.ClientMethod<$4.CreateVisitRequest, $4.CreateVisitResponse>(
      '/fof.v1.VisitService/CreateVisit',
      ($4.CreateVisitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.CreateVisitResponse.fromBuffer(value));

  VisitServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.GetVisitedShopsResponse> getVisitedShops($4.GetVisitedShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVisitedShops, request, options: options);
  }

  $grpc.ResponseFuture<$4.CreateVisitResponse> createVisit($4.CreateVisitRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVisit, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.VisitService')
abstract class VisitServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.VisitService';

  VisitServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.GetVisitedShopsRequest, $4.GetVisitedShopsResponse>(
        'GetVisitedShops',
        getVisitedShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetVisitedShopsRequest.fromBuffer(value),
        ($4.GetVisitedShopsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CreateVisitRequest, $4.CreateVisitResponse>(
        'CreateVisit',
        createVisit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.CreateVisitRequest.fromBuffer(value),
        ($4.CreateVisitResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.GetVisitedShopsResponse> getVisitedShops_Pre($grpc.ServiceCall call, $async.Future<$4.GetVisitedShopsRequest> request) async {
    return getVisitedShops(call, await request);
  }

  $async.Future<$4.CreateVisitResponse> createVisit_Pre($grpc.ServiceCall call, $async.Future<$4.CreateVisitRequest> request) async {
    return createVisit(call, await request);
  }

  $async.Future<$4.GetVisitedShopsResponse> getVisitedShops($grpc.ServiceCall call, $4.GetVisitedShopsRequest request);
  $async.Future<$4.CreateVisitResponse> createVisit($grpc.ServiceCall call, $4.CreateVisitRequest request);
}

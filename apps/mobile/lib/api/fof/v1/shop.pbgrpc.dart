//
//  Generated code. Do not modify.
//  source: fof/v1/shop.proto
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

import 'shop.pb.dart' as $2;

export 'shop.pb.dart';

@$pb.GrpcServiceName('fof.v1.ShopService')
class ShopServiceClient extends $grpc.Client {
  static final _$getNearbyShops = $grpc.ClientMethod<$2.GetNearbyShopsRequest, $2.GetNearbyShopsResponse>(
      '/fof.v1.ShopService/GetNearbyShops',
      ($2.GetNearbyShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetNearbyShopsResponse.fromBuffer(value));

  ShopServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.GetNearbyShopsResponse> getNearbyShops($2.GetNearbyShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNearbyShops, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.ShopService')
abstract class ShopServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.ShopService';

  ShopServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetNearbyShopsRequest, $2.GetNearbyShopsResponse>(
        'GetNearbyShops',
        getNearbyShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetNearbyShopsRequest.fromBuffer(value),
        ($2.GetNearbyShopsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.GetNearbyShopsResponse> getNearbyShops_Pre($grpc.ServiceCall call, $async.Future<$2.GetNearbyShopsRequest> request) async {
    return getNearbyShops(call, await request);
  }

  $async.Future<$2.GetNearbyShopsResponse> getNearbyShops($grpc.ServiceCall call, $2.GetNearbyShopsRequest request);
}

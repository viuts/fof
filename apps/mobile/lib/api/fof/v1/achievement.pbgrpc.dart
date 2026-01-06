//
//  Generated code. Do not modify.
//  source: fof/v1/achievement.proto
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

import 'achievement.pb.dart' as $0;

export 'achievement.pb.dart';

@$pb.GrpcServiceName('fof.v1.AchievementService')
class AchievementServiceClient extends $grpc.Client {
  static final _$getAchievements = $grpc.ClientMethod<$0.GetAchievementsRequest, $0.GetAchievementsResponse>(
      '/fof.v1.AchievementService/GetAchievements',
      ($0.GetAchievementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAchievementsResponse.fromBuffer(value));

  AchievementServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetAchievementsResponse> getAchievements($0.GetAchievementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAchievements, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.AchievementService')
abstract class AchievementServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.AchievementService';

  AchievementServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetAchievementsRequest, $0.GetAchievementsResponse>(
        'GetAchievements',
        getAchievements_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAchievementsRequest.fromBuffer(value),
        ($0.GetAchievementsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetAchievementsResponse> getAchievements_Pre($grpc.ServiceCall call, $async.Future<$0.GetAchievementsRequest> request) async {
    return getAchievements(call, await request);
  }

  $async.Future<$0.GetAchievementsResponse> getAchievements($grpc.ServiceCall call, $0.GetAchievementsRequest request);
}

//
//  Generated code. Do not modify.
//  source: fof/v1/ranking.proto
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

import 'ranking.pb.dart' as $4;

export 'ranking.pb.dart';

@$pb.GrpcServiceName('fof.v1.RankingService')
class RankingServiceClient extends $grpc.Client {
  static final _$getAreaCoverageRanking = $grpc.ClientMethod<$4.GetRankingRequest, $4.GetRankingResponse>(
      '/fof.v1.RankingService/GetAreaCoverageRanking',
      ($4.GetRankingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetRankingResponse.fromBuffer(value));
  static final _$getLevelRanking = $grpc.ClientMethod<$4.GetRankingRequest, $4.GetRankingResponse>(
      '/fof.v1.RankingService/GetLevelRanking',
      ($4.GetRankingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetRankingResponse.fromBuffer(value));
  static final _$getVisitCountRanking = $grpc.ClientMethod<$4.GetRankingRequest, $4.GetRankingResponse>(
      '/fof.v1.RankingService/GetVisitCountRanking',
      ($4.GetRankingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetRankingResponse.fromBuffer(value));
  static final _$getCategoryVisitRanking = $grpc.ClientMethod<$4.GetCategoryRankingRequest, $4.GetRankingResponse>(
      '/fof.v1.RankingService/GetCategoryVisitRanking',
      ($4.GetCategoryRankingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetRankingResponse.fromBuffer(value));

  RankingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.GetRankingResponse> getAreaCoverageRanking($4.GetRankingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAreaCoverageRanking, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetRankingResponse> getLevelRanking($4.GetRankingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLevelRanking, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetRankingResponse> getVisitCountRanking($4.GetRankingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVisitCountRanking, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetRankingResponse> getCategoryVisitRanking($4.GetCategoryRankingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryVisitRanking, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.RankingService')
abstract class RankingServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.RankingService';

  RankingServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.GetRankingRequest, $4.GetRankingResponse>(
        'GetAreaCoverageRanking',
        getAreaCoverageRanking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetRankingRequest.fromBuffer(value),
        ($4.GetRankingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetRankingRequest, $4.GetRankingResponse>(
        'GetLevelRanking',
        getLevelRanking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetRankingRequest.fromBuffer(value),
        ($4.GetRankingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetRankingRequest, $4.GetRankingResponse>(
        'GetVisitCountRanking',
        getVisitCountRanking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetRankingRequest.fromBuffer(value),
        ($4.GetRankingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetCategoryRankingRequest, $4.GetRankingResponse>(
        'GetCategoryVisitRanking',
        getCategoryVisitRanking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetCategoryRankingRequest.fromBuffer(value),
        ($4.GetRankingResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.GetRankingResponse> getAreaCoverageRanking_Pre($grpc.ServiceCall call, $async.Future<$4.GetRankingRequest> request) async {
    return getAreaCoverageRanking(call, await request);
  }

  $async.Future<$4.GetRankingResponse> getLevelRanking_Pre($grpc.ServiceCall call, $async.Future<$4.GetRankingRequest> request) async {
    return getLevelRanking(call, await request);
  }

  $async.Future<$4.GetRankingResponse> getVisitCountRanking_Pre($grpc.ServiceCall call, $async.Future<$4.GetRankingRequest> request) async {
    return getVisitCountRanking(call, await request);
  }

  $async.Future<$4.GetRankingResponse> getCategoryVisitRanking_Pre($grpc.ServiceCall call, $async.Future<$4.GetCategoryRankingRequest> request) async {
    return getCategoryVisitRanking(call, await request);
  }

  $async.Future<$4.GetRankingResponse> getAreaCoverageRanking($grpc.ServiceCall call, $4.GetRankingRequest request);
  $async.Future<$4.GetRankingResponse> getLevelRanking($grpc.ServiceCall call, $4.GetRankingRequest request);
  $async.Future<$4.GetRankingResponse> getVisitCountRanking($grpc.ServiceCall call, $4.GetRankingRequest request);
  $async.Future<$4.GetRankingResponse> getCategoryVisitRanking($grpc.ServiceCall call, $4.GetCategoryRankingRequest request);
}

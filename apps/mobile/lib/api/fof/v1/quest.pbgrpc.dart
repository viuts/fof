//
//  Generated code. Do not modify.
//  source: fof/v1/quest.proto
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

import 'quest.pb.dart' as $3;

export 'quest.pb.dart';

@$pb.GrpcServiceName('fof.v1.QuestService')
class QuestServiceClient extends $grpc.Client {
  static final _$startQuest = $grpc.ClientMethod<$3.StartQuestRequest, $3.StartQuestResponse>(
      '/fof.v1.QuestService/StartQuest',
      ($3.StartQuestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.StartQuestResponse.fromBuffer(value));
  static final _$completeQuest = $grpc.ClientMethod<$3.CompleteQuestRequest, $3.CompleteQuestResponse>(
      '/fof.v1.QuestService/CompleteQuest',
      ($3.CompleteQuestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.CompleteQuestResponse.fromBuffer(value));
  static final _$cancelQuest = $grpc.ClientMethod<$3.CancelQuestRequest, $3.CancelQuestResponse>(
      '/fof.v1.QuestService/CancelQuest',
      ($3.CancelQuestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.CancelQuestResponse.fromBuffer(value));
  static final _$getActiveQuest = $grpc.ClientMethod<$3.GetActiveQuestRequest, $3.GetActiveQuestResponse>(
      '/fof.v1.QuestService/GetActiveQuest',
      ($3.GetActiveQuestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetActiveQuestResponse.fromBuffer(value));
  static final _$getQuestHistory = $grpc.ClientMethod<$3.GetQuestHistoryRequest, $3.GetQuestHistoryResponse>(
      '/fof.v1.QuestService/GetQuestHistory',
      ($3.GetQuestHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetQuestHistoryResponse.fromBuffer(value));

  QuestServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$3.StartQuestResponse> startQuest($3.StartQuestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startQuest, request, options: options);
  }

  $grpc.ResponseFuture<$3.CompleteQuestResponse> completeQuest($3.CompleteQuestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeQuest, request, options: options);
  }

  $grpc.ResponseFuture<$3.CancelQuestResponse> cancelQuest($3.CancelQuestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelQuest, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetActiveQuestResponse> getActiveQuest($3.GetActiveQuestRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getActiveQuest, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetQuestHistoryResponse> getQuestHistory($3.GetQuestHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQuestHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('fof.v1.QuestService')
abstract class QuestServiceBase extends $grpc.Service {
  $core.String get $name => 'fof.v1.QuestService';

  QuestServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.StartQuestRequest, $3.StartQuestResponse>(
        'StartQuest',
        startQuest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.StartQuestRequest.fromBuffer(value),
        ($3.StartQuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CompleteQuestRequest, $3.CompleteQuestResponse>(
        'CompleteQuest',
        completeQuest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.CompleteQuestRequest.fromBuffer(value),
        ($3.CompleteQuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CancelQuestRequest, $3.CancelQuestResponse>(
        'CancelQuest',
        cancelQuest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.CancelQuestRequest.fromBuffer(value),
        ($3.CancelQuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetActiveQuestRequest, $3.GetActiveQuestResponse>(
        'GetActiveQuest',
        getActiveQuest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetActiveQuestRequest.fromBuffer(value),
        ($3.GetActiveQuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetQuestHistoryRequest, $3.GetQuestHistoryResponse>(
        'GetQuestHistory',
        getQuestHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetQuestHistoryRequest.fromBuffer(value),
        ($3.GetQuestHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.StartQuestResponse> startQuest_Pre($grpc.ServiceCall call, $async.Future<$3.StartQuestRequest> request) async {
    return startQuest(call, await request);
  }

  $async.Future<$3.CompleteQuestResponse> completeQuest_Pre($grpc.ServiceCall call, $async.Future<$3.CompleteQuestRequest> request) async {
    return completeQuest(call, await request);
  }

  $async.Future<$3.CancelQuestResponse> cancelQuest_Pre($grpc.ServiceCall call, $async.Future<$3.CancelQuestRequest> request) async {
    return cancelQuest(call, await request);
  }

  $async.Future<$3.GetActiveQuestResponse> getActiveQuest_Pre($grpc.ServiceCall call, $async.Future<$3.GetActiveQuestRequest> request) async {
    return getActiveQuest(call, await request);
  }

  $async.Future<$3.GetQuestHistoryResponse> getQuestHistory_Pre($grpc.ServiceCall call, $async.Future<$3.GetQuestHistoryRequest> request) async {
    return getQuestHistory(call, await request);
  }

  $async.Future<$3.StartQuestResponse> startQuest($grpc.ServiceCall call, $3.StartQuestRequest request);
  $async.Future<$3.CompleteQuestResponse> completeQuest($grpc.ServiceCall call, $3.CompleteQuestRequest request);
  $async.Future<$3.CancelQuestResponse> cancelQuest($grpc.ServiceCall call, $3.CancelQuestRequest request);
  $async.Future<$3.GetActiveQuestResponse> getActiveQuest($grpc.ServiceCall call, $3.GetActiveQuestRequest request);
  $async.Future<$3.GetQuestHistoryResponse> getQuestHistory($grpc.ServiceCall call, $3.GetQuestHistoryRequest request);
}

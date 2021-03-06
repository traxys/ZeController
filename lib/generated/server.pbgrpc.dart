///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:grpc/service_api.dart' as $grpc;

import 'dart:core' as $core show int, String, List;

import 'server.pb.dart';
export 'server.pb.dart';

class HomeManagerClient extends $grpc.Client {
  static final _$getStatus = $grpc.ClientMethod<StatusRequest, StatusReply>(
      '/HomeManager/GetStatus',
      (StatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => StatusReply.fromBuffer(value));
  static final _$toggle = $grpc.ClientMethod<ToggleRequest, ToggleReply>(
      '/HomeManager/Toggle',
      (ToggleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => ToggleReply.fromBuffer(value));
  static final _$powerOn = $grpc.ClientMethod<PowerOnRequest, PowerOnReply>(
      '/HomeManager/PowerOn',
      (PowerOnRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => PowerOnReply.fromBuffer(value));

  HomeManagerClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<StatusReply> getStatus(StatusRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getStatus, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<ToggleReply> toggle(ToggleRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$toggle, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<PowerOnReply> powerOn(PowerOnRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$powerOn, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class HomeManagerServiceBase extends $grpc.Service {
  $core.String get $name => 'HomeManager';

  HomeManagerServiceBase() {
    $addMethod($grpc.ServiceMethod<StatusRequest, StatusReply>(
        'GetStatus',
        getStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => StatusRequest.fromBuffer(value),
        (StatusReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<ToggleRequest, ToggleReply>(
        'Toggle',
        toggle_Pre,
        false,
        false,
        ($core.List<$core.int> value) => ToggleRequest.fromBuffer(value),
        (ToggleReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<PowerOnRequest, PowerOnReply>(
        'PowerOn',
        powerOn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => PowerOnRequest.fromBuffer(value),
        (PowerOnReply value) => value.writeToBuffer()));
  }

  $async.Future<StatusReply> getStatus_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return getStatus(call, await request);
  }

  $async.Future<ToggleReply> toggle_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return toggle(call, await request);
  }

  $async.Future<PowerOnReply> powerOn_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return powerOn(call, await request);
  }

  $async.Future<StatusReply> getStatus(
      $grpc.ServiceCall call, StatusRequest request);
  $async.Future<ToggleReply> toggle(
      $grpc.ServiceCall call, ToggleRequest request);
  $async.Future<PowerOnReply> powerOn(
      $grpc.ServiceCall call, PowerOnRequest request);
}

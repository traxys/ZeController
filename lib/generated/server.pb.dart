///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'server.pbenum.dart';

export 'server.pbenum.dart';

class Object extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Object')
    ..e<ObjectType>(1, 'type', $pb.PbFieldType.OE, ObjectType.COMPUTER, ObjectType.valueOf, ObjectType.values)
    ..a<$core.int>(2, 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Object() : super();
  Object.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Object.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Object clone() => Object()..mergeFromMessage(this);
  Object copyWith(void Function(Object) updates) => super.copyWith((message) => updates(message as Object));
  $pb.BuilderInfo get info_ => _i;
  static Object create() => Object();
  Object createEmptyInstance() => create();
  static $pb.PbList<Object> createRepeated() => $pb.PbList<Object>();
  static Object getDefault() => _defaultInstance ??= create()..freeze();
  static Object _defaultInstance;

  ObjectType get type => $_getN(0);
  set type(ObjectType v) { setField(1, v); }
  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.int get id => $_get(1, 0);
  set id($core.int v) { $_setUnsignedInt32(1, v); }
  $core.bool hasId() => $_has(1);
  void clearId() => clearField(2);
}

class StatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatusRequest')
    ..a<Object>(1, 'target', $pb.PbFieldType.OM, Object.getDefault, Object.create)
    ..hasRequiredFields = false
  ;

  StatusRequest() : super();
  StatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StatusRequest clone() => StatusRequest()..mergeFromMessage(this);
  StatusRequest copyWith(void Function(StatusRequest) updates) => super.copyWith((message) => updates(message as StatusRequest));
  $pb.BuilderInfo get info_ => _i;
  static StatusRequest create() => StatusRequest();
  StatusRequest createEmptyInstance() => create();
  static $pb.PbList<StatusRequest> createRepeated() => $pb.PbList<StatusRequest>();
  static StatusRequest getDefault() => _defaultInstance ??= create()..freeze();
  static StatusRequest _defaultInstance;

  Object get target => $_getN(0);
  set target(Object v) { setField(1, v); }
  $core.bool hasTarget() => $_has(0);
  void clearTarget() => clearField(1);
}

class StatusReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatusReply')
    ..e<Status>(1, 'status', $pb.PbFieldType.OE, Status.UNKNOWN, Status.valueOf, Status.values)
    ..hasRequiredFields = false
  ;

  StatusReply() : super();
  StatusReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StatusReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StatusReply clone() => StatusReply()..mergeFromMessage(this);
  StatusReply copyWith(void Function(StatusReply) updates) => super.copyWith((message) => updates(message as StatusReply));
  $pb.BuilderInfo get info_ => _i;
  static StatusReply create() => StatusReply();
  StatusReply createEmptyInstance() => create();
  static $pb.PbList<StatusReply> createRepeated() => $pb.PbList<StatusReply>();
  static StatusReply getDefault() => _defaultInstance ??= create()..freeze();
  static StatusReply _defaultInstance;

  Status get status => $_getN(0);
  set status(Status v) { setField(1, v); }
  $core.bool hasStatus() => $_has(0);
  void clearStatus() => clearField(1);
}

class ToggleReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ToggleReply')
    ..e<Status>(1, 'newStatus', $pb.PbFieldType.OE, Status.UNKNOWN, Status.valueOf, Status.values)
    ..hasRequiredFields = false
  ;

  ToggleReply() : super();
  ToggleReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ToggleReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ToggleReply clone() => ToggleReply()..mergeFromMessage(this);
  ToggleReply copyWith(void Function(ToggleReply) updates) => super.copyWith((message) => updates(message as ToggleReply));
  $pb.BuilderInfo get info_ => _i;
  static ToggleReply create() => ToggleReply();
  ToggleReply createEmptyInstance() => create();
  static $pb.PbList<ToggleReply> createRepeated() => $pb.PbList<ToggleReply>();
  static ToggleReply getDefault() => _defaultInstance ??= create()..freeze();
  static ToggleReply _defaultInstance;

  Status get newStatus => $_getN(0);
  set newStatus(Status v) { setField(1, v); }
  $core.bool hasNewStatus() => $_has(0);
  void clearNewStatus() => clearField(1);
}


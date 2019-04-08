///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class Status extends $pb.ProtobufEnum {
  static const Status UNKNOWN = Status._(0, 'UNKNOWN');
  static const Status ON = Status._(1, 'ON');
  static const Status OFF = Status._(2, 'OFF');

  static const $core.List<Status> values = <Status> [
    UNKNOWN,
    ON,
    OFF,
  ];

  static final $core.Map<$core.int, Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Status valueOf($core.int value) => _byValue[value];

  const Status._($core.int v, $core.String n) : super(v, n);
}

class ObjectType extends $pb.ProtobufEnum {
  static const ObjectType COMPUTER = ObjectType._(0, 'COMPUTER');
  static const ObjectType LIGHT = ObjectType._(1, 'LIGHT');

  static const $core.List<ObjectType> values = <ObjectType> [
    COMPUTER,
    LIGHT,
  ];

  static final $core.Map<$core.int, ObjectType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ObjectType valueOf($core.int value) => _byValue[value];

  const ObjectType._($core.int v, $core.String n) : super(v, n);
}


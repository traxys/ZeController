///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ON', '2': 1},
    const {'1': 'OFF', '2': 2},
  ],
};

const ObjectType$json = const {
  '1': 'ObjectType',
  '2': const [
    const {'1': 'COMPUTER', '2': 0},
    const {'1': 'LIGHT', '2': 1},
  ],
};

const ObjectSelector$json = const {
  '1': 'ObjectSelector',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.ObjectType', '10': 'type'},
    const {'1': 'id', '3': 2, '4': 1, '5': 13, '10': 'id'},
  ],
};

const StatusRequest$json = const {
  '1': 'StatusRequest',
  '2': const [
    const {'1': 'target', '3': 1, '4': 1, '5': 11, '6': '.ObjectSelector', '10': 'target'},
  ],
};

const StatusReply$json = const {
  '1': 'StatusReply',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.Status', '10': 'status'},
  ],
};

const ToggleReply$json = const {
  '1': 'ToggleReply',
  '2': const [
    const {'1': 'new_status', '3': 1, '4': 1, '5': 14, '6': '.Status', '10': 'newStatus'},
  ],
};


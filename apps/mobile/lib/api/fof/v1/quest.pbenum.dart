//
//  Generated code. Do not modify.
//  source: fof/v1/quest.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Quest status enumeration
class QuestStatus extends $pb.ProtobufEnum {
  static const QuestStatus QUEST_STATUS_UNSPECIFIED = QuestStatus._(0, _omitEnumNames ? '' : 'QUEST_STATUS_UNSPECIFIED');
  static const QuestStatus QUEST_STATUS_ACTIVE = QuestStatus._(1, _omitEnumNames ? '' : 'QUEST_STATUS_ACTIVE');
  static const QuestStatus QUEST_STATUS_COMPLETED = QuestStatus._(2, _omitEnumNames ? '' : 'QUEST_STATUS_COMPLETED');
  static const QuestStatus QUEST_STATUS_CANCELLED = QuestStatus._(3, _omitEnumNames ? '' : 'QUEST_STATUS_CANCELLED');

  static const $core.List<QuestStatus> values = <QuestStatus> [
    QUEST_STATUS_UNSPECIFIED,
    QUEST_STATUS_ACTIVE,
    QUEST_STATUS_COMPLETED,
    QUEST_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, QuestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static QuestStatus? valueOf($core.int value) => _byValue[value];

  const QuestStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TODOImpl _$$TODOImplFromJson(Map<String, dynamic> json) => _$TODOImpl(
      uid: json['uid'] as String,
      title: json['title'] as String? ?? '',
      importance:
          $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
              Importance.normal,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$$TODOImplToJson(_$TODOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'deadline': instance.deadline?.toIso8601String(),
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.normal: 'normal',
  Importance.high: 'high',
};

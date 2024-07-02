// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      text: json['text'] as String,
      importance:
          $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
              Importance.basic,
      deadline: _$JsonConverterFromJson<int, DateTime>(
          json['deadline'], const TimestampConverter().fromJson),
      done: json['done'] as bool? ?? false,
      color: json['color'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['created_at'], const TimestampConverter().fromJson),
      changedAt: _$JsonConverterFromJson<int, DateTime>(
          json['changed_at'], const TimestampConverter().fromJson),
      lastUpdatedBy: json['last_updated_by'] as String? ?? '0',
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'deadline': _$JsonConverterToJson<int, DateTime>(
          instance.deadline, const TimestampConverter().toJson),
      'done': instance.done,
      'color': instance.color,
      'created_at': const TimestampConverter().toJson(instance.createdAt),
      'changed_at': const TimestampConverter().toJson(instance.changedAt),
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.basic: 'basic',
  Importance.important: 'important',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

RevisedListTodoModel _$RevisedListTodoModelFromJson(
        Map<String, dynamic> json) =>
    RevisedListTodoModel(
      list: (json['list'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: (json['revision'] as num).toInt(),
    );

Map<String, dynamic> _$RevisedListTodoModelToJson(
        RevisedListTodoModel instance) =>
    <String, dynamic>{
      'list': instance.list,
      'revision': instance.revision,
    };

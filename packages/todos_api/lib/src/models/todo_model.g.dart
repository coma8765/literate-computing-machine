// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoModelImpl _$$TodoModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      createdAt: const TimestampConverter()
          .fromJson((json['created_at'] as num).toInt()),
      changedAt: const TimestampConverter()
          .fromJson((json['changed_at'] as num).toInt()),
      importance:
          $enumDecodeNullable(_$ImportanceModelEnumMap, json['importance']) ??
              ImportanceModel.basic,
      deadline: _$JsonConverterFromJson<int, DateTime>(
          json['deadline'], const TimestampConverter().fromJson),
      done: json['done'] as bool? ?? false,
      color: json['color'] as String?,
      lastUpdatedBy: json['last_updated_by'] as String? ?? '0',
      isRemoved: json['is_removed'] as bool? ?? false,
      isSynced: json['is_synced'] as bool? ?? false,
    );

Map<String, dynamic> _$$TodoModelImplToJson(_$TodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'created_at': const TimestampConverter().toJson(instance.createdAt),
      'changed_at': const TimestampConverter().toJson(instance.changedAt),
      'importance': _$ImportanceModelEnumMap[instance.importance]!,
      'deadline': _$JsonConverterToJson<int, DateTime>(
          instance.deadline, const TimestampConverter().toJson),
      'done': instance.done,
      'color': instance.color,
      'last_updated_by': instance.lastUpdatedBy,
      'is_removed': instance.isRemoved,
      'is_synced': instance.isSynced,
    };

const _$ImportanceModelEnumMap = {
  ImportanceModel.low: 'low',
  ImportanceModel.basic: 'basic',
  ImportanceModel.important: 'important',
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

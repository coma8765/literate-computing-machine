// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revised_list_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevisedListTodoModelImpl _$$RevisedListTodoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RevisedListTodoModelImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: (json['revision'] as num).toInt(),
    );

Map<String, dynamic> _$$RevisedListTodoModelImplToJson(
        _$RevisedListTodoModelImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'revision': instance.revision,
    };

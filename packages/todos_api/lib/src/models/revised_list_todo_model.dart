import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todos_api/src/models/todo_model.dart';

part 'revised_list_todo_model.freezed.dart';

part 'revised_list_todo_model.g.dart';

@freezed
class RevisedListTodoModel with _$RevisedListTodoModel {
  const factory RevisedListTodoModel({
    required List<TodoModel> list,
    required int revision,
  }) = _RevisedListTodoModel;

  factory RevisedListTodoModel.fromJson(Map<String, Object?> json) =>
      _$RevisedListTodoModelFromJson(json);
}

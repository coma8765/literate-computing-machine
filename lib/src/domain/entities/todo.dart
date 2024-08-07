import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todos_api/todos_api.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

part 'todo.freezed.dart';

/// A Entity with [Importance] variants of Todo.
enum Importance {
  /// [Importance] [low].
  low(0),

  /// [Importance] [basic].
  basic(1),

  /// [Importance] [high].
  high(2);

  const Importance(this.value);

  final num value;

  ImportanceModel toModel() {
    switch (this) {
      case Importance.low:
        return ImportanceModel.low;
      case Importance.basic:
        return ImportanceModel.basic;
      case Importance.high:
        return ImportanceModel.important;
    }
  }

  static Importance fromModel(ImportanceModel model) {
    switch (model) {
      case ImportanceModel.low:
        return Importance.low;
      case ImportanceModel.basic:
        return Importance.basic;
      case ImportanceModel.important:
        return Importance.high;
    }
  }
}

/// A Todo entity
@freezed
class Todo with _$Todo {
  /// This class creates instances of [Todo]
  factory Todo({
    required String id,
    required DateTime createdAt,
    required DateTime changedAt,
    @Default(false) bool done,
    @Default('') String text,
    @Default(Importance.basic) Importance importance,
    DateTime? deadline,
  }) = _Todo;

  const Todo._();

  /// This class creates instances of [Todo] with random [id]
  factory Todo.create({
    String? id,
    String text = '',
    bool done = false,
    Importance importance = Importance.basic,
    DateTime? deadline,
  }) =>
      Todo(
        id: id ?? const Uuid().v4(),
        text: text,
        done: done,
        importance: importance,
        deadline: deadline,
        createdAt: DateTime.now(),
        changedAt: DateTime.now(),
      );

  /// This class creates instances of [Todo] from json data
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  /// This class creates instances of [Todo] from [TodoModel]
  factory Todo.fromModel(TodoModel model) {
    return Todo(
      id: model.id,
      text: model.text,
      done: model.done,
      importance: Importance.fromModel(model.importance),
      deadline: model.deadline,
      createdAt: model.createdAt,
      changedAt: model.changedAt,
    );
  }

  /// This class creates instances of [TodoModel] from [Todo]
  TodoModel toModel() {
    return TodoModel(
      id: id,
      text: text,
      done: done,
      importance: importance.toModel(),
      deadline: deadline,
      createdAt: createdAt,
      changedAt: changedAt,
    );
  }

  static List<Todo> fromModelList(List<TodoModel> models) =>
      models.map(Todo.fromModel).toList();

  static List<TodoModel> toModelList(List<Todo> todos) =>
      todos.map((e) => e.toModel()).toList();
}

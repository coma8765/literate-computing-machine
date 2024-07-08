part of 'edit_todo_cubit.dart';

abstract class EditTodoState extends Equatable {
  const EditTodoState({required this.todoId});

  final String todoId;
}

class EditTodoInitialState extends EditTodoState {
  const EditTodoInitialState({required super.todoId});

  @override
  List<Object?> get props => [todoId];
}

class EditTodoLoadingState extends EditTodoState {
  const EditTodoLoadingState({required super.todoId});

  @override
  List<Object?> get props => [todoId];
}

class EditTodoEditableState extends EditTodoState {
  factory EditTodoEditableState({
    required Todo initialTodo,
  }) =>
      EditTodoEditableState._(
        todoId: initialTodo.id,
        initialTodo: initialTodo,
        text: initialTodo.text,
        importance: initialTodo.importance,
        deadline: initialTodo.deadline,
      );

  const EditTodoEditableState._({
    required super.todoId,
    required this.initialTodo,
    required this.text,
    required this.importance,
    required this.deadline,
  });

  final Todo initialTodo;
  final String text;
  final Importance importance;
  final DateTime? deadline;

  EditTodoState copyWith({
    Todo? initialTodo,
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    bool emptyDeadline = false,
  }) {
    return EditTodoEditableState._(
      initialTodo: initialTodo ?? this.initialTodo,
      todoId: this.initialTodo.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: emptyDeadline ? null : deadline ?? this.deadline,
    );
  }

  Todo get todo => initialTodo.copyWith(
        text: text,
        importance: importance,
        deadline: deadline,
      );

  @override
  List<Object?> get props => [todoId, initialTodo, text, importance, deadline];
}

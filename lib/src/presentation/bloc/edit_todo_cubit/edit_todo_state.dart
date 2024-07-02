part of 'edit_todo_cubit.dart';

class EditTodoState extends Equatable {
  factory EditTodoState({
    Todo? todo,
  }) {
    final obj = todo ?? Todo.create();

    return EditTodoState._(
      initialTodo: obj,
      text: obj.text,
      importance: obj.importance,
      deadline: obj.deadline,
      done: obj.done,
    );
  }

  const EditTodoState._({
    required this.initialTodo,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
  });

  final Todo initialTodo;

  final String text;
  final Importance importance;
  final DateTime? deadline;
  final bool done;

  EditTodoState copyWith({
    Todo? initialTodo,
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    bool emptyDeadline = false,
  }) {
    return EditTodoState._(
      initialTodo: initialTodo ?? this.initialTodo,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: emptyDeadline ? null : deadline ?? this.deadline,
      done: done ?? this.done,
    );
  }

  Todo get todo => initialTodo.copyWith(
        text: text,
        importance: importance,
        deadline: deadline,
      );

  @override
  List<Object?> get props => [initialTodo, text, importance, deadline, done];
}

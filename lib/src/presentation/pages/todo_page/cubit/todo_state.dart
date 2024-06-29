part of 'todo_cubit.dart';

class TodoState extends Equatable {
  factory TodoState({
    Todo? todo,
  }) {
    final obj = todo ?? Todo(text: '');

    return TodoState._(
      initialTodo: obj,
      text: obj.text,
      importance: obj.importance,
      deadline: obj.deadline,
      done: obj.done,
    );
  }

  const TodoState._({
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

  TodoState copyWith({
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    bool emptyDeadline = false,
  }) {
    return TodoState._(
      initialTodo: initialTodo,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: emptyDeadline ? null : deadline ?? this.deadline,
      done: done ?? this.done,
    );
  }

  @override
  List<Object?> get props => [initialTodo.id, text, importance, deadline, done];
}

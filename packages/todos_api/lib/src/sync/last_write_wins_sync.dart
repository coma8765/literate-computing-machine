import 'dart:collection';

import 'package:todos_api/src/models/models.dart';

List<TodoModel> lastWriteWinsSync({
  required List<TodoModel> oldTodos,
  required List<TodoModel> unsynchronizedTodos,
}) {
  final todos = HashMap<String, TodoModel>();
  for (final todo in oldTodos) {
    todos[todo.id] = todo;
  }

  for (final target in unsynchronizedTodos) {
    assert(
      !target.isSynced,
      'unexpected todo model, accepted only unsynchronized',
    );

    if (!todos.containsKey(target.id) && !target.isRemoved) {
      todos[target.id] = target;
    } else if (todos.containsKey(target.id) && target.isRemoved) {
      todos.remove(target.id);
    } else if (todos.containsKey(target.id) &&
        target.changedAt.isAfter(todos[target.id]!.changedAt)) {
      todos[target.id] = target;
    }
  }

  return todos.values.toList();
}

import 'dart:async';

import 'package:todos_api/todos_api.dart';

/// {@template todos_repository}
/// A repository that handles `todo` related requests.
/// {@endtemplate}
abstract class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository();

  /// Provides a [Stream] of all todos.
  Stream<List<TodoModel>> getTodos();

  /// Reloads a `todo`
  FutureOr<void> reload();

  /// Saves a [TodoModel].
  ///
  /// If a [todo] with the some id already exists, it will be replaces.
  FutureOr<void> saveTodo(TodoModel todo);

  /// Deletes the [TodoModel] with the given id.
  /// If no [TodoModel] with the given id exists,
  /// a [TodoNotFoundException] error is thrown.
  FutureOr<void> deleteTodo(String id);

  /// Closes a resources
  FutureOr<void> close();
}

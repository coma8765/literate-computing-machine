import 'dart:async';

import 'package:meta/meta.dart';
import 'package:todos_api/src/models/models.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  /// Provides a [Stream] of all todos.
  Stream<List<TodoModel>> getTodos();

  /// Reload a todos.
  FutureOr<void> reload();

  /// Saves a [todo]
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  FutureOr<void> saveTodo(TodoModel todo);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists,
  /// a [TodoNotFoundException] error is thrown.
  FutureOr<void> deleteTodo(String id);

  /// Closes the client and frees up any resources.
  FutureOr<void> close();

  /// Syncs objects
  FutureOr<void> sync(List<TodoModel> todos);

  /// Returns todos for sync
  FutureOr<List<TodoModel>> getUnsynchronizedTodos();
}

/// Error thrown when a [TodoModel] with a given id is not found.
@immutable
class TodoNotFoundException implements Exception {
  @override
  bool operator ==(Object other) => other is TodoNotFoundException;

  @override
  int get hashCode => 0;
}

/// {@template internal_todos_api_exception}
/// Error thrown when interface for incorrect
/// {@endtemplate}
@immutable
class InternalTodosApiException implements Exception {
  /// {@macro internal_todos_api_exception}
  const InternalTodosApiException(this.message);

  /// Some text for a error description
  final String message;

  @override
  String toString() {
    return 'Exception: $message';
  }

  @override
  bool operator ==(Object other) {
    return other is InternalTodosApiException && other.message == message;
  }

  @override
  int get hashCode => 0;
}

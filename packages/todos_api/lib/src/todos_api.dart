import 'package:todos_api/src/models/models.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  /// Provides a [Stream] of all todos.
  Stream<RevisedListTodo> getTodos();

  /// Reload a todos.
  Future<void> reload();

  /// Saves a [todo]
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Todo todo);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists,
  /// a [TodoNotFoundException] error is thrown.
  Future<void> deleteTodo(String id);

  /// Closes the client and frees up any resources.
  Future<void> close();
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}


/// Error thrown when iterface for incorrect
class InternalTodosApiException implements Exception {
  const InternalTodosApiException(this.message);

  final String message;

  @override
  String toString() {
    return 'Exception: $message';
  }
}

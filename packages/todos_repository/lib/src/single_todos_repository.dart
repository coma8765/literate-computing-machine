import 'dart:async';

import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/src/todos_repository.dart';

/// {@template single_todos_repository}
/// A repository that handles `todo` related requests.
/// With support single API.
/// {@endtemplate}
class SingleTodosRepository implements TodosRepository {
  /// {@macro single_todos_repository}
  const SingleTodosRepository({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  final TodosApi _todosApi;

  @override
  Stream<List<TodoModel>> getTodos() => _todosApi.getTodos();

  @override
  FutureOr<void> reload() => _todosApi.reload();

  @override
  FutureOr<void> saveTodo(TodoModel todo) => _todosApi.saveTodo(todo);

  @override
  FutureOr<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  @override
  FutureOr<void> close() => _todosApi.close();

  @override
  Future<void> sync() {
    throw UnimplementedError('unnecessary for single API');
  }
}

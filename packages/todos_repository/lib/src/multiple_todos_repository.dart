import 'dart:async';

import 'package:logging/logging.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/src/todos_repository.dart';

/// {@template multiple_todos_repository}
/// A repository that handles `todo` related requests.
/// With support some APIs.
///
/// Note: The main repository is the first one.
/// {@endtemplate}
class MultipleTodosRepository implements TodosRepository {
  /// {@macro multiple_todos_repository}
  MultipleTodosRepository({
    required List<TodosApi> todosApis,
  })  : assert(todosApis.isNotEmpty, 'unable create repository without APIs'),
        _todosApis = todosApis;

  final _logging = Logger('todos-repository');

  final List<TodosApi> _todosApis;

  TodosApi get _mainTodosApi => _todosApis.first;

  @override
  Stream<List<TodoModel>> getTodos() {
    _logging.finer('todos requested');

    return _mainTodosApi.getTodos();
  }

  @override
  FutureOr<void> reload() {
    _logging.finest('todos reload requested');

    return _todosApis
        .map((todosApi) => Future.value(todosApi.reload()))
        .toList()
        .first;
  }

  Future<T> _catchUnexpected<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (error, stack) {
      _logging.severe(error.toString(), error, stack);
      rethrow;
    }
  }

  @override
  Future<void> saveTodo(TodoModel todo) async {
    _logging.finest('todo(id=${todo.id}) save requested');

    return _catchUnexpected(
      () => Future.wait(
        _todosApis.map((todosApi) => Future.value(todosApi.saveTodo(todo))),
      ),
    );
  }

  @override
  Future<void> deleteTodo(String id) async {
    _logging.finest('todo(id=$id) remove requested');

    return _catchUnexpected(
      () => Future.wait(
        _todosApis.map(
          (todosApi) => Future.value(todosApi.deleteTodo(id)),
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    return _catchUnexpected(
      () => Future.wait(
        _todosApis.map(
          (todoApi) async => await todoApi.close(),
        ),
      ),
    );
  }
}

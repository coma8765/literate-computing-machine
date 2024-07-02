import 'package:todos_api/todos_api.dart';

/// {@template todos_repository}
/// A repository that handles `todo` related requests.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  final TodosApi _todosApi;

  /// Provides a [Stream] of all todos.
  Stream<RevisedListTodoModel> getTodos() => _todosApi.getTodos();

  /// Reloads a `todo`
  Future<void> reload() => _todosApi.reload();

  /// Saves a [TodoModel].
  ///
  /// If a [todo] with the some id already exists, it will be replaces.
  Future<void> saveTodo(TodoModel todo) => _todosApi.saveTodo(todo);

  /// Deletes the [TodoModel] with the given id.
  /// If no [TodoModel] with the given id exists,
  /// a [TodoNotFoundException] error is thrown.
  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);
}

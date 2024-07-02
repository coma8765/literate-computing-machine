import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exponential_back_off/exponential_back_off.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_api/todos_api.dart';

/// {@template remote_storage_todos_api}
/// A Flutter implementation of the TodosApi that uses remote storage.
/// {@endtemplate}
class RemoteStorageTodosApi extends TodosApi {
  /// {@macro remote_storage_todos_api}
  RemoteStorageTodosApi({
    required Dio dio,
  }) : _dio = dio {
    _init();
  }

  final _logger = Logger('remote-storage-todos-api');

  final Dio _dio;

  ExponentialBackOff _exponentialBackOff() => ExponentialBackOff(
        interval: const Duration(milliseconds: 100),
        maxDelay: const Duration(seconds: 15),
      );

  late final _todoStreamController =
      BehaviorSubject<RevisedListTodoModel>.seeded(
    const RevisedListTodoModel(list: [], revision: -1),
  );

  Future<RevisedListTodoModel> _getValue() async {
    _logger.shout('remote-storage-todos-api: request data');
    final backOff = _exponentialBackOff();

    final result = await backOff.start<Response<String>>(
      () => _dio.get<String>('/list'),
      retryIf: _retryIf,
      onRetry: (error) => _onRetry(error, backOff),
    );

    if (result.isLeft()) _onError(result.getLeftValue());

    final response = result.getRightValue();

    if (response.statusCode != 200) {
      final message =
          'invalid status code, expected 200 got ${response.statusCode}';
      _logger.warning(message);
      throw InternalTodosApiException(message);
    }

    if (response.data == null) {
      _logger.warning('invalid server response');
      throw const InternalTodosApiException(
        'invalid server response',
      );
    }

    final revisedListTodo = RevisedListTodoModel.fromJson(
      jsonDecode(response.data!) as Map<String, dynamic>,
    );

    return revisedListTodo;
  }

  Future<RevisedListTodoModel> _setValue(
    List<TodoModel> todos,
    int revision,
  ) async {
    _logger.shout('update data, old revision $revision');

    final backOff = _exponentialBackOff();

    final data = {'list': todos};

    final result = await backOff.start<Response<String>>(
      () => _dio.patch<String>(
        '/list',
        data: data,
        options: Options(
          headers: {
            'X-Last-Known-Revision': revision,
          },
        ),
      ),
      retryIf: _retryIf,
      onRetry: (error) => _onRetry(error, backOff),
    );

    if (result.isLeft()) _onError(result.getLeftValue());

    final response = result.getRightValue();

    if (response.statusCode != 200) {
      final message =
          'invalid status code, expected 200 got ${response.statusCode}';

      _logger.warning(message);
      throw InternalTodosApiException(message);
    }

    if (response.data == null) {
      _logger.warning('invalid server response');

      throw const InternalTodosApiException('invalid server response');
    }

    final revisedListTodo = RevisedListTodoModel.fromJson(
      jsonDecode(response.data!) as Map<String, dynamic>,
    );

    _logger.info('updated data, revision=${revisedListTodo.revision}.');
    return revisedListTodo;
  }

  Future<void> _init() async {
    final authHeader =
        _dio.options.headers[HttpHeaders.authorizationHeader].toString();

    _logger.config(
      'remote-storage-todos-api: setup '
      'baseUrl=${_dio.options.baseUrl}, '
      'auth=${authHeader.substring(0, (authHeader.length / 2).ceil())}.',
    );

    await reload();
  }

  @override
  Future<void> close() {
    _logger.info('remote-storage-todos-api: close stream');
    return _todoStreamController.close();
  }

  @override
  Future<void> deleteTodo(String id) async {
    _logger.shout('delete todo with id=$id');

    final todos = [..._todoStreamController.value.list];
    final revision = _todoStreamController.value.revision;

    final todoIndex = todos.indexWhere((t) => t.id == id);

    if (todoIndex >= 0) {
      todos.removeAt(todoIndex);
    } else {
      throw TodoNotFoundException();
    }

    final revisedListTodo = await _setValue(todos, revision);

    _todoStreamController.add(revisedListTodo);
  }

  @override
  Stream<RevisedListTodoModel> getTodos() =>
      _todoStreamController.asBroadcastStream();

  @override
  Future<void> saveTodo(TodoModel todo) async {
    _logger.shout('save todo $todo');

    final todos = [..._todoStreamController.value.list];
    final revision = _todoStreamController.value.revision;

    final todoIndex = todos.indexWhere((t) => t.id == todo.id);

    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }

    final revisedListTodo = await _setValue(todos, revision);

    _todoStreamController.add(revisedListTodo);
  }

  @override
  Future<void> reload() async {
    final todos = await _getValue();
    _todoStreamController.add(todos);
  }

  bool _retryIf(Exception e) =>
      e is IOException || e is InternalTodosApiException || e is DioException;

  void _onError(Exception error) {
    _logger.severe('api request failed', error);
    throw error;
  }

  void _onRetry(Exception error, BackOff backoff) {
    _logger.warning(
      'retry, '
      'attempt=${backoff.attemptCounter} '
      'error=$error '
      'current delay=${backoff.currentDelay} '
      'elapsed time=${backoff.elapsedTime}.',
    );
  }
}

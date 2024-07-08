import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
  })  : _dio = dio,
        _todoStreamController = BehaviorSubject<RevisedListTodoModel>() {
    _init();
  }

  final _logger = Logger('remote-storage-todos-api');

  final Dio _dio;

  final BehaviorSubject<RevisedListTodoModel> _todoStreamController;

  Future<RevisedListTodoModel?> _getValue() async {
    late Response<dynamic> response;

    try {
      response = await _dio
          .get<dynamic>('/list')
          .timeout(_dio.options.receiveTimeout ?? const Duration(minutes: 1));
    } on TimeoutException catch (e) {
      final message = 'fetch canceled by timeout(${e.duration})';

      _logger.info(message);
      _todoStreamController.addError(InternalTodosApiException(message));

      return null;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = 'invalid status code, expected 200 '
            'got ${e.response?.statusCode}';
        _logger.warning(message);
        _todoStreamController.addError(InternalTodosApiException(message));

        return null;
      }

      if (e.type == DioExceptionType.unknown) {
        _logger.severe('catch unknown dio exception ${e.error}');
        return null;
      }

      _logger.warning(e, e);
      _todoStreamController.addError(
        const InternalTodosApiException('fail to fetch'),
      );
      return null;
    }

    if (response.statusCode != 200) {
      final message =
          'invalid status code, expected 200 got ${response.statusCode}';
      _logger.warning(message);
      _todoStreamController.addError(InternalTodosApiException(message));
    }

    if (response.data == null) {
      const message = 'invalid server response';
      _logger.warning(message);
      _todoStreamController.addError(const InternalTodosApiException(message));
    }

    final revisedListTodo = RevisedListTodoModel.fromJson(
      response.data as Map<String, dynamic>,
    );

    return revisedListTodo;
  }

  Future<RevisedListTodoModel> _setValue(
    List<TodoModel> todos,
    int revision,
  ) async {
    final data = {'list': todos};

    late Response<String> response;

    try {
      response = await _dio
          .patch<String>(
            '/list',
            data: data,
            options: Options(
              headers: {
                ..._dio.options.headers,
                'X-Last-Known-Revision': revision,
              },
            ),
          )
          .timeout(_dio.options.receiveTimeout ?? const Duration(minutes: 1));
    } on TimeoutException catch (e) {
      final message = 'patch canceled by timeout(${e.duration})';

      _logger.info(message);
      throw InternalTodosApiException(message);
    } on Exception catch (e, trace) {
      final message = e.toString();

      _logger.warning(message, trace);
      throw InternalTodosApiException(message);
    }

    if (response.statusCode != 200) {
      final message =
          'invalid status code, expected 200 got ${response.statusCode}';

      _logger.warning(message);
      throw InternalTodosApiException(message);
    }

    if (response.data == null) {
      const message = 'invalid server response';
      _logger.warning(message);
      _todoStreamController.addError(const InternalTodosApiException(message));
    }

    final revisedListTodo = RevisedListTodoModel.fromJson(
      jsonDecode(response.data!) as Map<String, dynamic>,
    );

    _logger.finest(
      'fetch data, $revision->${revisedListTodo.revision} revision',
    );
    return revisedListTodo;
  }

  Future<void> _init() async {
    final authHeader =
        _dio.options.headers[HttpHeaders.authorizationHeader].toString();

    _logger.config(
      'remote-storage-todos-api: setup '
      'baseUrl=${_dio.options.baseUrl}, '
      'authToken='
      '${authHeader.substring(0, (authHeader.length / 2).ceil())}***.',
    );

    reload();
  }

  @override
  FutureOr<void> close() {
    _logger.config('close stream');
    return _todoStreamController.close();
  }

  @override
  FutureOr<void> deleteTodo(String id) async {
    _assertReady();

    final todos = [..._todoStreamController.value.list];
    final revision = _todoStreamController.value.revision;

    final todoIndex = todos.indexWhere((t) => t.id == id);

    if (todoIndex >= 0) {
      todos.removeAt(todoIndex);
    } else {
      throw TodoNotFoundException();
    }

    final revisedListTodo = await _setValue(todos, revision);

    _logger.finest('todo(id=$id) deleted, updating stream');
    _todoStreamController.add(revisedListTodo);
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return _todoStreamController.asBroadcastStream().map(
          (revisedListTodoModel) => revisedListTodoModel.list,
        );
  }

  void _assertReady() {
    assert(
      _todoStreamController.hasValue,
      'the state cannot be updated without any data',
    );
  }

  @override
  FutureOr<void> saveTodo(TodoModel todo) async {
    _assertReady();

    final todos = [..._todoStreamController.value.list];
    final revision = _todoStreamController.value.revision;

    final todoIndex = todos.indexWhere((t) => t.id == todo.id);

    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }

    final revisedListTodo = await _setValue(todos, revision);

    _logger.finest('todo(id=${todo.id}) saved, updating stream');

    _todoStreamController.add(revisedListTodo);
  }

  bool _loading = false;

  @override
  FutureOr<void> reload() async {
    late final RevisedListTodoModel? todos;
    if (_loading) {
      while (_loading) {
        await Future<void>.delayed(const Duration(microseconds: 500));
      }
      return;
    }

    _loading = true;
    try {
      todos = await _getValue();
    } finally {
      _loading = false;
    }

    if (todos != null) {
      _logger.finest('todos fetched, updating stream');
      _todoStreamController.add(todos);
    } else {
      _logger.info("todos don't fetched");
    }
  }

  @override
  FutureOr<void> sync(List<TodoModel> todos) async {
    _assertReady();

    final todosToSave = todos
        .map((todo) {
          return todo.copyWith(isSynced: true);
        })
        .where((t) => !t.isRemoved)
        .toList();

    _logger.info('sync todo, count=${todosToSave.length}');

    await _setValue(todosToSave, _todoStreamController.value.revision);
  }

  @override
  FutureOr<List<TodoModel>> getUnsynchronizedTodos() async {
    final result = await _getValue();

    if (result == null) {
      throw const InternalTodosApiException("todos don't fetched");
    }

    return result.list;
  }
}

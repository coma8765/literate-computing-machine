import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_api/todos_api.dart';

/// {@template local_storage_todos_api}
/// A Flutter implementation of the TodosApi that uses local storage.
/// {@endtemplate}
class LocalStorageTodosApi extends TodosApi {
  /// {@macro local_storage_todos_api}
  LocalStorageTodosApi({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  final _logger = Logger('local-storage-todos-api');

  final SharedPreferences _plugin;

  late final _todoStreamController = BehaviorSubject<List<TodoModel>>();

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    reload();
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return _todoStreamController
        .asBroadcastStream()
        .map((todos) => todos.where((todo) => !todo.isRemoved).toList());
  }

  @override
  FutureOr<void> saveTodo(TodoModel todo) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todo.id);

    final todoToSave = todo.copyWith(isSynced: false);

    if (todoIndex >= 0) {
      todos[todoIndex] = todoToSave;
    } else {
      todos.add(todoToSave);
    }

    await _setValue(kTodosCollectionKey, jsonEncode(todos));

    _logger.finest('todo(id=${todo.id}) saved, updating stream');

    _todoStreamController.add(todos);
  }

  @override
  FutureOr<void> reload() {
    final todosJson = _getValue(kTodosCollectionKey);

    _logger.finest('todos fetched, updating stream');
    if (todosJson != null) {
      final todos = List<Map<String, dynamic>>.from(
        jsonDecode(todosJson) as List,
      ).map(TodoModel.fromJson).toList();

      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

  @override
  FutureOr<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);

    if (todoIndex == -1) {
      throw TodoNotFoundException();
    }

    todos[todoIndex] = todos[todoIndex].copyWith(
      isRemoved: true,
      isSynced: false,
    );

    await _setValue(kTodosCollectionKey, jsonEncode(todos));
    _logger.finest('todo(id=$id) deleted, updating stream');

    _todoStreamController.add(todos);
  }

  @override
  FutureOr<List<TodoModel>> getUnsynchronizedTodos() {
    return _todoStreamController.value;
  }

  @override
  FutureOr<void> close() {
    _logger.finest('close stream');
    return _todoStreamController.close();
  }

  @override
  FutureOr<void> sync(List<TodoModel> todos) async {
    final todosToSave = todos.map((todo) {
      return todo.copyWith(
        isSynced: true,
      );
    }).toList();

    await _setValue(kTodosCollectionKey, jsonEncode(todosToSave));

    // final todos = lastWriteWinsSync(
    //   oldTodos: _todoStreamController.value,
    //   unsynchronizedTodos: unsynchronizedTodos,
    // )
    //     .map(
    //       (todo) => todo.copyWith(
    //         isSynced: true,
    //         changedAt: todo.changedAt,
    //       ),
    //     )
    //     .toList();
    //
    // await _setValue(kTodosCollectionKey, jsonEncode(todos));
  }
}

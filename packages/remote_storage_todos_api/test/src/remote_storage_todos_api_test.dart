// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_storage_todos_api/remote_storage_todos_api.dart';
import 'package:todos_api/todos_api.dart';

void main() {
  final dotenv = DotEnv()..load();
  final baseUrl = dotenv['API_URI'] ?? '';
  final headers = {
    HttpHeaders.authorizationHeader: dotenv['API_AUTH'],
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      validateStatus: (_) => true,
    ),
  );

  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
      () => HttpClient()..badCertificateCallback = (cert, host, port) => true;

  group('RemoteStorageTodosApi', () {
    final adapter = RemoteStorageTodosApi(dio: dio);

    test('can be get RevisedListTodoModel', () async {
      expect(adapter, isNotNull);
    });

    test('can be get todos', () async {
      final stream = adapter.getTodos();

      await stream.firstWhere((data) {
        return data.revision >= 0;
      });
    });

    final todo = TodoModel(text: 'bla?');

    late final RevisedListTodoModel initData;
    late final Stream<RevisedListTodoModel> stream;

    test('can be add item', () async {
      stream = adapter.getTodos();

      initData = await stream.firstWhere((data) {
        return data.revision >= 0;
      });

      await adapter.saveTodo(todo);

      // Save check add a new todo
      await stream.firstWhere((data) {
        return data.list.indexWhere((t) => t.id == todo.id) >= 0;
      });
    });

    test('can be update item', () async {
      final updatedTodo = todo.copyWith(
        text: 'updated',
        importance: Importance.important,
        done: true,
      );

      await adapter.saveTodo(updatedTodo);

      // Check updated a new todo
      await stream.firstWhere((data) {
        if (data.revision <= initData.revision) return false;

        final todoIndex = data.list.indexWhere((t) => t.id == todo.id);

        if (todoIndex == -1) return false;

        return data.list[todoIndex] == updatedTodo;
      });
    });

    test('can be remove item', () async {
      await adapter.deleteTodo(todo.id);

      // Check deleted a new todo
      await stream.firstWhere((data) {
        return data.revision > initData.revision &&
            data.list.indexWhere((t) => t.id == todo.id) == -1;
      });
    });

    test('can be thrown not found error', () async {
      expect(
        () => adapter.deleteTodo(TodoModel(text: 'text').id),
        throwsA(isA<TodoNotFoundException>()),
      );
    });
  });
}

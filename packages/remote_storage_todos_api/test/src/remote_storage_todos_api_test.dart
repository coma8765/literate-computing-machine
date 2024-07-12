import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:remote_storage_todos_api/remote_storage_todos_api.dart';
import 'package:todos_api/models_factory.dart';
import 'package:todos_api/todos_api.dart';

void main() {
  const baseUrl = 'https://example.com';

  group('RemoteStorageTodosApi', () {
    const todoModelFactory = TodoModelFactory();

    late Dio dio;
    late DioAdapter dioAdapter;
    late TodosApi todosApi;

    setUp(() {
      dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          validateStatus: (status) => true,
        ),
      );
      dioAdapter = DioAdapter(
        dio: dio,
      );
      todosApi = RemoteStorageTodosApi(dio: dio);
    });

    test('todo can be got empty list', () async {
      dioAdapter.onGet(
        '/list',
        (server) => server.reply(
          200,
          <String, dynamic>{
            'status': 'ok',
            'list': <void>[],
            'revision': 1, // ревизия данных
          },
        ),
      );

      expect(
        todosApi.getTodos(),
        emitsInOrder([
          <TodoModel>[],
        ]),
      );
    });

    test('todo can be got list with one item', () async {
      final todo = todoModelFactory.generateFake();

      dioAdapter.onGet(
        '/list',
        (server) => server.reply(
          200,
          <String, dynamic>{
            'status': 'ok',
            'list': [
              todo.toJson(),
            ],
            'revision': 1, // ревизия данных
          },
        ),
      );

      expect(
        todosApi.getTodos(),
        emitsInOrder([
          <TodoModel>[todo],
        ]),
      );
    });

    test('todo can be created', () async {
      final todo = todoModelFactory.generateFake();

      dioAdapter
        ..onGet(
          '/list',
          (server) => server.reply(
            200,
            <String, dynamic>{
              'status': 'ok',
              'list': <void>[],
              'revision': 1, // ревизия данных
            },
          ),
        )
        ..onPatch(
          '/list',
          data: {
            'list': [todo],
          },
          headers: {'X-Last-Known-Revision': 1},
          (server) => server.reply(
            200,
            <String, dynamic>{
              'status': 'ok',
              'list': [
                todo.toJson(),
              ],
              'revision': 2, // ревизия данных
            },
          ),
        );

      final stream = todosApi.getTodos();

      unawaited(
        expectLater(
          stream,
          emitsInOrder([
            <TodoModel>[],
            <TodoModel>[todo],
          ]),
        ),
      );

      await stream.first;
      await todosApi.saveTodo(todo);
    });

    test('todo can be updated', () async {
      final createdAt = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
      );

      final todo = todoModelFactory.generateFake();

      final updatedTodo = todo.copyWith(
        text: 'updated',
        importance: ImportanceModel.low,
        done: true,
        changedAt: createdAt.add(const Duration(minutes: 5)),
      );

      dioAdapter
        ..onGet(
          '/list',
          (server) => server.reply(
            200,
            <String, dynamic>{
              'status': 'ok',
              'list': [
                todo.toJson(),
              ],
              'revision': 1, // ревизия данных
            },
          ),
        )
        ..onPatch(
          '/list',
          data: {
            'list': [updatedTodo],
          },
          headers: {'X-Last-Known-Revision': 1},
          (server) {
            return server.reply(
              200,
              <String, dynamic>{
                'status': 'ok',
                'list': [
                  updatedTodo.toJson(),
                ],
                'revision': 2, // ревизия данных
              },
            );
          },
        );

      final stream = todosApi.getTodos();

      unawaited(
        expectLater(
          stream,
          emitsInOrder([
            <TodoModel>[todo],
            <TodoModel>[updatedTodo],
          ]),
        ),
      );

      await stream.first;
      await todosApi.saveTodo(updatedTodo);
    });

    test('todo can be deleted', () async {
      final todo = todoModelFactory.generateFake();

      dioAdapter
        ..onGet(
          '/list',
          (server) => server.reply(
            200,
            <String, dynamic>{
              'status': 'ok',
              'list': [
                todo.toJson(),
              ],
              'revision': 1, // ревизия данных
            },
          ),
        )
        ..onPatch(
          '/list',
          data: {
            'list': <TodoModel>[],
          },
          headers: {'X-Last-Known-Revision': 1},
          (server) {
            return server.reply(
              200,
              <String, dynamic>{
                'status': 'ok',
                'list': <TodoModel>[],
                'revision': 2, // ревизия данных
              },
            );
          },
        );

      final stream = todosApi.getTodos();

      unawaited(
        expectLater(
          stream,
          emitsInOrder([
            <TodoModel>[todo],
            <TodoModel>[],
          ]),
        ),
      );

      await stream.first;
      await todosApi.deleteTodo(todo.id);
    });

    test('todo can be thrown error 500 status code on read', () async {
      final todo = todoModelFactory.generateFake();

      dioAdapter.onGet(
        '/list',
        (server) => server.reply(
          500,
          <String, dynamic>{
            'status': 'ok',
            'list': [
              todo.toJson(),
            ],
            'revision': 1, // ревизия данных
          },
        ),
      );

      final stream = todosApi.getTodos();

      unawaited(
        expectLater(
          stream,
          emitsError(
            const InternalTodosApiException(
              'invalid status code, expected 200 got 500',
            ),
          ),
        ),
      );
    });

    test(
      'todo can be thrown NotFoundTodoException status code on delete',
      () async {
        final todo = todoModelFactory.generateFake();

        dioAdapter.onGet(
          '/list',
          (server) => server.reply(
            200,
            <String, dynamic>{
              'status': 'ok',
              'list': [
                todo.toJson(),
              ],
              'revision': 1, // ревизия данных
            },
          ),
        );

        final stream = todosApi.getTodos();

        unawaited(
          expectLater(
            stream,
            emitsInOrder([
              <TodoModel>[todo],
            ]),
          ),
        );

        await stream.first;
        expect(
          () => todosApi.deleteTodo('invalid-id'),
          throwsA(
            TodoNotFoundException(),
          ),
        );
      },
    );

    test('todo can be thrown error 500 status code on edit', () async {
      final todo = todoModelFactory.generateFake();

      dioAdapter
        ..onGet(
          '/list',
          (server) => server.reply(
            200,
            <String, dynamic>{
              'status': 'ok',
              'list': [
                todo.toJson(),
              ],
              'revision': 1, // ревизия данных
            },
          ),
        )
        ..onPatch(
          '/list',
          data: {
            'list': <TodoModel>[],
          },
          headers: {'X-Last-Known-Revision': 1},
          (server) => server.reply(
            500,
            <String, dynamic>{
              'status': 'ok',
              'list': <TodoModel>[],
              'revision': 2, // ревизия данных
            },
          ),
        );

      final stream = todosApi.getTodos();

      unawaited(
        expectLater(
          stream,
          emitsInOrder([
            <TodoModel>[todo],
          ]),
        ),
      );

      await stream.first;

      expect(
        () => todosApi.deleteTodo(todo.id),
        throwsA(
          const InternalTodosApiException(
            'invalid status code, expected 200 got 500',
          ),
        ),
      );
    });
  });
}

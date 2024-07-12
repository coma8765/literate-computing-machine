import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:todos_api/models_factory.dart';
import 'package:todos_api/todos_api.dart';

void main() {
  group('LocalStorageTodosApi', () {
    const todoModelFactory = TodoModelFactory();

    late SharedPreferences sharedPreferences;
    late TodosApi todosApi;

    setUp(() async {
      SharedPreferences.setMockInitialValues({}); //set values here
      sharedPreferences = await SharedPreferences.getInstance();
    });

    tearDown(() async {
      await sharedPreferences.remove(LocalStorageTodosApi.kTodosCollectionKey);
      await todosApi.close();
    });

    test('can be instantiated', () async {
      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      expect(
        todosApi,
        isA<TodosApi>(),
      );
    });

    test('todo can be got empties', () async {
      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      expect(
        todosApi.getTodos(),
        emits(const <List<TodoModel>>[]),
      );
    });

    test('todos can be got initial', () async {
      final todos = todoModelFactory.generateFakeList(length: 1);

      await sharedPreferences.setString(
        LocalStorageTodosApi.kTodosCollectionKey,
        jsonEncode(todos.map((todo) => todo.toJson()).toList()),
      );

      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      final stream = todosApi.getTodos();
      unawaited(
        expectLater(
          stream,
          emitsInOrder([
            todos,
          ]),
        ),
      );
    });

    test('todos can be reloaded', () async {
      final todos = todoModelFactory.generateFakeList(length: 1);

      await sharedPreferences.setString(
        LocalStorageTodosApi.kTodosCollectionKey,
        jsonEncode(todos.map((todo) => todo.toJson()).toList()),
      );

      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      final stream = todosApi.getTodos();
      unawaited(
        expectLater(
          stream,
          emitsInOrder([
            todos,
            todos,
          ]),
        ),
      );

      await stream.first;
      await todosApi.reload();
    });

    test('todo can be created', () async {
      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);
      final todo = todoModelFactory.generateFake();

      unawaited(
        expectLater(
          todosApi.getTodos(),
          emitsInOrder([
            const <TodoModel>[],
            [todo],
          ]),
        ),
      );

      await todosApi.saveTodo(todo);
    });

    test('todos can be created', () async {
      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);
      const countTodos = 3;

      final todos = todoModelFactory.generateFakeList(length: countTodos);

      unawaited(
        expectLater(
          todosApi.getTodos(),
          emitsInOrder([
            const <List<TodoModel>>[],
            ...List.generate(
              todos.length,
              (index) => todos.sublist(0, index + 1),
            ),
          ]),
        ),
      );

      for (final todo in todos) {
        await todosApi.saveTodo(todo);
      }
    });

    test('todo can be updated', () async {
      final todo = todoModelFactory.generateFake();
      final updatedTodo = todo.copyWith(
        text: 'updated',
        deadline: DateTime.now(),
        importance: ImportanceModel.important,
      );

      await sharedPreferences.setString(
        LocalStorageTodosApi.kTodosCollectionKey,
        jsonEncode([todo.toJson()]),
      );

      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      unawaited(
        expectLater(
          todosApi.getTodos(),
          emitsInOrder([
            [todo],
            [updatedTodo],
          ]),
        ),
      );

      await todosApi.saveTodo(updatedTodo);
    });

    test('todo can be deleted', () async {
      final todo = todoModelFactory.generateFake();

      await sharedPreferences.setString(
        LocalStorageTodosApi.kTodosCollectionKey,
        jsonEncode([todo.toJson()]),
      );

      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      unawaited(
        expectLater(
          todosApi.getTodos(),
          emitsInOrder([
            [todo],
            const <List<TodoModel>>[],
          ]),
        ),
      );

      await todosApi.deleteTodo(todo.id);
    });
    test('todo can be thrown TodoNotFoundException on delete', () async {
      final todo = todoModelFactory.generateFake();

      await sharedPreferences.setString(
        LocalStorageTodosApi.kTodosCollectionKey,
        jsonEncode([todo.toJson()]),
      );

      todosApi = LocalStorageTodosApi(plugin: sharedPreferences);

      unawaited(
        expectLater(
          todosApi.getTodos(),
          emitsInOrder([
            [todo],
          ]),
        ),
      );

      expect(
        () => todosApi.deleteTodo('invalid-id'),
        throwsA(
          TodoNotFoundException(),
        ),
      );
    });
  });
}

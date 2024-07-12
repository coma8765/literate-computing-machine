// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/src/multiple_todos_repository.dart';
import 'package:todos_repository/src/single_todos_repository.dart';

class MockTodosApi extends TodosApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('MultipleTodosRepository', () {
    test('Can be init', () {
      MultipleTodosRepository(
        todosApis: [
          MockTodosApi(),
          MockTodosApi(),
        ],
      );
    });
  });
  group('SingleTodosRepository', () {
    test('Can be init', () {
      SingleTodosRepository(todosApi: MockTodosApi());
    });
  });
}

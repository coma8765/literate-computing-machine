import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todos_repository/todos_repository.dart';

part 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required TodosRepository todosRepository,
    required Analytics analytics,
  })  : _todosRepository = todosRepository,
        _analytics = analytics,
        super(const HomeState()) {
    on<HomeSubscriptionRequested>(_onSubscriptionRequested);
    on<HomeShowAllToggled>(_onHomeShowAllToggled);
    on<HomeTodoDeleted>(_onHomeTodoDeleted);
    on<HomeTodoDoneToggled>(_onHomeTodoDoneToggled);
  }

  final TodosRepository _todosRepository;
  final Analytics _analytics;

  Future<void> _onSubscriptionRequested(
    HomeSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));

    await emit.forEach<List<TodoModel>>(
      _todosRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => HomeStatus.success,
        todos: () => Todo.fromModelList(todos),
      ),
      onError: (_, __) => state.copyWith(
        status: () => HomeStatus.failure,
      ),
    );
  }

  Future<void> _onHomeShowAllToggled(
    HomeShowAllToggled event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        showAll: () => event.showAll,
      ),
    );
  }

  Future<void> _onHomeTodoDeleted(
    HomeTodoDeleted event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        todos: () => state.todos.where((t) => t.id != event.todo.id).toList(),
      ),
    );

    await _deleteTodo(event.todo);
  }

  FutureOr<void> _onHomeTodoDoneToggled(
    HomeTodoDoneToggled event,
    Emitter<HomeState> emit,
  ) async {
    final todo = event.todo.copyWith(
      done: event.isDone,
      changedAt: DateTime.now().copyWith(microsecond: 0),
    );

    emit(
      state.copyWith(
        todos: () {
          final index = state.todos.indexWhere((t) => t.id == event.todo.id);

          final todos = [...state.todos];
          todos[index] = todo;
          return todos;
        },
      ),
    );

    await _saveTodo(todo);
  }

  Future<void> _saveTodo(Todo todo) async {
    await _todosRepository.saveTodo(todo.toModel());
    await _analytics.reportTodoSave(todoId: todo.id);
  }

  Future<void> _deleteTodo(Todo todo) async {
    await _todosRepository.deleteTodo(todo.id);
    await _analytics.reportTodoDelete(todoId: todo.id);
  }
}

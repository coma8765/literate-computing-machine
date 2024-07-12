import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todos_repository/todos_repository.dart';

part 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const HomeState()) {
    on<HomeSubscriptionRequested>(_onSubscriptionRequested);
    on<HomeShowAllToggled>(_onHomeShowAllToggled);
    on<HomeTodoDeleted>(_onHomeTodoDeleted);
    on<HomeTodoDoneToggled>(_onHomeTodoDoneToggled);
    on<HomeTodoSave>(_onHomeTodoSave);
  }

  final TodosRepository _todosRepository;

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

    await _todosRepository.reload();
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

    await _todosRepository.deleteTodo(event.todo.id);
  }

  FutureOr<void> _onHomeTodoDoneToggled(
    HomeTodoDoneToggled event,
    Emitter<HomeState> emit,
  ) {
    final todo = event.todo.copyWith(
      done: event.isDone,
      changedAt: DateTime.now().copyWith(microsecond: 0),
    );

    _todosRepository.saveTodo(todo.toModel());

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
  }

  FutureOr<void> _onHomeTodoSave(HomeTodoSave event, Emitter<HomeState> emit) {
    final todos = [...state.todos];
    final index = todos.indexWhere((t) => t.id == event.todo.id);

    if (index >= 0) {
      todos[index] = event.todo;
    } else {
      todos.add(event.todo);
    }

    emit(
      state.copyWith(
        todos: () => todos,
      ),
    );

    _todosRepository.saveTodo(event.todo.toModel());
  }
}

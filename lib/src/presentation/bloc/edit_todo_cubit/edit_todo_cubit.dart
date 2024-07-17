import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({
    required String todoId,
    required TodosRepository todosRepository,
    required Analytics analytics,
  })  : _todosRepository = todosRepository,
        _analytics = analytics,
        super(EditTodoInitialState(todoId: todoId));

  final TodosRepository _todosRepository;
  final Analytics _analytics;

  Future<void> loadTodo() async {
    emit(EditTodoLoadingState(todoId: state.todoId));

    final todos = await _todosRepository.getTodos().first;

    final todoModel = todos
        .where(
          (t) => t.id == state.todoId,
        )
        .singleOrNull;

    emit(
      EditTodoEditableState(
        initialTodo: todoModel != null
            ? Todo.fromModel(todoModel)
            : Todo.create(id: state.todoId),
        created: todoModel == null,
      ),
    );
  }

  EditTodoEditableState get _editableState {
    assert(
      state is EditTodoEditableState,
      'unable to save todo without editable event',
    );
    return state as EditTodoEditableState;
  }

  FutureOr<void> saveAction() async {
    final created = _editableState.created;
    final todo = _editableState.todo.copyWith(
      changedAt: DateTime.now(),
    );

    emit(EditTodoEditableState(initialTodo: todo));

    await _todosRepository.saveTodo(todo.toModel());
    await _analytics.reportTodoSave(todoId: todo.id, created: created);
  }

  void setText(String text) => emit(_editableState.copyWith(text: text));

  void setImportance(Importance importance) =>
      emit(_editableState.copyWith(importance: importance));

  void setDeadline(DateTime? deadline) =>
      emit(_editableState.copyWith(deadline: deadline));

  void emptyDeadline() => emit(_editableState.copyWith(emptyDeadline: true));

  Future<void> deleteAction() async {
    emit(EditTodoInitialState(todoId: state.todoId));

    await _todosRepository.deleteTodo(state.todoId);
    await _analytics.reportTodoDelete(todoId: state.todoId);
  }
}

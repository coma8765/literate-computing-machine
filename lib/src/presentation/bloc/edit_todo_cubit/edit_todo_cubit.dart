import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  // TODO(coma8765): add save action
  EditTodoCubit({
    required TodosRepository todosRepository,
    required String todoId,
  })  : _todosRepository = todosRepository,
        super(EditTodoInitialState(todoId: todoId));

  final TodosRepository _todosRepository;

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

  FutureOr<void> saveAction() {
    final todo = _editableState.todo.copyWith(
      changedAt: DateTime.now(),
    );

    emit(EditTodoEditableState(initialTodo: todo));
    return _todosRepository.saveTodo(todo.toModel());
  }

  void setText(String text) => emit(_editableState.copyWith(text: text));

  void setImportance(Importance importance) =>
      emit(_editableState.copyWith(importance: importance));

  void setDeadline(DateTime? deadline) =>
      emit(_editableState.copyWith(deadline: deadline));

  void emptyDeadline() => emit(_editableState.copyWith(emptyDeadline: true));
}

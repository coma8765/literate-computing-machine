import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todos_repository/src/todos_repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  // TODO(coma8765): add save action
  EditTodoCubit({
    required TodosRepository todosRepository,
    Todo? initialTodo,
  })  : _todosRepository = todosRepository,
        super(EditTodoState(todo: initialTodo));

  final TodosRepository _todosRepository;

  Future<void> saveAction() {
    emit(EditTodoState(todo: state.todo));
    return _todosRepository.saveTodo(state.todo.toModel());
  }

  void setText(String text) => emit(state.copyWith(text: text));

  void setImportance(Importance importance) =>
      emit(state.copyWith(importance: importance));

  void setDeadline(DateTime? deadline) =>
      emit(state.copyWith(deadline: deadline));

  void emptyDeadline() => emit(state.copyWith(emptyDeadline: true));
}

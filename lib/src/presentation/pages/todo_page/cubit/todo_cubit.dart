import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_api/todos_api.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({Todo? initialTodo}) : super(TodoState(todo: initialTodo));

  void setText(String text) => emit(state.copyWith(text: text));

  void setImportance(Importance importance) =>
      emit(state.copyWith(importance: importance));

  void setDeadline(DateTime? deadline) =>
      emit(state.copyWith(deadline: deadline));

  void emptyDeadline() =>
      emit(state.copyWith(emptyDeadline: true));
}

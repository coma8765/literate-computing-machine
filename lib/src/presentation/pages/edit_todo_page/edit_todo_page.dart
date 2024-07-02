import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todo/src/presentation/bloc/bloc.dart';

import 'package:todo/src/presentation/pages/edit_todo_page/edit_todo_view.dart';
import 'package:todos_repository/todos_repository.dart';

/// Show a pop-up window for some TODO
Future<Todo?> showTODOPage(
  BuildContext context,
  Todo todo,
) {
  return showCupertinoModalPopup<Todo>(
    context: context,
    builder: (BuildContext context) {
      return TodoPage(
        todo: todo,
        key: ValueKey(todo.id),
      );
    },
  );
}

class TodoPage extends StatelessWidget {
  const TodoPage({required this.todo, super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditTodoCubit(
        initialTodo: todo,
        todosRepository: context.read<TodosRepository>(),
      ),
      child: const TODOView(),
    );
  }
}

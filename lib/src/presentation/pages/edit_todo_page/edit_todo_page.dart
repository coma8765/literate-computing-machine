import 'package:analytics/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/navigation/app_router_delegate.dart';
import 'package:todo/src/presentation/bloc/bloc.dart';

import 'package:todo/src/presentation/pages/edit_todo_page/edit_todo_view.dart';
import 'package:todos_repository/todos_repository.dart';

/// Show a pop-up window for some TODO
void showTODOPage(
  BuildContext context,
  String? todoId,
) {
  final routeDelegate = Router.of(context).routerDelegate;
  assert(routeDelegate is AppRouterDelegate, 'support only AppRouterDelegate');
  if (routeDelegate is AppRouterDelegate) routeDelegate.editTodoTrigger(todoId);
}

class TodoPage extends StatelessWidget {
  const TodoPage({required this.todoId, super.key});

  final String todoId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditTodoCubit(
        todoId: todoId,
        todosRepository: context.read<TodosRepository>(),
        analytics: Analytics.of(context),
      )..loadTodo(),
      lazy: false,
      child: BlocBuilder<EditTodoCubit, EditTodoState>(
        builder: (context, state) {
          if (state is EditTodoEditableState) {
            return const TODOView();
          }

          if (state is EditTodoLoadingState) {
            return const CupertinoActivityIndicator();
          }

          return Container();
        },
      ),
    );
  }
}

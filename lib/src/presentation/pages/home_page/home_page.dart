import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/presentation/bloc/bloc.dart';
import 'package:todo/src/presentation/pages/home_page/home_page_view.dart';
import 'package:todos_repository/todos_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const HomeSubscriptionRequested()),
      child: const HomeView(),
    );
  }
}

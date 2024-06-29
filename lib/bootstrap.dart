import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/core/bloc/app_bloc_observer.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

Future<void> bootstrap({required TodosApi todosApi}) async {
  // await SentryFlutter.init(
  //       (options) {
  //     options.dsn = Config().sentryDsn;
  //   },
  //   appRunner: () async {
  final todosRepository = TodosRepository(todosApi: todosApi);
  // await initializeDateFormatting('ru', 'en');

  Bloc.observer = const AppBlocObserver();

  runApp(
    App(todosRepository: todosRepository),
  );
  // },
  // );
}

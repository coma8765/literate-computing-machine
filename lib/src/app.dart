import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/presentation/pages/home_page/home_page.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({required this.todosRepository, super.key});

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todosRepository,
      child: const AppView(),
    );
  }
}

const _defaultLocale = Locale('ru');
const _supportedLocales = [
  Locale('ru'),
  Locale('en'),
];

const _localeDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultWidgetsLocalizations.delegate,
];

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'TODO',
      color: AppTheme().scaffoldBackgroundColor,
      theme: AppTheme(),
      localizationsDelegates: _localeDelegates,
      home: const HomePage(),
      supportedLocales: _supportedLocales,
      locale: _defaultLocale,
    );
  }
}

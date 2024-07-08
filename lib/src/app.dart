import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:network_state_provider/network_state_provider.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/navigation/app_route_navigation_parser.dart';
import 'package:todo/src/navigation/app_router_delegate.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.todosRepository,
    required this.networkStateProducers,
    super.key,
  });

  final TodosRepository todosRepository;
  final List<NetworkStateProducer> networkStateProducers;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(value: todosRepository),
      ],
      child: NetworkStateProvider(
        producers: networkStateProducers,
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({super.key});

  final _routerDelegate = AppRouterDelegate();
  final _routeInformationParser = AppRouterParser();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'TODO',
      color: AppTheme().scaffoldBackgroundColor,
      theme: AppTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

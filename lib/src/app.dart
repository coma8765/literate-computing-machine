import 'package:analytics/analytics_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:network_state_provider/network_state_provider.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/navigation/app_route_navigation_parser.dart';
import 'package:todo/src/navigation/app_router_delegate.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.todosRepository,
    required this.networkStateProducers,
    required this.configSource,
    required this.analytics,
    super.key,
  });

  final TodosRepository todosRepository;
  final List<NetworkStateProducer> networkStateProducers;
  final ConfigSource configSource;
  final Analytics analytics;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Config>(
      stream: configSource.getConfig(),
      initialData: configSource.getSingleConfig(),
      builder: (context, snapshot) => ConfigProvider(
        config: snapshot.requireData,
        child: AnalyticsProvider(
          analytics: analytics,
          child: MultiBlocProvider(
            providers: [
              RepositoryProvider.value(value: todosRepository),
            ],
            child: NetworkStateProvider(
              producers: networkStateProducers,
              child: AppView(analytics: analytics),
            ),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({
    required Analytics analytics,
    super.key,
  }) : _routerDelegate = AppRouterDelegate(analytics: analytics);

  final AppRouterDelegate _routerDelegate;
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

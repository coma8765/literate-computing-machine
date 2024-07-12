import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_state_provider/network_state_provider.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todos_repository/todos_repository.dart';

void bootstrap({
  required FutureOr<Config> Function() getConfig,
  required FutureOr<BlocObserver> Function() getBlocObserver,
  required FutureOr<List<TodosApi>> Function({
    required Config config,
    required Dio dio,
  }) getTodosApis,
  required Dio Function({
    required Config config,
  }) getDio,
  required List<NetworkStateProducer> Function({
    required Dio dio,
  }) getNetworkStateProducers,
}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Setup application configs
      final config = await getConfig();

      // Setup Sentry, app crash report listener
      await Sentry.init((options) {
        options
          ..dsn = config.sentryDsn
          ..addIntegration(LoggingIntegration());
      });

      // Setup dio, http client communications
      final dio = getDio(config: config);

      // Setup network state producers
      final networkStateProducers = getNetworkStateProducers(dio: dio);

      // Setup data sources and repository
      final todoApis = await getTodosApis(config: config, dio: dio);
      final todosRepository = MultipleTodosRepository(todosApis: todoApis);

      // Setup and start periodic async data sources synchronization
      AutoSyncMultipleRepository(todosApis: todoApis).periodic();

      if (kDebugMode) {
        // State management observer
        Bloc.observer = await getBlocObserver();
      }

      runApp(
        App(
          todosRepository: todosRepository,
          networkStateProducers: networkStateProducers,
        ),
      );
    },
    (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    },
  );
}

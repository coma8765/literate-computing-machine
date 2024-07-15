import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:network_state_provider/network_state_provider.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todos_repository/todos_repository.dart';

void bootstrap({
  /// Callback that returns config sources
  required FutureOr<ConfigSource> Function() getConfigSource,

  /// Callback that returns bloc observer
  required FutureOr<BlocObserver> Function() getBlocObserver,

  /// Callback that returns todos apis
  required FutureOr<List<TodosApi>> Function(Config, Dio) getTodosApis,

  /// Callback that returns dio, http library
  required Dio Function(Config) getDio,

  /// Callback that returns network state producers
  required List<NetworkStateProducer> Function(Dio) getNetworkStateProducers,

  /// Callback that start apis synchronization process
  required void Function(FlutterErrorDetails) flutterErrorHandler,

  /// Callback that was called when unexpected exception through
  required void Function(Object, StackTrace) onError,

  /// Callback that returns analytics reporter
  required Analytics Function(Config config) getAnalyticsReporter,

  /// Callback that was called firstly for setup third party libraries
  Future<void> Function()? thirdPartyInitFirstly,

  /// Callback that was called secondly for setup third party libraries
  Future<void> Function(Config)? thirdPartyInitSecondly,

  /// Callback that start apis synchronization process
  void Function(List<TodosApi>)? todosApiSync,
}) {
  final logger = Logger('bootstrap');

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      logger.config('01: start thirdPartyInitFirstly callback');
      await thirdPartyInitFirstly?.call();

      // Setup application configs
      logger.config('02: setup config');
      final configSource = await getConfigSource();
      await configSource.init();
      final config = await configSource.getConfig().first;

      logger.config('03: start thirdPartyInitSecondly callback');
      await thirdPartyInitSecondly?.call(config);

      // Setup dio, http client communications
      logger.config('04: setup getDio');
      final dio = getDio(config);

      // Setup network state producers
      logger.config('05: setup getNetworkStateProducers');
      final networkStateProducers = getNetworkStateProducers(dio);

      // Setup data sources and repository
      logger.config('06: setup getTodosApis');
      final todosApis = await getTodosApis(config, dio);
      final todosRepository = MultipleTodosRepository(todosApis: todosApis);

      // Setup apis synchronization
      logger.config('07: setup todos apis sync');
      todosApiSync?.call(todosApis);

      // Setup apis synchronization
      logger.config('08: setup analytics');
      final analytics = getAnalyticsReporter(config);
      await analytics.init();

      FlutterError.onError = flutterErrorHandler;

      if (kDebugMode) {
        // State management observer
        Bloc.observer = await getBlocObserver();
      }

      logger.config('08: run application');
      runApp(
        App(
          todosRepository: todosRepository,
          networkStateProducers: networkStateProducers,
          configSource: configSource,
          analytics: analytics,
        ),
      );
    },
    onError,
  );
}

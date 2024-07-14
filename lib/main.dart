import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:logging/logging.dart';
import 'package:network_state_provider/network_state_provider.dart';
import 'package:remote_storage_todos_api/remote_storage_todos_api.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:todo/bootstrap.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/src/core/bloc/app_bloc_observer.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/config/config_sources/config_sources.dart';
import 'package:todo/src/core/dio/dio.dart';
import 'package:todos_repository/todos_repository.dart';

void main() async {
  // Setup application logger
  Logger.root.level = Level.CONFIG;
  Logger.root.onRecord.listen(_onLoggerRecord);

  // Start application bootstrap process
  bootstrap(
    getConfigSource: _configSource,
    getDio: _getDio,
    getTodosApis: _getTodosApis,
    getNetworkStateProducers: _getNetworkStateProducers,
    thirdPartyInitFirstly: thirdPartyInitFirstly,
    thirdPartyInitSecondly: thirdPartyInitSecondly,
    onError: onError,
    todosApiSync: _todosApisSync,
    flutterErrorHandler: (error) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(error);
    },
    getBlocObserver: () => const AppBlocObserver(),
  );
}

void _onLoggerRecord(LogRecord record) {
  log(
    '${record.time}|${record.loggerName}(${record.level}): '
    '${record.message}',
  );
}

void _todosApisSync(List<TodosApi> todosApis) {
  // Setup and start periodic async data sources synchronization
  AutoSyncMultipleRepository(todosApis: todosApis).periodic();
}

Future<ConfigSource> _configSource() async {
  // final dotenvConfig = DotenvConfigSource();
  //
  // await dotenvConfig.init();
  // dotenvConfig.dispose();
  //
  // final defaultConfig = dotenvConfig.getSingleConfig();

  return FirebaseRemoteConfigSource(
      // defaultConfig: defaultConfig,
      );
}

Dio _getDio(Config config) {
  final dio = getDio(
    apiUrl: config.apiUrl,
    apiToken: config.apiToken,
  );

  addExponentialBackoffDio(dio);

  return dio;
}

Future<List<TodosApi>> _getTodosApis(Config config, Dio dio) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  return [
    LocalStorageTodosApi(plugin: sharedPreferences),
    RemoteStorageTodosApi(dio: dio),
  ];
}

List<NetworkStateProducer> _getNetworkStateProducers(Dio dio) {
  return [
    DioStateProducer(dio),
    ConnectionPlusStateProducer(),
  ];
}

Future<void> thirdPartyInitFirstly() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> thirdPartyInitSecondly(Config config) async {
  // Setup Sentry, app crash report listener
  await Sentry.init((options) {
    options
      ..dsn = config.sentryDsn
      ..addIntegration(LoggingIntegration());
  });
}

Future<void> onError(Object error, StackTrace stackTrace) async {
  await Sentry.captureException(error, stackTrace: stackTrace);
  await FirebaseCrashlytics.instance.recordError(
    error,
    stackTrace,
    fatal: true,
  );
}

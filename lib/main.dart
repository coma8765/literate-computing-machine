import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:logging/logging.dart';
import 'package:network_state_provider/network_state_provider.dart';
import 'package:remote_storage_todos_api/remote_storage_todos_api.dart';
import 'package:todo/bootstrap.dart';
import 'package:todo/src/core/bloc/app_bloc_observer.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/dio/dio.dart';

void main() async {
  // Setup application logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (data) =>
        log('${data.time}|${data.loggerName}(${data.level}): ${data.message}'),
  );

  bootstrap(
    getConfig: () async {
      await Config.init();
      return Config();
    },
    getBlocObserver: () {
      return const AppBlocObserver();
    },
    getDio: ({required Config config}) {
      final dio = getDio(
        apiUrl: config.apiUrl,
        apiToken: config.apiToken,
      );

      addExponentialBackoffDio(dio);

      return dio;
    },
    getTodosApis: ({required Config config, required Dio dio}) async {
      final sharedPreferences = await SharedPreferences.getInstance();

      return [
        LocalStorageTodosApi(plugin: sharedPreferences),
        RemoteStorageTodosApi(dio: dio),
      ];
    },
    getNetworkStateProducers: ({required Dio dio}) {
      return [
        DioStateProducer(dio),
        ConnectionPlusStateProducer(),
      ];
    },
  );
}

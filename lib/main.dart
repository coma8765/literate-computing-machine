import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:remote_storage_todos_api/remote_storage_todos_api.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:todo/bootstrap.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/dio/dio.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initConfig();

      await SentryFlutter.init(
        (options) {
          options
            ..dsn = Config().sentryDsn
            ..addIntegration(LoggingIntegration());
        },
      );

      final dio = getDio();
      final todosApi = RemoteStorageTodosApi(dio: dio);

      await bootstrap(todosApi: todosApi);
    },
    (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    },
  );
}

import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

/// Sentry wrapper
Future<void> includeSentry({
  FutureOr<void> Function()? appRunner,
}) async {
  await SentryFlutter.init(
    (options) {
      options
        ..dsn = const String.fromEnvironment('SENTRY_DSN')
        ..tracesSampleRate = 1.0
        ..profilesSampleRate = 1.0
        ..addIntegration(LoggingIntegration());
    },
    appRunner: appRunner,
  );
}

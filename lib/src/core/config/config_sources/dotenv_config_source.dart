import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/src/core/config/config.dart';

class DotenvConfigSource extends ConfigSource {
  final _configStreamController = BehaviorSubject<Config>();

  @override
  Stream<Config> getConfig() =>
      _configStreamController.stream.asBroadcastStream();

  @override
  FutureOr<void> init() async {
    await dotenv.load();

    _configStreamController.add(getSingleConfig());
  }

  @override
  Config getSingleConfig() => Config(
        sentryDsn: dotenv.env['SENTRY_DSN'] ?? '',
        apiUrl: dotenv.env['API_URI'] ?? '',
        apiToken: dotenv.env['API_AUTH'] ?? '',
        appMetricaToken: dotenv.env['APPMETRICA_TOKEN'] ?? '',
        themeOverrides: ThemeOverrides(
          importanceColor:
              dotenv.env.containsKey('THEME_OVERRIDE_IMPORTANT_COLOR')
                  ? int.parse(dotenv.env['THEME_OVERRIDE_IMPORTANT_COLOR']!)
                  : null,
        ),
      );

  @override
  FutureOr<void> dispose() {
    _configStreamController.close();
  }
}

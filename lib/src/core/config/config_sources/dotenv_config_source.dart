import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/src/core/config/config.dart';

import 'package:todo/src/core/config/config_sources/config_source.dart';

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
      );

  @override
  FutureOr<void> dispose() {
    _configStreamController.close();
  }
}

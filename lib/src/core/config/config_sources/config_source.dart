import 'dart:async';

import 'package:todo/src/core/config/config.dart';

abstract class ConfigSource {
  FutureOr<void> init();

  Stream<Config> getConfig();

  Config getSingleConfig();

  FutureOr<void> dispose() {}
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initConfig() async {
  await dotenv.load();
}

class Config {
  factory Config() {
    _singleton ??= Config._(
        sentryDsn: dotenv.env['SENTRY_DSN']!,
      );

    return _singleton!;
  }

  Config._({required this.sentryDsn});

  static Config? _singleton;

  final String sentryDsn;
}

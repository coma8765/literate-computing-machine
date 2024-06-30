import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initConfig() async {
  await dotenv.load();
}

class Config {
  factory Config() {
    _singleton ??= Config._(
      sentryDsn: dotenv.env['SENTRY_DSN'] ?? '',
        apiUrl: dotenv.env['API_URI'] ?? '',
        apiToken: dotenv.env['API_AUTH'] ?? '',
    );

    return _singleton!;
  }

  Config._({
    required this.sentryDsn,
    required this.apiUrl,
    required this.apiToken,
  });

  static Config? _singleton;

  final String sentryDsn;
  final String apiUrl;
  final String apiToken;
}

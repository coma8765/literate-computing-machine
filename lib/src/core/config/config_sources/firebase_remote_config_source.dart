import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/src/core/config/config.dart';

class FirebaseRemoteConfigSource extends ConfigSource {
  FirebaseRemoteConfigSource({
    Duration fetchTimeout = const Duration(minutes: 1),
    Duration minimumFetchInterval = const Duration(hours: 1),
    Config? defaultConfig,
  })  : _fetchTimeout = fetchTimeout,
        _minimumFetchInterval = minimumFetchInterval,
        _defaultConfig = defaultConfig;

  final Duration _fetchTimeout;
  final Duration _minimumFetchInterval;
  final Config? _defaultConfig;

  final _remoteConfig = FirebaseRemoteConfig.instance;
  final _configStreamController = BehaviorSubject<Config>();
  final _logger = Logger('firebase-remote-config');

  StreamSubscription<RemoteConfigUpdate>? _updateSubscription;

  @override
  Stream<Config> getConfig() =>
      _configStreamController.stream.asBroadcastStream();

  @override
  FutureOr<void> init() async {
    if (_updateSubscription != null) {
      await _updateSubscription?.cancel();
    }

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: _fetchTimeout,
        minimumFetchInterval: _minimumFetchInterval,
      ),
    );

    if (_defaultConfig != null) {
      await _remoteConfig.setDefaults(
        _defaultConfig.toJson(),
      );
    }

    await _remoteConfig.fetchAndActivate();
    _updateConfig();

    _updateSubscription = _remoteConfig.onConfigUpdated.listen((_) async {
      await _remoteConfig.activate();
      _updateConfig();
    });
    _logger.config('initialization complete');
  }

  void _updateConfig() {
    final config = Config(
      sentryDsn: _remoteConfig.getString('SENTRY_DSN'),
      apiUrl: _remoteConfig.getString('API_URI'),
      apiToken: _remoteConfig.getString('API_AUTH'),
    );

    _configStreamController.add(config);
    _logger.fine('config loaded, update stream');
  }

  @override
  FutureOr<void> dispose() {
    _updateSubscription?.cancel();
    _configStreamController.close();
  }

  @override
  Config getSingleConfig() => _configStreamController.value;
}

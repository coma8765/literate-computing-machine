import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_state_provider/src/producers/producer.dart';
import 'package:rxdart/rxdart.dart';

class ConnectionPlusStateProducer extends NetworkStateProducer {
  final _stream = BehaviorSubject<bool>();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectionPlusStateProducer() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      final hasConnection = !result.contains(ConnectivityResult.none);
      _stream.add(hasConnection);
    });
  }

  @override
  Stream<bool> hasConnection() => _stream.stream.asBroadcastStream();

  @override
  void dispose() {
    _subscription.cancel();
    _stream.close();
  }
}

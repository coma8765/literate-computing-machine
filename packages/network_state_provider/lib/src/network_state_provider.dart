import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:network_state_provider/src/producers/producers.dart';
import 'package:rxdart/rxdart.dart';

/// {@template network_state_provider}
/// The provider for monitoring internet status.
/// {@endtemplate}
class NetworkStateProvider extends InheritedWidget {
  /// {@macro network_state_provider}
  final List<NetworkStateProducer> _producers;

  final _stream = BehaviorSubject<bool>();
  final _logger = Logger('network-state-provider');

  NetworkStateProvider({
    required List<NetworkStateProducer> producers,
    required super.child,
  }) : _producers = producers {
    for (final producer in _producers) {
      producer.hasConnection().listen((hasConnection) {
        _logger.finest('got $hasConnection, old ${_stream.valueOrNull}');
        if (hasConnection && !_stream.hasValue) return;

        if (hasConnection == _stream.valueOrNull) return;

        _logger.info(
          "update state by '$producer', "
          "${_stream.valueOrNull} -> $hasConnection",
        );
        _stream.add(hasConnection);
      });
    }
  }

  static NetworkStateProvider of(BuildContext context) {
    final instance =
        context.getInheritedWidgetOfExactType<NetworkStateProvider>();

    assert(instance != null);
    return instance!;
  }

  Stream<bool> hasConnection() => _stream.stream.asBroadcastStream();

  @override
  bool updateShouldNotify(covariant NetworkStateProvider oldWidget) => false;
}

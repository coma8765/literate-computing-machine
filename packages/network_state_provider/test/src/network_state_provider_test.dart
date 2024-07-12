// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_state_provider/network_state_provider.dart';

void main() {
  group('NetworkStateProvider', () {
    testWidgets('can be init', (WidgetTester tester) async {
      final log = <NetworkStateProvider>[];

      final builder = Builder(
        builder: (BuildContext context) {
          log.add(
            context.dependOnInheritedWidgetOfExactType<NetworkStateProvider>()!,
          );
          return Container();
        },
      );

      NetworkStateProvider(producers: [], child: builder);

      final first = NetworkStateProvider(producers: [], child: builder);
      await tester.pumpWidget(first);

      expect(log, equals(<NetworkStateProvider>[first]));
    });
  });
}

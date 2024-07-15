import 'package:analytics/analytics.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsProvider extends InheritedWidget {
  const AnalyticsProvider({
    required super.child,
    required this.analytics,
    super.key,
  });

  final Analytics analytics;

  @override
  bool updateShouldNotify(covariant AnalyticsProvider oldWidget) => false;

  static AnalyticsProvider? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<AnalyticsProvider>();
  }

  static Analytics of(BuildContext context) {
    final instance = maybeOf(context);
    assert(instance != null, 'AnalyticsProvider must be init before use');
    return instance!.analytics;
  }
}

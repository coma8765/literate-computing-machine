import 'package:analytics/src/analytics_provider.dart';
import 'package:flutter/cupertino.dart';

/// {@template analytics}
/// Analytics for business logic
/// {@endtemplate}
abstract class Analytics {
  /// {@macro analytics}
  const Analytics();

  Future<void> init();

  Future<void> reportTodoSave({required String todoId, bool created = false});

  Future<void> reportTodoDelete({required String todoId});

  Future<void> reportOpenUri({required String uri});

  static Analytics of(BuildContext context) => AnalyticsProvider.of(context);
}

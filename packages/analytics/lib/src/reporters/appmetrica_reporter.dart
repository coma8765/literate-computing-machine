import 'package:analytics/analytics.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';

class AppMetricaReporter extends Analytics {
  factory AppMetricaReporter({required String token}) {
    _singleton ??= AppMetricaReporter._(token: token);
    return _singleton!;
  }

  const AppMetricaReporter._({required String token}) : _token = token;

  static AppMetricaReporter? _singleton;

  final String _token;

  @override
  Future<void> init() async {
    await AppMetrica.activate(AppMetricaConfig(_token, logs: true));
  }

  @override
  Future<void> reportTodoSave({
    required String todoId,
    bool created = false,
  }) async {
    final eventName = created ? 'todo-created' : 'todo-updated';

    await AppMetrica.reportEventWithMap(eventName, {
      'todoId': todoId,
    });
  }

  @override
  Future<void> reportTodoDelete({required String todoId}) async {
    await AppMetrica.reportEventWithMap('todo-deleted', {
      'todoId': todoId,
    });
  }

  @override
  Future<void> reportOpenUri({required String uri}) async {
    await AppMetrica.reportEventWithMap('open-uri', {
      'uri': uri,
    });
  }
}

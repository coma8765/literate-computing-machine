import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:todos_api/models_factory.dart';

void main() {
  group('TodoModelFactory', () {
    const todoModelFactory = TodoModelFactory();

    test('can create', () {
      final model = todoModelFactory.generateFake();

      expect(model, isA<TodoModel>());
    });

    test('can deserialize from json', () {
      final source = todoModelFactory.generateFake();

      final json = {
        'id': source.id,
        'text': source.text,
        'importance': source.importance.name,
        'deadline': source.deadline?.millisecondsSinceEpoch,
        'done': source.done,
        'color': source.color,
        'created_at': source.createdAt.millisecondsSinceEpoch,
        'changed_at': source.changedAt.millisecondsSinceEpoch,
        'last_updated_by': source.lastUpdatedBy,
      };

      final model = TodoModel.fromJson(json);

      expect(model, equals(source));
    });
  });
}

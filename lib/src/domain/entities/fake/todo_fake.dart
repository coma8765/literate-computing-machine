import 'package:todo/src/core/fake/faker.dart';
import 'package:todo/src/domain/domain.dart';

/// Random Data generator for TODO entity
class TodoFactory extends ModelFactory<Todo> {
  @override
  Todo generateFake() {
    final id = createFakeUuid();

    final text = faker.lorem.sentence().substring(0, 20);

    final deadline = faker.randomGenerator.boolean()
        ? faker.date.dateTime(minYear: 2000, maxYear: 2124)
        : null;

    final importance = faker.randomGenerator.element(
      Importance.values,
    );

    return Todo(
      id: id,
      text: text,
      importance: importance,
      deadline: deadline,
    );
  }

  @override
  List<Todo> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

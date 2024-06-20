import 'package:todo/src/core/fake/faker.dart';
import 'package:todo/src/domain/domain.dart';

/// Random Data generator for TODO entity
class TODOFactory extends ModelFactory<TODO> {
  @override
  TODO generateFake() {
    final uid = createFakeUuid();

    final title = faker.lorem.sentence().substring(0, 20);

    final deadline = faker.randomGenerator.boolean()
        ? faker.date.dateTime(minYear: 2000, maxYear: 2124)
        : null;

    final importance = faker.randomGenerator.element(
      Importance.values,
    );

    return TODO(
      uid: uid,
      title: title,
      importance: importance,
      deadline: deadline,
    );
  }

  @override
  List<TODO> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

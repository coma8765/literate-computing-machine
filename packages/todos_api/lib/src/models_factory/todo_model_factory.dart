import 'package:todos_api/models.dart';

import 'package:todos_api/src/models_factory/model_factory.dart';

class TodoModelFactory extends ModelFactory<TodoModel> {
  const TodoModelFactory();

  @override
  TodoModel generateFake() {
    return TodoModel(
      id: createFakeUuid(),
      text: faker.lorem.sentence(),
      importance: faker.randomGenerator.element(ImportanceModel.values),
      done: faker.randomGenerator.boolean(),
      deadline: faker.date.dateTime(maxYear: 2020).copyWith(microsecond: 0),
      createdAt: faker.date.dateTime(maxYear: 2020).copyWith(microsecond: 0),
      changedAt: faker.date.dateTime(maxYear: 2020).copyWith(microsecond: 0),
    );
  }
}

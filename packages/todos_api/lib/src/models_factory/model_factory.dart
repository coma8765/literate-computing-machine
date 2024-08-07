import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

abstract class ModelFactory<T> {
  const ModelFactory();

  Faker get faker => Faker();

  String createFakeUuid() {
    return const Uuid().v4();
  }

  T generateFake();

  List<T> generateFakeList({required int length}) =>
      List.generate(length, (_) => generateFake());
}

import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

/// ModelFactory for random data generation
abstract class ModelFactory<T> {
  /// Faker instance for random mathods
  Faker get faker => Faker();

  /// Creates a fake uuid.
  String createFakeUuid() {
    return const Uuid().v4();
  }

  /// Generate a single fake model.
  T generateFake();

  /// Generate fake list based on provided length.
  List<T> generateFakeList({required int length});
}

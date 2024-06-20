import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

part 'todo.freezed.dart';

/// A Entity with [Importance] variants of TODO.
enum Importance {
  /// [Importance] [low].
  low,
  /// [Importance] [normal].
  normal,
  /// [Importance] [high].
  high,
}

const _uuid = Uuid();

/// A TODO entity
@freezed
class TODO with _$TODO {
  /// This class creates instances of [TODO]
  factory TODO({
    required String uid,
    @Default('') String title,
    @Default(Importance.normal) Importance importance,
    DateTime? deadline,
  }) = _TODO;

  /// This class creates instances of [TODO] with random [uid]
  factory TODO.create({
    String title = '',
    Importance importance = Importance.normal,
    DateTime? deadline,
  }) =>
      TODO(
        uid: _uuid.v4(),
        title: title,
        importance: importance,
        deadline: deadline,
      );

  /// This class creates instances of [TODO] from json data
  factory TODO.fromJson(Map<String, dynamic> json) => _$TODOFromJson(json);
}

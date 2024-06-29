import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/src/models/json_map.dart';
import 'package:todos_api/src/models/utils/timestamp_to_datetime.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

/// [Todo]'s importance.
enum Importance {
  /// The `low` importance.
  low,

  /// The `default` importance.
  basic,

  /// The `important` importance.
  important,
}

extension ImportanceIndex on Importance {
  int toIndex() {
    switch (this) {
      case (Importance.low):
        return 0;
      case (Importance.basic):
        return 1;
      case (Importance.important):
        return 2;
    }
  }

  static Importance fromIndex(int index) {
    switch (index) {
      case (0):
        return Importance.low;
      case (2):
        return Importance.important;
      default:
        return Importance.basic;
    }
  }
}

/// {@template todo_item}
/// A single `todo` item.
///
/// Contains [id], [text], [importance], [deadline], [done] flag, [color],
/// [createdAt], [changedAt], [lastUpdatedBy].
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided,
/// one will be generated.
///
/// [Todo]s are immutable and be copied using [copyWith], in addition
/// to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class Todo extends Equatable {
  /// {@macro todo_item}
  Todo({
    required this.text,
    this.importance = Importance.basic,
    this.deadline,
    this.done = false,
    this.color,
    DateTime? createdAt,
    DateTime? changedAt,
    this.lastUpdatedBy = '0',
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id is must to be null or not empty',
        ),
        id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        changedAt = changedAt ?? DateTime.now();

  /// The unique identifier of the `todo`.
  ///
  /// Cannot be empty.
  final String id;

  /// The text of the `todo`.
  ///
  /// Note: that text may be empty.
  final String text;

  /// The importance of `todo`
  final Importance importance;

  /// The deadline of `todo`
  @TimestampConverter()
  final DateTime? deadline;

  /// Whether the `todo` is completed.
  ///
  /// Defaults to `false`.
  final bool done;

  /// Optional [Todo]'s color.
  final String? color;

  ///
  @TimestampConverter()
  final DateTime createdAt;

  ///
  @TimestampConverter()
  final DateTime changedAt;

  ///
  final String lastUpdatedBy;

  /// Returns a copy of this `todo` with given values updated.
  ///
  /// {@macro todo_item}
  Todo copyWith({
    String? id,
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? DateTime.now(),
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  /// Converts this [Todo] to a [JsonMap].
  JsonMap toJson() => _$TodoToJson(this);

  @override
  String toString() {
    return '''
Todo(
\tid=$id,
\ttext=$text,
\tdeadline=$deadline,
\tcolor=$color,
\tcreatedAt=$createdAt,
\tchangedAt=$changedAt,
\tlastUpdatedBy=$lastUpdatedBy,
)''';
  }

  @override
  List<Object?> get props => [
        id,
        text.hashCode,
        deadline?.millisecondsSinceEpoch,
        double,
        color,
        createdAt.millisecondsSinceEpoch,
        changedAt.millisecondsSinceEpoch,
        lastUpdatedBy,
      ];
}

/// {@template revised_list_todo}
/// A list of `todo` items.
///
/// Also contains [revision] identifier for control conflicts.
///
/// [RevisedListTodo]'s are immutable and can only updated fully.
/// {@endtemplate}
@immutable
@JsonSerializable()
class RevisedListTodo extends Equatable {
  /// {@macro revised_list_todo}
  const RevisedListTodo({
    required this.list,
    required this.revision,
  });

  /// List of [Todo]s.
  final List<Todo> list;

  /// A revision of date storage.
  final int revision;

  /// Deserializes the given [JsonMap] into a [RevisedListTodo].
  static RevisedListTodo fromJson(JsonMap json) =>
      _$RevisedListTodoFromJson(json);

  /// Converts this [RevisedListTodo] to a [JsonMap].
  JsonMap toJson() => _$RevisedListTodoToJson(this);

  @override
  String toString() {
    return '''
RevisedListTodo(
\trevision=$revision,
\tlist=$list,
)''';
  }

  @override
  List<Object?> get props => [revision];
}

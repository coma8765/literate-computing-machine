import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/src/models/json_map.dart';
import 'package:todos_api/src/models/utils/timestamp_to_datetime.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

/// [TodoModel]'s importance.
enum ImportanceModel {
  /// The `low` importance.
  low,

  /// The `default` importance.
  basic,

  /// The `important` importance.
  important,
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
/// [TodoModel]s are immutable and be copied using [copyWith], in addition
/// to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class TodoModel extends Equatable {
  /// {@macro todo_item}
  TodoModel({
    required this.text,
    this.importance = ImportanceModel.basic,
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
  final ImportanceModel importance;

  /// The deadline of `todo`
  @TimestampConverter()
  final DateTime? deadline;

  /// Whether the `todo` is completed.
  ///
  /// Defaults to `false`.
  final bool done;

  /// Optional [TodoModel]'s color.
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
  TodoModel copyWith({
    String? id,
    String? text,
    ImportanceModel? importance,
    DateTime? deadline,
    bool? done,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return TodoModel(
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

  /// Deserializes the given [JsonMap] into a [TodoModel].
  static TodoModel fromJson(JsonMap json) => _$TodoModelFromJson(json);

  /// Converts this [TodoModel] to a [JsonMap].
  JsonMap toJson() => _$TodoModelToJson(this);

  @override
  String toString() {
    return '''
TodoModel(
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
/// [RevisedListTodoModel]'s are immutable and can only updated fully.
/// {@endtemplate}
@immutable
@JsonSerializable()
class RevisedListTodoModel extends Equatable {
  /// {@macro revised_list_todo}
  const RevisedListTodoModel({
    required this.list,
    required this.revision,
  });

  /// List of [TodoModel]s.
  final List<TodoModel> list;

  /// A revision of date storage.
  final int revision;

  /// Deserializes the given [JsonMap] into a [RevisedListTodoModel].
  static RevisedListTodoModel fromJson(JsonMap json) =>
      _$RevisedListTodoModelFromJson(json);

  /// Converts this [RevisedListTodoModel] to a [JsonMap].
  JsonMap toJson() => _$RevisedListTodoModelToJson(this);

  @override
  String toString() {
    return '''
RevisedListTodoModel(
\trevision=$revision,
\tlist=$list,
)''';
  }

  @override
  List<Object?> get props => [revision];
}

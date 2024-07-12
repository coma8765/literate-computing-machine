import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todos_api/src/models/utils/timestamp_to_datetime.dart';

part 'todo_model.freezed.dart';

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
/// to being serialized and deserialized using [toJson] and [TodoModel.fromJson]
/// respectively.
/// {@endtemplate}
@freezed
class TodoModel with _$TodoModel {
  /// {@macro todo_item}
  const factory TodoModel({
    required String id,
    required String text,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime changedAt,
    @Default(ImportanceModel.basic) ImportanceModel importance,
    @TimestampConverter() DateTime? deadline,
    @Default(false) bool done,
    String? color,
    @Default('0') String lastUpdatedBy,
    @Default(false) bool isRemoved,
    @Default(false) bool isSynced,
  }) = _TodoModel;

  const TodoModel._();

  factory TodoModel.fromJson(Map<String, Object?> json) =>
      _$TodoModelFromJson(json);
}

// @immutable
// @JsonSerializable()
// class RevisedListTodoModel extends Equatable {
//   /// {@macro revised_list_todo}
//   const RevisedListTodoModel({
//     required this.list,
//     required this.revision,
//   });
//
//   /// List of [TodoModel]s.
//   final List<TodoModel> list;
//
//   /// A revision of date storage.
//   final int revision;
//
//   /// Deserializes the given [JsonMap] into a [RevisedListTodoModel].
//   static RevisedListTodoModel fromJson(JsonMap json) =>
//       _$RevisedListTodoModelFromJson(json);
//
//   /// Converts this [RevisedListTodoModel] to a [JsonMap].
//   JsonMap toJson() => _$RevisedListTodoModelToJson(this);
//
//   @override
//   String toString() {
//     return '''
// RevisedListTodoModel(
// \trevision=$revision,
// \tlist=$list,
// )''';
//   }
//
//   @override
//   List<Object?> get props => [revision];
// }

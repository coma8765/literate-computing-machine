// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revised_list_todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RevisedListTodoModel _$RevisedListTodoModelFromJson(Map<String, dynamic> json) {
  return _RevisedListTodoModel.fromJson(json);
}

/// @nodoc
mixin _$RevisedListTodoModel {
  List<TodoModel> get list => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RevisedListTodoModelCopyWith<RevisedListTodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevisedListTodoModelCopyWith<$Res> {
  factory $RevisedListTodoModelCopyWith(RevisedListTodoModel value,
          $Res Function(RevisedListTodoModel) then) =
      _$RevisedListTodoModelCopyWithImpl<$Res, RevisedListTodoModel>;
  @useResult
  $Res call({List<TodoModel> list, int revision});
}

/// @nodoc
class _$RevisedListTodoModelCopyWithImpl<$Res,
        $Val extends RevisedListTodoModel>
    implements $RevisedListTodoModelCopyWith<$Res> {
  _$RevisedListTodoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TodoModel>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevisedListTodoModelImplCopyWith<$Res>
    implements $RevisedListTodoModelCopyWith<$Res> {
  factory _$$RevisedListTodoModelImplCopyWith(_$RevisedListTodoModelImpl value,
          $Res Function(_$RevisedListTodoModelImpl) then) =
      __$$RevisedListTodoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TodoModel> list, int revision});
}

/// @nodoc
class __$$RevisedListTodoModelImplCopyWithImpl<$Res>
    extends _$RevisedListTodoModelCopyWithImpl<$Res, _$RevisedListTodoModelImpl>
    implements _$$RevisedListTodoModelImplCopyWith<$Res> {
  __$$RevisedListTodoModelImplCopyWithImpl(_$RevisedListTodoModelImpl _value,
      $Res Function(_$RevisedListTodoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_$RevisedListTodoModelImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TodoModel>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevisedListTodoModelImpl implements _RevisedListTodoModel {
  const _$RevisedListTodoModelImpl(
      {required final List<TodoModel> list, required this.revision})
      : _list = list;

  factory _$RevisedListTodoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevisedListTodoModelImplFromJson(json);

  final List<TodoModel> _list;
  @override
  List<TodoModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final int revision;

  @override
  String toString() {
    return 'RevisedListTodoModel(list: $list, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevisedListTodoModelImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RevisedListTodoModelImplCopyWith<_$RevisedListTodoModelImpl>
      get copyWith =>
          __$$RevisedListTodoModelImplCopyWithImpl<_$RevisedListTodoModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevisedListTodoModelImplToJson(
      this,
    );
  }
}

abstract class _RevisedListTodoModel implements RevisedListTodoModel {
  const factory _RevisedListTodoModel(
      {required final List<TodoModel> list,
      required final int revision}) = _$RevisedListTodoModelImpl;

  factory _RevisedListTodoModel.fromJson(Map<String, dynamic> json) =
      _$RevisedListTodoModelImpl.fromJson;

  @override
  List<TodoModel> get list;
  @override
  int get revision;
  @override
  @JsonKey(ignore: true)
  _$$RevisedListTodoModelImplCopyWith<_$RevisedListTodoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

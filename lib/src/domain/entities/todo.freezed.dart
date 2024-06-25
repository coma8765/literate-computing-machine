// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TODO _$TODOFromJson(Map<String, dynamic> json) {
  return _TODO.fromJson(json);
}

/// @nodoc
mixin _$TODO {
  String get uid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  Importance get importance => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TODOCopyWith<TODO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TODOCopyWith<$Res> {
  factory $TODOCopyWith(TODO value, $Res Function(TODO) then) =
      _$TODOCopyWithImpl<$Res, TODO>;
  @useResult
  $Res call(
      {String uid, String title, Importance importance, DateTime? deadline});
}

/// @nodoc
class _$TODOCopyWithImpl<$Res, $Val extends TODO>
    implements $TODOCopyWith<$Res> {
  _$TODOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? importance = null,
    Object? deadline = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TODOImplCopyWith<$Res> implements $TODOCopyWith<$Res> {
  factory _$$TODOImplCopyWith(
          _$TODOImpl value, $Res Function(_$TODOImpl) then) =
      __$$TODOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid, String title, Importance importance, DateTime? deadline});
}

/// @nodoc
class __$$TODOImplCopyWithImpl<$Res>
    extends _$TODOCopyWithImpl<$Res, _$TODOImpl>
    implements _$$TODOImplCopyWith<$Res> {
  __$$TODOImplCopyWithImpl(_$TODOImpl _value, $Res Function(_$TODOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? importance = null,
    Object? deadline = freezed,
  }) {
    return _then(_$TODOImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TODOImpl implements _TODO {
  _$TODOImpl(
      {required this.uid,
      this.title = '',
      this.importance = Importance.normal,
      this.deadline});

  factory _$TODOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TODOImplFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final Importance importance;
  @override
  final DateTime? deadline;

  @override
  String toString() {
    return 'TODO(uid: $uid, title: $title, importance: $importance, deadline: $deadline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TODOImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, title, importance, deadline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TODOImplCopyWith<_$TODOImpl> get copyWith =>
      __$$TODOImplCopyWithImpl<_$TODOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TODOImplToJson(
      this,
    );
  }
}

abstract class _TODO implements TODO {
  factory _TODO(
      {required final String uid,
      final String title,
      final Importance importance,
      final DateTime? deadline}) = _$TODOImpl;

  factory _TODO.fromJson(Map<String, dynamic> json) = _$TODOImpl.fromJson;

  @override
  String get uid;
  @override
  String get title;
  @override
  Importance get importance;
  @override
  DateTime? get deadline;
  @override
  @JsonKey(ignore: true)
  _$$TODOImplCopyWith<_$TODOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

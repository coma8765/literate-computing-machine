// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThemeOverrides _$ThemeOverridesFromJson(Map<String, dynamic> json) {
  return _ThemeOverrides.fromJson(json);
}

/// @nodoc
mixin _$ThemeOverrides {
  int? get importanceColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThemeOverridesCopyWith<ThemeOverrides> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeOverridesCopyWith<$Res> {
  factory $ThemeOverridesCopyWith(
          ThemeOverrides value, $Res Function(ThemeOverrides) then) =
      _$ThemeOverridesCopyWithImpl<$Res, ThemeOverrides>;
  @useResult
  $Res call({int? importanceColor});
}

/// @nodoc
class _$ThemeOverridesCopyWithImpl<$Res, $Val extends ThemeOverrides>
    implements $ThemeOverridesCopyWith<$Res> {
  _$ThemeOverridesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? importanceColor = freezed,
  }) {
    return _then(_value.copyWith(
      importanceColor: freezed == importanceColor
          ? _value.importanceColor
          : importanceColor // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemeOverridesImplCopyWith<$Res>
    implements $ThemeOverridesCopyWith<$Res> {
  factory _$$ThemeOverridesImplCopyWith(_$ThemeOverridesImpl value,
          $Res Function(_$ThemeOverridesImpl) then) =
      __$$ThemeOverridesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? importanceColor});
}

/// @nodoc
class __$$ThemeOverridesImplCopyWithImpl<$Res>
    extends _$ThemeOverridesCopyWithImpl<$Res, _$ThemeOverridesImpl>
    implements _$$ThemeOverridesImplCopyWith<$Res> {
  __$$ThemeOverridesImplCopyWithImpl(
      _$ThemeOverridesImpl _value, $Res Function(_$ThemeOverridesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? importanceColor = freezed,
  }) {
    return _then(_$ThemeOverridesImpl(
      importanceColor: freezed == importanceColor
          ? _value.importanceColor
          : importanceColor // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeOverridesImpl implements _ThemeOverrides {
  const _$ThemeOverridesImpl({this.importanceColor});

  factory _$ThemeOverridesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeOverridesImplFromJson(json);

  @override
  final int? importanceColor;

  @override
  String toString() {
    return 'ThemeOverrides(importanceColor: $importanceColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeOverridesImpl &&
            (identical(other.importanceColor, importanceColor) ||
                other.importanceColor == importanceColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, importanceColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeOverridesImplCopyWith<_$ThemeOverridesImpl> get copyWith =>
      __$$ThemeOverridesImplCopyWithImpl<_$ThemeOverridesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeOverridesImplToJson(
      this,
    );
  }
}

abstract class _ThemeOverrides implements ThemeOverrides {
  const factory _ThemeOverrides({final int? importanceColor}) =
      _$ThemeOverridesImpl;

  factory _ThemeOverrides.fromJson(Map<String, dynamic> json) =
      _$ThemeOverridesImpl.fromJson;

  @override
  int? get importanceColor;
  @override
  @JsonKey(ignore: true)
  _$$ThemeOverridesImplCopyWith<_$ThemeOverridesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  String get sentryDsn => throw _privateConstructorUsedError;
  String get apiUrl => throw _privateConstructorUsedError;
  String get apiToken => throw _privateConstructorUsedError;
  ThemeOverrides get themeOverrides => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call(
      {String sentryDsn,
      String apiUrl,
      String apiToken,
      ThemeOverrides themeOverrides});

  $ThemeOverridesCopyWith<$Res> get themeOverrides;
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentryDsn = null,
    Object? apiUrl = null,
    Object? apiToken = null,
    Object? themeOverrides = null,
  }) {
    return _then(_value.copyWith(
      sentryDsn: null == sentryDsn
          ? _value.sentryDsn
          : sentryDsn // ignore: cast_nullable_to_non_nullable
              as String,
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      themeOverrides: null == themeOverrides
          ? _value.themeOverrides
          : themeOverrides // ignore: cast_nullable_to_non_nullable
              as ThemeOverrides,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ThemeOverridesCopyWith<$Res> get themeOverrides {
    return $ThemeOverridesCopyWith<$Res>(_value.themeOverrides, (value) {
      return _then(_value.copyWith(themeOverrides: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConfigImplCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$ConfigImplCopyWith(
          _$ConfigImpl value, $Res Function(_$ConfigImpl) then) =
      __$$ConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sentryDsn,
      String apiUrl,
      String apiToken,
      ThemeOverrides themeOverrides});

  @override
  $ThemeOverridesCopyWith<$Res> get themeOverrides;
}

/// @nodoc
class __$$ConfigImplCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$ConfigImpl>
    implements _$$ConfigImplCopyWith<$Res> {
  __$$ConfigImplCopyWithImpl(
      _$ConfigImpl _value, $Res Function(_$ConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentryDsn = null,
    Object? apiUrl = null,
    Object? apiToken = null,
    Object? themeOverrides = null,
  }) {
    return _then(_$ConfigImpl(
      sentryDsn: null == sentryDsn
          ? _value.sentryDsn
          : sentryDsn // ignore: cast_nullable_to_non_nullable
              as String,
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      themeOverrides: null == themeOverrides
          ? _value.themeOverrides
          : themeOverrides // ignore: cast_nullable_to_non_nullable
              as ThemeOverrides,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigImpl implements _Config {
  const _$ConfigImpl(
      {required this.sentryDsn,
      required this.apiUrl,
      required this.apiToken,
      required this.themeOverrides});

  factory _$ConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigImplFromJson(json);

  @override
  final String sentryDsn;
  @override
  final String apiUrl;
  @override
  final String apiToken;
  @override
  final ThemeOverrides themeOverrides;

  @override
  String toString() {
    return 'Config(sentryDsn: $sentryDsn, apiUrl: $apiUrl, apiToken: $apiToken, themeOverrides: $themeOverrides)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigImpl &&
            (identical(other.sentryDsn, sentryDsn) ||
                other.sentryDsn == sentryDsn) &&
            (identical(other.apiUrl, apiUrl) || other.apiUrl == apiUrl) &&
            (identical(other.apiToken, apiToken) ||
                other.apiToken == apiToken) &&
            (identical(other.themeOverrides, themeOverrides) ||
                other.themeOverrides == themeOverrides));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sentryDsn, apiUrl, apiToken, themeOverrides);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      __$$ConfigImplCopyWithImpl<_$ConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigImplToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  const factory _Config(
      {required final String sentryDsn,
      required final String apiUrl,
      required final String apiToken,
      required final ThemeOverrides themeOverrides}) = _$ConfigImpl;

  factory _Config.fromJson(Map<String, dynamic> json) = _$ConfigImpl.fromJson;

  @override
  String get sentryDsn;
  @override
  String get apiUrl;
  @override
  String get apiToken;
  @override
  ThemeOverrides get themeOverrides;
  @override
  @JsonKey(ignore: true)
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

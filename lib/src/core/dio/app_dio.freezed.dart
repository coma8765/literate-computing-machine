// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_dio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppDioOption {
  String get apiUrl => throw _privateConstructorUsedError;
  String get apiToken => throw _privateConstructorUsedError;
  int get failsPercent => throw _privateConstructorUsedError;
  Duration get timeout => throw _privateConstructorUsedError;
  List<Interceptor> get interceptors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppDioOptionCopyWith<AppDioOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDioOptionCopyWith<$Res> {
  factory $AppDioOptionCopyWith(
          AppDioOption value, $Res Function(AppDioOption) then) =
      _$AppDioOptionCopyWithImpl<$Res, AppDioOption>;
  @useResult
  $Res call(
      {String apiUrl,
      String apiToken,
      int failsPercent,
      Duration timeout,
      List<Interceptor> interceptors});
}

/// @nodoc
class _$AppDioOptionCopyWithImpl<$Res, $Val extends AppDioOption>
    implements $AppDioOptionCopyWith<$Res> {
  _$AppDioOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiUrl = null,
    Object? apiToken = null,
    Object? failsPercent = null,
    Object? timeout = null,
    Object? interceptors = null,
  }) {
    return _then(_value.copyWith(
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      failsPercent: null == failsPercent
          ? _value.failsPercent
          : failsPercent // ignore: cast_nullable_to_non_nullable
              as int,
      timeout: null == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration,
      interceptors: null == interceptors
          ? _value.interceptors
          : interceptors // ignore: cast_nullable_to_non_nullable
              as List<Interceptor>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppDioOptionImplCopyWith<$Res>
    implements $AppDioOptionCopyWith<$Res> {
  factory _$$AppDioOptionImplCopyWith(
          _$AppDioOptionImpl value, $Res Function(_$AppDioOptionImpl) then) =
      __$$AppDioOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String apiUrl,
      String apiToken,
      int failsPercent,
      Duration timeout,
      List<Interceptor> interceptors});
}

/// @nodoc
class __$$AppDioOptionImplCopyWithImpl<$Res>
    extends _$AppDioOptionCopyWithImpl<$Res, _$AppDioOptionImpl>
    implements _$$AppDioOptionImplCopyWith<$Res> {
  __$$AppDioOptionImplCopyWithImpl(
      _$AppDioOptionImpl _value, $Res Function(_$AppDioOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiUrl = null,
    Object? apiToken = null,
    Object? failsPercent = null,
    Object? timeout = null,
    Object? interceptors = null,
  }) {
    return _then(_$AppDioOptionImpl(
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      failsPercent: null == failsPercent
          ? _value.failsPercent
          : failsPercent // ignore: cast_nullable_to_non_nullable
              as int,
      timeout: null == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration,
      interceptors: null == interceptors
          ? _value._interceptors
          : interceptors // ignore: cast_nullable_to_non_nullable
              as List<Interceptor>,
    ));
  }
}

/// @nodoc

class _$AppDioOptionImpl with DiagnosticableTreeMixin implements _AppDioOption {
  const _$AppDioOptionImpl(
      {required this.apiUrl,
      required this.apiToken,
      this.failsPercent = kDebugMode ? 40 : 10,
      this.timeout = const Duration(minutes: 1),
      final List<Interceptor> interceptors = const []})
      : _interceptors = interceptors;

  @override
  final String apiUrl;
  @override
  final String apiToken;
  @override
  @JsonKey()
  final int failsPercent;
  @override
  @JsonKey()
  final Duration timeout;
  final List<Interceptor> _interceptors;
  @override
  @JsonKey()
  List<Interceptor> get interceptors {
    if (_interceptors is EqualUnmodifiableListView) return _interceptors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interceptors);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppDioOption(apiUrl: $apiUrl, apiToken: $apiToken, failsPercent: $failsPercent, timeout: $timeout, interceptors: $interceptors)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppDioOption'))
      ..add(DiagnosticsProperty('apiUrl', apiUrl))
      ..add(DiagnosticsProperty('apiToken', apiToken))
      ..add(DiagnosticsProperty('failsPercent', failsPercent))
      ..add(DiagnosticsProperty('timeout', timeout))
      ..add(DiagnosticsProperty('interceptors', interceptors));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDioOptionImpl &&
            (identical(other.apiUrl, apiUrl) || other.apiUrl == apiUrl) &&
            (identical(other.apiToken, apiToken) ||
                other.apiToken == apiToken) &&
            (identical(other.failsPercent, failsPercent) ||
                other.failsPercent == failsPercent) &&
            (identical(other.timeout, timeout) || other.timeout == timeout) &&
            const DeepCollectionEquality()
                .equals(other._interceptors, _interceptors));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiUrl, apiToken, failsPercent,
      timeout, const DeepCollectionEquality().hash(_interceptors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDioOptionImplCopyWith<_$AppDioOptionImpl> get copyWith =>
      __$$AppDioOptionImplCopyWithImpl<_$AppDioOptionImpl>(this, _$identity);
}

abstract class _AppDioOption implements AppDioOption {
  const factory _AppDioOption(
      {required final String apiUrl,
      required final String apiToken,
      final int failsPercent,
      final Duration timeout,
      final List<Interceptor> interceptors}) = _$AppDioOptionImpl;

  @override
  String get apiUrl;
  @override
  String get apiToken;
  @override
  int get failsPercent;
  @override
  Duration get timeout;
  @override
  List<Interceptor> get interceptors;
  @override
  @JsonKey(ignore: true)
  _$$AppDioOptionImplCopyWith<_$AppDioOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

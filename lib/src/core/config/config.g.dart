// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeOverridesImpl _$$ThemeOverridesImplFromJson(Map<String, dynamic> json) =>
    _$ThemeOverridesImpl(
      importanceColor: (json['importance_color'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ThemeOverridesImplToJson(
        _$ThemeOverridesImpl instance) =>
    <String, dynamic>{
      'importance_color': instance.importanceColor,
    };

_$ConfigImpl _$$ConfigImplFromJson(Map<String, dynamic> json) => _$ConfigImpl(
      sentryDsn: json['sentry_dsn'] as String,
      apiUrl: json['api_url'] as String,
      apiToken: json['api_token'] as String,
      appMetricaToken: json['app_metrica_token'] as String,
      themeOverrides: ThemeOverrides.fromJson(
          json['theme_overrides'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConfigImplToJson(_$ConfigImpl instance) =>
    <String, dynamic>{
      'sentry_dsn': instance.sentryDsn,
      'api_url': instance.apiUrl,
      'api_token': instance.apiToken,
      'app_metrica_token': instance.appMetricaToken,
      'theme_overrides': instance.themeOverrides,
    };

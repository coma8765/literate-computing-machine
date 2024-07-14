// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigImpl _$$ConfigImplFromJson(Map<String, dynamic> json) => _$ConfigImpl(
      sentryDsn: json['sentryDsn'] as String,
      apiUrl: json['apiUrl'] as String,
      apiToken: json['apiToken'] as String,
    );

Map<String, dynamic> _$$ConfigImplToJson(_$ConfigImpl instance) =>
    <String, dynamic>{
      'sentryDsn': instance.sentryDsn,
      'apiUrl': instance.apiUrl,
      'apiToken': instance.apiToken,
    };

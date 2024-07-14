import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'config_provider.dart';

export 'config_provider.dart';
export 'config_sources/config_source.dart';

part 'config.freezed.dart';

part 'config.g.dart';

@freezed
class ThemeOverrides with _$ThemeOverrides {
  const factory ThemeOverrides({
    int? importanceColor,
  }) = _ThemeOverrides;

  factory ThemeOverrides.fromJson(Map<String, dynamic> json) =>
      _$ThemeOverridesFromJson(json);

  static ThemeOverrides of(BuildContext context) =>
      Config.themeOverridesOf(context);
}

@freezed
class Config with _$Config {
  const factory Config({
    required String sentryDsn,
    required String apiUrl,
    required String apiToken,
    required ThemeOverrides themeOverrides,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  static Config of(BuildContext context, {required ConfigAspects aspect}) =>
      ConfigProvider.of(context, aspect: aspect);

  static String sentryDsnOf(BuildContext context) =>
      ConfigProvider.of(context, aspect: ConfigAspects.sentryDsn).sentryDsn;

  static String apiUrlOf(BuildContext context) =>
      ConfigProvider.of(context, aspect: ConfigAspects.apiUrl).apiUrl;

  static String apiTokenOf(BuildContext context) =>
      ConfigProvider.of(context, aspect: ConfigAspects.apiToken).apiToken;

  static ThemeOverrides themeOverridesOf(BuildContext context) =>
      ConfigProvider.of(context, aspect: ConfigAspects.themeOverrides)
          .themeOverrides;
}

enum ConfigAspects {
  sentryDsn,
  apiUrl,
  apiToken,
  themeOverrides,
}

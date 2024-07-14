import 'package:freezed_annotation/freezed_annotation.dart';

export 'config_provider.dart';
export 'config_sources/config_source.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Config with _$Config {
  const factory Config({
    required String sentryDsn,
    required String apiUrl,
    required String apiToken,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}

enum ConfigAspects {
  sentryDsn,
  apiUrl,
  apiToken,
}

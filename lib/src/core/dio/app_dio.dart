import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_dio.freezed.dart';

@freezed
class AppDioOption with _$AppDioOption {
  const factory AppDioOption({
    required String apiUrl,
    required String apiToken,
    @Default(kDebugMode ? 40 : 10) int failsPercent,
    @Default(Duration(minutes: 1)) Duration timeout,
    @Default([]) List<Interceptor> interceptors,
  }) = _AppDioOption;
}

/// Application dio factory
class AppDio {
  static Dio factoryDio({required AppDioOption option}) {
    final headers = {
      HttpHeaders.authorizationHeader: option.apiToken,
      'X-Generate-Fails': option.apiToken,
    };

    final dio = Dio(
      BaseOptions(
        baseUrl: option.apiUrl,
        headers: headers,
        connectTimeout: option.timeout,
        receiveTimeout: option.timeout,
        sendTimeout: option.timeout,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dio.interceptors.addAll(option.interceptors);

    return dio;
  }
}

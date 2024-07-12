import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/src/core/config/config.dart';

Dio getDio({
  required String apiUrl,
  required String apiToken,
  int failsPercent = kDebugMode ? 40 : 10,
  Duration timeout = const Duration(minutes: 1),
  List<Interceptor> interceptors = const [],
}) {
  final baseUrl = Config().apiUrl;

  final headers = {
    HttpHeaders.authorizationHeader: Config().apiToken,
    'X-Generate-Fails': failsPercent,
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  dio.interceptors.addAll(interceptors);

  return dio;
}

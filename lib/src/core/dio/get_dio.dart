import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio getDio({
  required String apiUrl,
  required String apiToken,
  int failsPercent = kDebugMode ? 40 : 10,
  Duration timeout = const Duration(minutes: 1),
  List<Interceptor> interceptors = const [],
}) {
  final headers = {
    HttpHeaders.authorizationHeader: apiToken,
    'X-Generate-Fails': failsPercent,
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: apiUrl,
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

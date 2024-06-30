import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo/src/core/config/config.dart';

Dio getDio() {
  final baseUrl = Config().apiUrl ?? '';
  final headers = {
    HttpHeaders.authorizationHeader: Config().apiToken,
    'X-Generate-Fails': 80,
  };

  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      validateStatus: (status) => (status ?? 0) < 500,
    ),
  );
}

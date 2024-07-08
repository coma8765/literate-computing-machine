import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:exponential_back_off/exponential_back_off.dart';
import 'package:logging/logging.dart';

void addExponentialBackoffDio(
  Dio dio, {
  int retries = 10,
  Duration maxDelay = const Duration(minutes: 1),
}) {
  final logger = Logger('dio-backoff');

  final exponentialBackOff = ExponentialBackOff(
    maxAttempts: retries,
    maxDelay: maxDelay,
  );

  logger.config('add interceptor');
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      retries: retries,
      retryEvaluator: (error, attempt) async {
        final waitDuration = exponentialBackOff.computeDelay(
          attempt,
          Duration.zero,
        );

        logger.finer(
          'catch retry attempt=$attempt of $retries '
          'by error=${error.type}, '
          'status=${error.response?.statusCode}, '
          'wait ${waitDuration.inMilliseconds}ms',
        );

        await Future<void>.delayed(waitDuration);
        return true;
      },
      retryDelays: [const Duration(microseconds: 100)],
    ),
  );
}

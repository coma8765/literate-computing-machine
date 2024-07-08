import 'package:dio/dio.dart';
import 'package:network_state_provider/src/producers/producer.dart';
import 'package:rxdart/rxdart.dart';

class _DioStateInterceptor extends Interceptor {
  const _DioStateInterceptor({
    required void Function() onSuccessCallback,
    required void Function() onErrorCallback,
  })  : _onSuccessCallback = onSuccessCallback,
        _onErrorCallback = onErrorCallback;

  final void Function() _onSuccessCallback;
  final void Function() _onErrorCallback;

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   _onErrorCallback();
  //   super.onError(err, handler);
  // }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _onSuccessCallback();
    super.onResponse(response, handler);
  }
}

class DioStateProducer extends NetworkStateProducer {
  final _stream = BehaviorSubject<bool>.seeded(true);

  DioStateProducer(Dio dio) {
    dio.interceptors.add(
      _DioStateInterceptor(
        onSuccessCallback: () => _stream.add(true),
        onErrorCallback: () => _stream.add(false),
      ),
    );
  }

  Stream<bool> hasConnection() => _stream.stream.asBroadcastStream();

  @override
  void dispose() {
    _stream.close();
  }
}

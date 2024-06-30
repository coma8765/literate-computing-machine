import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

final _logger = Logger('bloc');

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    _logger.info('onChange(${bloc.runtimeType}, $change)');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.warning('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

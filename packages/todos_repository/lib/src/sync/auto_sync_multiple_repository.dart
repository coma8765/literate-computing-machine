import 'dart:async';

import 'package:logging/logging.dart';
import 'package:todos_api/todos_api.dart';

class AutoSyncMultipleRepository {
  AutoSyncMultipleRepository({
    required List<TodosApi> todosApis,
    this.retryDelay = const Duration(seconds: 10),
  }) : _todosApis = todosApis;

  final _logger = Logger('auto-sync-multiple-repositories');
  final List<TodosApi> _todosApis;
  final Duration retryDelay;

  bool _processing = false;

  Future<void> sync() async {
    if (_processing) {
      _logger.warning('already in process');
      return;
    }

    _logger.config('sync started');
    _processing = true;
    try {
      await _sync();
      _logger.finer('sync success');
    } catch (e, stack) {
      _logger.info('sync failed, got $e', e, stack);
    } finally {
      _processing = false;
    }
  }

  Future<void> trySyncUntilDone() async {
    var success = false;

    while (!success) {
      try {
        await sync();
        success = true;
      } catch (e) {
        _logger.info(
          'attempt failed, got $e, repeat after $retryDelay',
          e,
        );
        await Future<void>.delayed(retryDelay);
      }
    }
  }

  Timer periodic({Duration interval = const Duration(seconds: 30)}) {
    _logger.fine('add scheduler, interval=$interval');

    var called = false;
    return Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) async {
        if (called) return;
        called = true;

        _logger.finest('scheduler starts synchronization');

        await trySyncUntilDone();
        await Future<void>.delayed(interval);

        called = false;
      },
    );
  }

  Future<void> _waitReady() async {
    return Future.wait(_todosApis.map((todoApi) => todoApi.getTodos().first))
        as Future<void>;
  }

  Future<void> _sync() async {
    await _waitReady();

    final allTodosByApis = await Future.wait(
      _todosApis
          .map((todosApi) async => await todosApi.getUnsynchronizedTodos())
          .toList(),
      eagerError: true,
    );

    final todos = allTodosByApis.reduce(lastWriteWinsDiff);

    final countUnsynchronizedTodos = todos.where((t) => !t.isSynced).length;

    _logger.finer('got unsynchronizedTodos(len=$countUnsynchronizedTodos)');

    if (countUnsynchronizedTodos == 0) {
      _logger.shout('nothing sync');
      return;
    }

    await Future.wait(
      _todosApis.sublist(1).map(
            (todosApi) => Future.value(todosApi.sync(todos)),
          ),
      eagerError: true,
    );

    await _todosApis[0].sync(todos);

    await Future.wait(
      _todosApis.map((todosApi) async => await todosApi.reload()),
      eagerError: true,
    );
  }
}

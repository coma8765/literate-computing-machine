import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:git_hooks/git_hooks.dart' show Git, GitHooks, UserBackFun;
import 'package:logging/logging.dart';

final _logger = Logger('pre-commit');

void main(List<String> arguments) {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(
      '${record.time}|${record.loggerName}(${record.level}): '
      '${record.message}',
    );
  });

  // ignore: omit_local_variable_types
  final Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit,
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  // var commitMsg = Utils.getCommitEditMsg();
  // if (commitMsg.startsWith('fix:')) {
  //   return true; // you can return true let commit go
  // } else {
  //   print('you should add `fix` in the commit message');
  //   return false;
  // }
  return true;
}

Future<bool> preCommit() async {
  _logger.info("start pre commit analyze, run 'make pre-commit-check'");

  final result = await Process.run(
    'make',
    ['pre-commit-check'],
    runInShell: true,
  );
  _logger
    ..info(result.stdout)
    ..shout(result.stderr);

  return result.exitCode == 0;
}

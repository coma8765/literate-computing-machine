import 'dart:collection';

import 'package:todos_api/src/models/models.dart';

/// Compute diff, returns latest element if pair
List<TodoModel> lastWriteWinsDiff(List<TodoModel> a, List<TodoModel> b) {
  final Map<String, TodoModel?> hashmap = HashMap();

  for (final left in a) {
    hashmap[left.id] = left;
  }

  final todoDiff = <TodoModel>[];

  for (final right in b) {
    if (hashmap.containsKey(right.id)) {
      assert(hashmap[right.id] != null, 'got duplicated todo ${right.id}');

      final left = hashmap[right.id]!;
      hashmap[right.id] = null;

      todoDiff.add(_modelDiff(left, right));
    } else {
      todoDiff.add(_modelDiff(null, right));
    }
  }

  for (final left in hashmap.values.whereType<TodoModel>()) {
    todoDiff.add(_modelDiff(left, null));
  }

  return todoDiff;
}

TodoModel _modelDiff(TodoModel? a, TodoModel? b) {
  assert(
    a == null || b == null || a.id == b.id,
    'a and b must have some id',
  );
  assert((a ?? b) != null, 'a or b must be non null');

  final nonNull = (a ?? b)!;

  // Если хотя бы один из них удалён, а второй существует не удалён,
  // то удалить оба
  if ([a?.isRemoved, b?.isRemoved].contains(true) &&
      [a?.isRemoved, b?.isRemoved].contains(false)) {
    return nonNull.copyWith(isRemoved: true, isSynced: false);
  }

  // Если только один из них не синхронизирован, а второй не существует,
  // то возвращаем первый
  if ([a?.isSynced, b?.isSynced].where((e) => e is bool && !e).length == 1 &&
      [a, b].contains(null)) {
    if (a != null) return a;
    return b!;
  }
  // Иначе, если оба синхронизированы, но один из них отсутствует, удалить оба
  else if ([a, b].contains(null)) {
    return nonNull.copyWith(isRemoved: true, isSynced: false);
  }

  // В остальных случаях, проверяем на различие даты изменения в элементах
  final changeAtDiff = a!.changedAt.millisecondsSinceEpoch
      .compareTo(b!.changedAt.millisecondsSinceEpoch);

  // Получили различие в дате изменения, возвращаем новейший элемент
  if (changeAtDiff.abs() > 0.00001) {
    return (changeAtDiff > 0 ? a : b).copyWith(isSynced: false);
  }

  // Случай эквивалентности
  return nonNull.copyWith(isSynced: true);
}

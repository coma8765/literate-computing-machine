import 'package:equatable/equatable.dart';

class AppRouterConfig extends Equatable {
  AppRouterConfig.unknown()
      : uri = Uri(path: '/unknown'),
        todoId = null;

  AppRouterConfig.editTodo(this.todoId)
      : uri = Uri(path: '$editTodoPathStart$todoId');

  AppRouterConfig.home()
      : uri = Uri(path: '/'),
        todoId = null;

  static const homePathStart = '/';
  static const editTodoPathStart = '/todos/';

  final Uri uri;
  final String? todoId;

  bool get isHome => uri == AppRouterConfig.home().uri;

  bool get isEditTodo => uri == AppRouterConfig.editTodo(todoId).uri;

  bool get isUnknown => uri == AppRouterConfig.unknown().uri;

  @override
  String toString() => 'AppRouterConfig(uri: ${uri.path})';

  @override
  List<Object?> get props => [uri.path];
}

part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.showAll = false,
    this.updates = 0,
    this.todos = const [],
  });

  final HomeStatus status;
  final bool showAll;
  final List<Todo> todos;
  final int updates;

  List<Todo> get filteredTodos {
    if (showAll) return todos;

    return todos.where((t) => !t.done).toList();
  }

  int get countCompletedTodos {
    return todos.where((t) => t.done).length;
  }

  HomeState copyWith({
    HomeStatus Function()? status,
    bool Function()? showAll,
    List<Todo> Function()? todos,
    int Function()? updates,
  }) {
    return HomeState(
      status: status != null ? status() : this.status,
      showAll: showAll != null ? showAll() : this.showAll,
      todos: todos != null ? todos() : this.todos,
      updates: updates != null ? updates() : this.updates,
    );
  }

  @override
  List<Object> get props => [status, showAll, todos];
}

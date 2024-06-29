part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeSubscriptionRequested extends HomeEvent {
  const HomeSubscriptionRequested();
}

final class HomeShowAllToggled extends HomeEvent {
  const HomeShowAllToggled({required this.showAll});

  final bool showAll;

  @override
  List<Object> get props => [showAll];
}

final class HomeTodoDeleted extends HomeEvent {
  const HomeTodoDeleted({
    required this.todo,
  });

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class HomeTodoSave extends HomeEvent {
  const HomeTodoSave({
    required this.todo,
  });

  final Todo todo;

  @override
  List<Object?> get props => todo.props;
}

final class HomeTodoDoneToggled extends HomeEvent {
  const HomeTodoDoneToggled({
    required this.todo,
    required this.isDone,
  });

  final Todo todo;
  final bool isDone;

  @override
  List<Object> get props => [isDone];
}

import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/color_theme.dart';
import 'package:todo/src/navigation/app_router_config.dart';
import 'package:todo/src/presentation/pages/edit_todo_page/edit_todo_page.dart';
import 'package:todo/src/presentation/pages/home_page/home_page.dart';
import 'package:uuid/uuid.dart';

class AppRouterDelegate extends RouterDelegate<AppRouterConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouterConfig> {
  AppRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>() {
    assert(AppRouterConfig.home() == currentConfiguration, '????');
  }

  final GlobalKey<NavigatorState> _navigatorKey;

  AppRouterConfig _currentState = AppRouterConfig.home();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  AppRouterConfig get currentConfiguration {
    return _currentState;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (Route<Object?> page, _) {
        _currentState = AppRouterConfig.home();
        notifyListeners();
        return true;
      },
      pages: [
        const CupertinoPage(
          key: ValueKey('HomePage'),
          child: HomePage(),
        ),
        if (_currentState.isEditTodo)
          CupertinoPage(
            key: ValueKey('EditTodo${_currentState.todoId}'),
            child: TodoPage(
              todoId: _currentState.todoId ?? const Uuid().v4(),
              key: ValueKey('EditTodo${_currentState.todoId}Page'),
            ),
          ),
        if (_currentState.isUnknown)
          CupertinoPage(
            key: const ValueKey('Unknown'),
            child: Container(color: AppColors.green),
          ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(AppRouterConfig configuration) async {
    _currentState = configuration;
  }

  void editTodoTrigger(String? todoId) {
    _currentState = AppRouterConfig.editTodo(todoId);
    notifyListeners();
  }

  void homeTrigger() {
    _currentState = AppRouterConfig.home();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    removeListener(notifyListeners);
  }
}

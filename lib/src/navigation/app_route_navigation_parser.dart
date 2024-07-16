import 'package:flutter/cupertino.dart';
import 'package:todo/src/navigation/app_router_config.dart';

class AppRouterParser extends RouteInformationParser<AppRouterConfig> {
  @override
  Future<AppRouterConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;

    // Handle '' and '/'
    if (uri.pathSegments.isEmpty || uri.path == AppRouterConfig.homePathStart) {
      return AppRouterConfig.home();
    }

    // Handle '/todos/:id'
    if (uri.path.startsWith(
          AppRouterConfig.editTodoPathStart,
        ) &&
        uri.pathSegments.length == 2) {
      return AppRouterConfig.editTodo(uri.pathSegments[1]);
    }

    // Handle unknown routes
    return AppRouterConfig.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRouterConfig configuration) {
    return RouteInformation(uri: configuration.uri);
  }
}

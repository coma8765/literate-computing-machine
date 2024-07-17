import 'package:flutter/widgets.dart';
import 'package:todo/src/core/config/config.dart';

class ConfigProvider extends InheritedModel<ConfigAspects> {
  const ConfigProvider({
    required super.child,
    required this.config,
    super.key,
  });

  final Config config;

  @override
  bool updateShouldNotify(covariant ConfigProvider oldWidget) {
    return oldWidget.config != config;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant ConfigProvider oldWidget,
    Set<ConfigAspects> dependencies,
  ) {
    if (dependencies.contains(ConfigAspects.sentryDsn) &&
        oldWidget.config.sentryDsn != config.sentryDsn) {
      return true;
    }
    if (dependencies.contains(ConfigAspects.apiUrl) &&
        oldWidget.config.apiUrl != config.apiUrl) {
      return true;
    }
    if (dependencies.contains(ConfigAspects.apiToken) &&
        oldWidget.config.apiToken != config.apiToken) {
      return true;
    }

    if (dependencies.contains(ConfigAspects.themeOverrides) &&
        oldWidget.config.themeOverrides != config.themeOverrides) {
      return true;
    }

    return false;
  }

  static ConfigProvider? maybeOf(
    BuildContext context, {
    required ConfigAspects aspect,
  }) {
    return context.dependOnInheritedWidgetOfExactType<ConfigProvider>(
      aspect: aspect,
    );
  }

  static Config of(
    BuildContext context, {
    required ConfigAspects aspect,
  }) {
    final instance = ConfigProvider.maybeOf(context, aspect: aspect);
    assert(instance != null, "instance ConfigProvider doesn't exists");
    return instance!.config;
  }
}

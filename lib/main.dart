import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/presentation/pages/home_page.dart';

void main() {
  debugPaintSizeEnabled = false;

  runApp(const MyApp());
}

/// An application.
class MyApp extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'TODO',
      color: CupertinoColors.black,
      theme: AppTheme(),
      // home: const UtilsPage(),
      home: const HomePage(),
    );
  }
}

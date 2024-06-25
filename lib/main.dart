import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/profiling/sentry.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/presentation/pages/home_page.dart';

void main() async {
  await initializeDateFormatting('ru', '');
  await initConfig();

  await includeSentry(
    appRunner: () => runApp(const MyApp()),
  );
}

const _defaultLocale = Locale('ru');
const _supportedLocales = [
  Locale('ru'),
  Locale('en'),
];

const _localeDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultWidgetsLocalizations.delegate,
];


/// An application.
class MyApp extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'TODO',
      color: AppTheme().scaffoldBackgroundColor,
      theme: AppTheme(),
      localizationsDelegates: _localeDelegates,
      // home: const UtilsPage(),
      home: const HomePage(),
      supportedLocales: _supportedLocales,
      locale: _defaultLocale,
    );
  }
}

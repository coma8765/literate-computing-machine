import 'package:intl/intl.dart';

abstract final class DateTheme {
  static final _fullDateFormat = DateFormat('d MMMM y', 'ru');
  static final _monthDayFormat = DateFormat('d MMMM', 'ru');

  static String toFullDateString(DateTime date) {
    return _fullDateFormat.format(date);
  }

  static String toMonthDayString(DateTime date) {
    return _monthDayFormat.format(date);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:todo/src/presentation/widgets/date_picker/ios_date_picker.dart';



/// Creates a pop-up window for selecting a date
/// in Android Material style
Future<DateTime?> androidDatePick(BuildContext context) {
  // TODO(coma8765): Реализовать нативный выбор даты для Андроид
  return iOSDatePick(context);
}

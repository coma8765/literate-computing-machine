import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';
import 'package:todo/src/presentation/widgets/date_picker/android_date_picker.dart';
import 'package:todo/src/presentation/widgets/date_picker/ios_date_picker.dart';

/// Creates a pop-up window for selecting a date on the native platform
Future<DateTime?> datePick(BuildContext context) {
  if (Platform.isAndroid) {
    return androidDatePick(context);
  }

  if (Platform.isIOS) {
    return iOSDatePick(context);
  }

  throw UnimplementedError('Date picker implemented only for Android & iOS');
}

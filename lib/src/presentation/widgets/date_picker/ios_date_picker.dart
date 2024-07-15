import 'package:flutter/cupertino.dart';
import 'package:todo/src/presentation/widgets/buttons/buttons.dart';

const _popupBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(16.0),
  topRight: Radius.circular(16.0),
);

const _pageHeightPercent = 0.4;

/// Creates a pop-up window for selecting a date
/// in iOS Cupertino style
Future<DateTime?> iOSDatePick(BuildContext context) {
  return showCupertinoModalPopup<DateTime?>(
    useRootNavigator: false,
    context: context,
    builder: (_) => const _IOSDatePicker(),
  );
}

class _IOSDatePicker extends StatefulWidget {
  const _IOSDatePicker();

  @override
  State<StatefulWidget> createState() => _IOSDatePickerState();
}

class _IOSDatePickerState extends State<_IOSDatePicker> {
  late DateTime startDate;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    date = startDate;
  }

  void _complete() {
    Navigator.of(context).pop(date);
  }

  void _updateDate(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = CupertinoTheme.of(context).scaffoldBackgroundColor;
    final popupHeight = MediaQuery.sizeOf(context).height * _pageHeightPercent;

    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: popupHeight,
        child: ClipRRect(
          borderRadius: _popupBorderRadius,
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CancelButton(
                onPressed: (context) => Navigator.of(context).pop(),
              ),
              trailing: SaveButton(
                onPressed: _complete,
                padding: EdgeInsetsDirectional.zero,
              ),
              backgroundColor: backgroundColor,
            ),
            backgroundColor: backgroundColor,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: _updateDate,
              initialDateTime: startDate,
              minimumDate: startDate,
            ),
          ),
        ),
      ),
    );
  }
}

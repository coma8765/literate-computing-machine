import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

const _text = 'Отменить';

/// A cancel button
class CancelButton extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const CancelButton({
    this.onPressed,
    super.key,
  });

  /// The callback that is called when the button
  /// is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.blue.resolveFrom(context);
    final textStyle = AppTextStyles.body.copyWith(
      color: textColor,
    );


    return CupertinoButton(
      padding: EdgeInsetsDirectional.zero,
      onPressed: () => onPressed?.call(context),
      child: Text(
        _text,
        style: textStyle,
      ),
    );
  }
}

/// A navigation back button
class NavigationCancelButton extends CancelButton {
  /// This class creates an instance of [StatelessWidget].
  const NavigationCancelButton({
    super.key,
  }) : super(
    onPressed: _navigationBack,
  );

  static void _navigationBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}

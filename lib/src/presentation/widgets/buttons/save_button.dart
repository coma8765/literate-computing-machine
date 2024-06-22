import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/presentation/widgets/buttons/custom_button.dart';

const _defaultText = 'Cохранить';


/// A stylized button to complete the action
class SaveButton extends CustomButton {
  /// This class creates an instance of [StatelessWidget].
  factory SaveButton({
    required void Function()? onPressed,
    Widget? child,
    Color? color,
    double? pressedOpacity,
    BorderRadius? borderRadius,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Key? key,
  }) {
    return SaveButton._(
      color: color ?? AppColors.blue,
      key: key,
      onPressed: onPressed,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      alignment: alignment,
      padding: padding,
      child: child ?? const Text(_defaultText),
    );
  }

  const SaveButton._({
    required super.child,
    required super.onPressed,
    super.key,
    super.pressedOpacity,
    super.borderRadius,
    super.alignment,
    super.color,
    super.padding,
  });
}

import 'package:flutter/cupertino.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/src/presentation/widgets/buttons/custom_button.dart';

/// A stylized button to complete the action
class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.onPressed,
    super.key,
    this.color,
    this.pressedOpacity,
    this.borderRadius,
    this.alignment,
    this.padding,
  });

  final void Function()? onPressed;
  final Color? color;
  final double? pressedOpacity;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w600,
    );

    return CustomButton(
      onPressed: onPressed,
      color: color,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      alignment: alignment,
      padding: padding,
      child: Text(context.l10n.saveText, style: textStyle),
    );
  }
}

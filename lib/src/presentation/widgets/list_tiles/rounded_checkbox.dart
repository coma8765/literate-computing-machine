import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

const _kDefaultWidth = 24.0;
const _kDefaultBorderWidth = 1.5;

/// A RoundedCheckbox, also for ListTile
class RoundedCheckbox extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const RoundedCheckbox({
    this.width = _kDefaultWidth,
    this.borderWidth = _kDefaultBorderWidth,
    this.onChange,
    this.value = false,
    super.key,
    this.borderColor,
    this.activeColor,
    this.inactiveColor,
  });

  /// Width of RoundedCheckbox.
  final double width;

  /// The width of this side of the circle, in logical pixels.
  final double borderWidth;

  /// Called when the value of the checkbox should change.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool?)? onChange;

  /// Value of checkbox
  final bool value;

  /// A color of border
  final Color? borderColor;

  /// A background color of active mode
  final Color? activeColor;

  /// A background color of inactive mode
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final borderColor = CupertinoDynamicColor.resolve(
      this.borderColor ?? AppColors.support.separator,
      context,
    );

    final activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? AppColors.green,
      context,
    );

    final inactiveColor = CupertinoDynamicColor.resolve(
      this.inactiveColor ?? const Color(0x00000000),
      context,
    );

    final scale = width / CupertinoCheckbox.width;
    final borderWidthScaled = borderWidth / scale;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: value ? null : inactiveColor,
      ),
      child: Transform.scale(
        scale: scale,
        child: CupertinoCheckbox(
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          value: value,
          onChanged: onChange,
          shape: const CircleBorder(),
          side: BorderSide(
            color: value ? activeColor : borderColor,
            width: borderWidthScaled,
          ),
        ),
      ),
    );
  }
}

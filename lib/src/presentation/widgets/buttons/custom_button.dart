import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

/// A styled button
class CustomButton extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget] with base style.
  const CustomButton({
    required this.child,
    required this.onPressed,
    super.key,
    this.pressedOpacity,
    this.borderRadius,
    this.alignment,
    this.color,
    this.padding,
    this.margin = EdgeInsets.zero,
  }) : _filled = false;

  /// This class creates an instance of [StatelessWidget] with filled style.
  const CustomButton.filled({
    required this.child,
    required this.onPressed,
    super.key,
    this.pressedOpacity,
    this.borderRadius,
    this.alignment,
    this.color,
    this.padding,
    this.margin = EdgeInsets.zero,
  }) : _filled = true;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The callback that is called when the button is tapped
  /// or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final void Function()? onPressed;

  /// The opacity that the button will fade to when it is pressed.
  /// The button will have an opacity of 1.0 when it is not pressed.
  ///
  /// This defaults to 0.4. If null, opacity will not change on pressed if using
  /// your own custom effects is desired.
  final double? pressedOpacity;

  /// The radius of the button's corners when it has a background color.
  ///
  /// Defaults to round corners of 8 logical pixels.
  final BorderRadius? borderRadius;

  /// The alignment of the button's [child].
  ///
  /// Typically buttons are sized to be just big enough to contain the child
  /// and its [padding]. If the button's size is constrained to a fixed size,
  /// for example by enclosing it with a [SizedBox], this property defines
  /// how the child is aligned within the available space.
  ///
  /// Always defaults to [Alignment.center].
  ///
  final AlignmentGeometry? alignment;

  /// The amount of space to surround the child inside the bounds of the button.
  ///
  /// Defaults to 16.0 pixels.
  final EdgeInsetsGeometry? padding;

  /// Color for text of button
  final Color? color;

  /// Current state of the button
  bool get _enabled => onPressed != null;

  /// Type of the button
  final bool _filled;

  /// Margin around the content area of the section encapsulating [child].
  ///
  /// Defaults to zero padding if constructed with standard
  /// [CustomButton] constructor.
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    final foregroundColor = _enabled
        ? (color ?? CupertinoDynamicColor.resolve(theme.primaryColor, context))
        : CupertinoDynamicColor.resolve(AppColors.label.tertiary, context);

    final textStyle = theme.textTheme.textStyle.copyWith(
      color: foregroundColor,
    );

    final childWrapped = DefaultTextStyle(style: textStyle, child: child);

    late Widget buttonWidget;
    if (_filled) {
      buttonWidget = CupertinoTheme(
        data: theme.copyWith(
          primaryColor: AppColors.back.secondary,
        ),
        child: CupertinoButton.filled(
          onPressed: onPressed,
          disabledColor: AppColors.back.secondary,
          pressedOpacity: pressedOpacity,
          borderRadius: borderRadius,
          alignment: alignment ?? Alignment.center,
          padding: padding,
          child: childWrapped,
        ),
      );
    } else {
      buttonWidget = CupertinoButton(
        onPressed: onPressed,
        disabledColor: const Color(0x00000000),
        pressedOpacity: pressedOpacity,
        borderRadius: borderRadius,
        alignment: alignment ?? Alignment.center,
        padding: padding,
        child: childWrapped,
      );
    }

    return Padding(padding: margin, child: buttonWidget);
  }
}

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
    super.key,
  });

  /// Width of RoundedCheckbox.
  final double width;

  /// The width of this side of the circle, in logical pixels.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final separatorColor = AppColors.support.separator.resolveFrom(context);

    final scale = width / CupertinoCheckbox.width;
    final borderWidthScaled = borderWidth / scale;

    return Transform.scale(
      scale: scale,
      child: CupertinoCheckbox(
        value: false,
        onChanged: (value) {},
        shape: const CircleBorder(),
        side: BorderSide(
          color: separatorColor,
          width: borderWidthScaled,
        ),
      ),
    );
  }
}

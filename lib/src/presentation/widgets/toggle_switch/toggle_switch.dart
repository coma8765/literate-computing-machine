import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/color_theme.dart';

/// A toggle switch
class ToggleSwitch extends StatefulWidget {
  /// This class creates an instance of [StatefulWidget].
  const ToggleSwitch({
    this.onChanged,
    this.defaultValue = true,
    super.key,
  });

  /// Called when the user toggles with switch on or off.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;

  /// Default value of toggle
  final bool defaultValue;

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
  }

  void _update(bool newValue) {
    setState(() {
      value = newValue;
    });

    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.green.resolveFrom(context);
    final trackColor = AppColors.support.overlay.resolveFrom(context);

    return CupertinoSwitch(
      activeColor: activeColor,
      trackColor: trackColor,
      value: value,
      onChanged: _update,
    );
  }
}

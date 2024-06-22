import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/color_theme.dart';

const _borderRadius = BorderRadius.all(Radius.circular(8.91));
const _itemBorderRadius = BorderRadius.all(Radius.circular(6.93));

const _itemMargin = EdgeInsets.symmetric(
  vertical: 2.25,
  horizontal: 2.0,
);

class MultiToggleSwitch extends StatefulWidget {
  const MultiToggleSwitch({
    required this.itemCount,
    required this.itemBuilder,
    this.itemMargin = _itemMargin,
    this.borderRadius = _borderRadius,
    this.itemBorderRadius = _itemBorderRadius,
    this.itemHeight,
    this.itemWeight,
    this.itemActiveColor,
    this.itemInactiveColor,
    this.defaultItem = 0,
    this.onChange,
    super.key,
  });

  final int itemCount;

  final Widget Function({
    required BuildContext context,
    required int index,
    required bool isActive,
  }) itemBuilder;

  final BorderRadius borderRadius;
  final BorderRadius itemBorderRadius;

  final double? itemHeight;
  final double? itemWeight;
  final EdgeInsets itemMargin;

  final Color? itemActiveColor;
  final Color? itemInactiveColor;

  final int defaultItem;

  final void Function(int)? onChange;

  @override
  State<MultiToggleSwitch> createState() => _MultiToggleSwitchState();
}

class _MultiToggleSwitchState extends State<MultiToggleSwitch> {
  late List<bool> states;

  late List<Widget> _tilesActive;
  late List<Widget> _tilesInactive;

  @override
  void initState() {
    super.initState();
    _updateState(widget.defaultItem);
    _buildTiles();
  }

  void _updateState(int currentState) {
    states = List.generate(
      widget.itemCount,
      (index) => index == currentState,
    );
  }

  void _buildTiles() {
    _tilesActive = List.generate(widget.itemCount, (index) {
      return _buildTile(index, true);
    });

    _tilesInactive = List.generate(widget.itemCount, (index) {
      return _buildTile(index, false);
    });
  }

  Widget _buildTile(int index, bool state) {
    return SizedBox(
      height: widget.itemHeight,
      width: widget.itemWeight,
      child: _SwitchTile(
        key: UniqueKey(),
        onTap: () {
          setState(() {
            _updateState(index);
          });
        },
        widget: widget,
        state: state,
        index: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveBackgroundColor = CupertinoDynamicColor.resolve(
      widget.itemInactiveColor ?? AppColors.support.overlay,
      context,
    );

    final children = List.generate(widget.itemCount, (index) {
      return states[index] ? _tilesActive[index] : _tilesInactive[index];
    });

    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: inactiveBackgroundColor,
      ),
      padding: EdgeInsets.zero,
      child: Row(
        children: children,
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.widget,
    required this.index,
    required this.state,
    this.onTap,
    super.key,
  });

  final MultiToggleSwitch widget;

  final int index;
  final bool state;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final activeBackgroundColor = CupertinoDynamicColor.resolve(
      widget.itemActiveColor ?? AppColors.back.elevated,
      context,
    );

    final backgroundColor = state ? activeBackgroundColor : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: widget.itemMargin,
        height: widget.itemHeight,
        width: widget.itemWeight,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: backgroundColor,
        ),
        child: Center(
          child: widget.itemBuilder(
            context: context,
            index: index,
            isActive: state,
          ),
        ),
      ),
    );
  }
}

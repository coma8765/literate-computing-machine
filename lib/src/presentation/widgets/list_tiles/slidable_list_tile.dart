import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/core/theme/color_theme.dart';

import 'package:todo/src/presentation/widgets/list_tiles/list_tile.dart';

/// Custom widget for list tiles with slaidable actions
class CustomSlidableListTile extends CustomListTile {
  /// This class creates an instance of [StatelessWidget].
  const CustomSlidableListTile({
    required super.key,
    required super.title,
    required this.startActionPane,
    required this.endActionPane,
    super.subtitle,
    super.leading,
    super.trailing,
    super.onTap,
    this.onRemove,
  });

  final void Function()? onRemove;

  final ActionPane startActionPane;
  final ActionPane endActionPane;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ObjectKey(key),
      startActionPane: startActionPane,
      endActionPane: endActionPane,
      child: Builder(builder: super.build),
    );
  }
}

class CustomIconSlidableAction extends StatelessWidget {
  const CustomIconSlidableAction({
    required this.icon,
    this.backgroundColor = AppColors.blue,
    this.foregroundColor = AppColors.white,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final void Function(BuildContext)? onPressed;

  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor,
      context,
    );
    final foregroundColor = CupertinoDynamicColor.resolve(
      this.foregroundColor,
      context,
    );

    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      icon: icon,
    );
  }
}

class CustomActionPane extends ActionPane {
  factory CustomActionPane({
    required List<Widget> children,
    Key? key,
    DismissiblePane? dismissible,
  }) {
    return CustomActionPane._(
      key: key,
      extentRatio: 0.2 * children.length,
      dismissible: dismissible,
      children: children,
    );
  }

  const CustomActionPane._({
    required super.children,
    super.extentRatio,
    super.motion = const ScrollMotion(),
    super.key,
    super.dismissible,
  }) : super(closeThreshold: 0.2);
}

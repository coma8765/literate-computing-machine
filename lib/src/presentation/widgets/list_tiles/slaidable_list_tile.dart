import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/core/theme/color_theme.dart';

import 'package:todo/src/presentation/widgets/list_tiles/list_tile.dart';

/// Custom widget for list tiles with slaidable actions
class CustomSlaidableListTile extends CustomListTile {
  /// This class creates an instance of [StatelessWidget].
  const CustomSlaidableListTile({
    required super.title,
    super.subtitle,
    super.leading,
    super.trailing,
    super.onTap,
    this.onRemove,
    super.key,
  });

  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    // TODO(coma8765): refactor this widget
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      // TODO(com8765): move key to up tree level
      key: UniqueKey(),
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 0.2,
        closeThreshold: 0.2,
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: AppColors.green.resolveFrom(context),
            foregroundColor: AppColors.white.resolveFrom(context),
            icon: CupertinoIcons.check_mark_circled_solid,
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        dismissible: DismissiblePane(onDismissed: onRemove ?? () {}),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context) {},
            backgroundColor: AppColors.greyLight.resolveFrom(context),
            foregroundColor: AppColors.white.resolveFrom(context),
            icon: CupertinoIcons.info_circle_fill,
          ),
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              onRemove?.call();
            },
            backgroundColor: AppColors.red.resolveFrom(context),
            foregroundColor: AppColors.white.resolveFrom(context),
            icon: CupertinoIcons.trash_fill,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Builder(builder: super.build),
    );
  }
}

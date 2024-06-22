import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

export './rounded_checkbox.dart';

const _kTilePadding = EdgeInsets.all(16.0);
const _kTileWithSubtitlePadding = EdgeInsets.symmetric(
  vertical: 12.0,
  horizontal: 16.0,
);

const _kTileIconHeight = 24.0;
const _kTileTextHeight = 24.0;

const _kTileWithSubtitleTextHeight = 22.0;
const _kTileLeadingToTitle = 12.0;

const _kSubtitleHeight = 20.0;

/// Space between title and subtitle
/// External value 'packages/flutter/lib/src/cupertino/list_tile.dart'
const _kNotchedTitleToSubtitle = 3.0;

/// Custom widget for list tiles
class CustomListTile extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const CustomListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// A [title] is used to convey the central information. Usually a [Text].
  final Widget title;

  /// A [subtitle] is used to display additional information. It is located
  /// below [title]. Usually a [Text] widget.
  final Widget? subtitle;

  /// A widget displayed at the start of the [CupertinoListTile]. This is
  /// typically an `Icon` or an `Image`.
  final Widget? leading;

  /// A widget displayed at the end of the [CupertinoListTile]. This is usually
  /// a right chevron icon (e.g. `CupertinoListTileChevron`), or an `Icon`.
  final Widget? trailing;

  /// The [onTap] function is called when a user taps on [CupertinoListTile]. If
  /// left `null`, the [CupertinoListTile] will not react on taps. If this is a
  /// `Future<void> Function()`, then the [CupertinoListTile] remains activated
  /// until the returned future is awaited. This is according to iOS behavior.
  /// However, if this function is a `void Function()`, then the tile is active
  /// only for the duration of invocation.
  final FutureOr<void> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = AppColors.label.primary.resolveFrom(context);
    final backgroundColor = AppColors.back.secondary.resolveFrom(context);

    final foregroundTextStyle = AppTextStyles.body.copyWith(
      color: foregroundColor,
    );

    final padding =
        subtitle == null ? _kTilePadding : _kTileWithSubtitlePadding;

    final subtitleLayout = subtitle != null
        ? SizedBox(
            height: _kSubtitleHeight - _kNotchedTitleToSubtitle,
            child: Stack(
              children: [
                Positioned(
                  top: -_kNotchedTitleToSubtitle,
                  child: subtitle!,
                ),
              ],
            ),
          )
        : null;

    final titleHeight =
        subtitle == null ? _kTileTextHeight : _kTileWithSubtitleTextHeight;

    return CupertinoListTile(
      onTap: onTap,
      padding: padding,
      leadingSize: _kTileIconHeight,
      leading: SizedBox(
        height: _kTileIconHeight,
        width: _kTileIconHeight,
        child: leading,
      ),
      leadingToTitle: _kTileLeadingToTitle,
      title: Container(
        height: titleHeight,
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: DefaultTextStyle(
          textAlign: TextAlign.end,
          style: foregroundTextStyle,
          child: title,
        ),
      ),
      subtitle: subtitleLayout,
      trailing: trailing,
      backgroundColor: backgroundColor,
    );
  }
}

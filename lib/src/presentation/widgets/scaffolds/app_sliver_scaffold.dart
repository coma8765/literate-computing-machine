import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

const _kNavBarBorderWidth = 0.5;
const _kNavBarHeaderHeight = 44.0;

const _kNavBarPaddingFull = EdgeInsets.symmetric(horizontal: 16.0);
const _kNavBarPaddingSpoiled = EdgeInsets.symmetric(
  horizontal: 16.0,
  vertical: 9.0,
);

const _kInitialScrollOffset = 1.0;

/// An AppSliverScaffold
class AppSliverScaffold extends StatefulWidget {
  /// This class creates an instance of [StatefulWidget].
  const AppSliverScaffold({
    required this.slivers,
    required this.largeTitle,
    super.key,
  });

  /// The navigation bar's title.
  final Widget largeTitle;

  /// The slivers to place inside the scaffold.
  final List<Widget> slivers;

  @override
  State<StatefulWidget> createState() => _AppSliverScaffoldState();
}

class _AppSliverScaffoldState extends State<AppSliverScaffold> {
  bool _spoiled = false;
  Timer? _spoiledTimer;

  final double _spoiledTitleHeight = _kNavBarHeaderHeight;

  // Based on iOS component library
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: _kInitialScrollOffset,
  );

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final spoiled = _scrollController.offset >= _spoiledTitleHeight;

      if (spoiled != _spoiled) {
        _spoiled = spoiled;

        if (_spoiledTimer != null && _spoiledTimer!.isActive) {
          _spoiledTimer?.cancel();
        }

        _spoiledTimer = Timer(
          const Duration(microseconds: 200),
          () => setState(() {
            _spoiled = spoiled;
          }),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    final navbarBorderColor = AppColors.support.separator.resolveFrom(context);
    final navbarBackground = _spoiled
        ? AppColors.support.navbar.resolveFrom(context)
        : theme.scaffoldBackgroundColor;

    final navbarBorder = _spoiled
        ? Border(
            bottom: BorderSide(
              color: navbarBorderColor,
              width: _kNavBarBorderWidth,
            ),
          )
        : null;

    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Builder(builder: _buildLargeTitle),
            padding: EdgeInsetsDirectional.zero,
            border: navbarBorder,
            backgroundColor: navbarBackground,
          ),
          ...widget.slivers,
        ],
      ),
    );
  }

  Widget _buildLargeTitle(BuildContext context) {
    final height = !_spoiled ? _kNavBarHeaderHeight : null;

    final padding = !_spoiled ? _kNavBarPaddingFull : _kNavBarPaddingSpoiled;

    return Container(
      height: height,
      padding: padding,
      // alignment: Alignment.topCenter,
      child: widget.largeTitle,
    );
  }
}

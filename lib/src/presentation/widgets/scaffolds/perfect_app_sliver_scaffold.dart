import 'package:flutter/cupertino.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:todo/src/presentation/widgets/scaffolds/app_sliver_scaffold.dart';

/// An AppSliverScaffold with pixel perfect extension
class PerfectAppSliverScaffold extends StatelessWidget {
  /// This class creates an instance of [StatefulWidget].
  const PerfectAppSliverScaffold({
    required this.slivers,
    required this.largeTitle,
    required this.assetPath,
    super.key,
  });

  /// The navigation bar's title.
  final Widget largeTitle;

  /// The slivers to place inside the scaffold.
  final List<Widget> slivers;

  /// A path to asset with target view
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return PixelPerfect(
      assetPath: assetPath,
      scale: 2,
      initOpacity: 1.0,
      initBottom: 0,
      child: AppSliverScaffold(
        slivers: slivers,
        largeTitle: largeTitle,
      ),
    );
  }
}

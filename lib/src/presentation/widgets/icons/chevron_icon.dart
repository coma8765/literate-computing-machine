import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/assets/assets.dart';

/// A Chevron Icon, typically use in a ListTile
class ChevronIcon extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const ChevronIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsAssets.chevron,
      semanticsLabel: 'chevron',
    );
  }
}

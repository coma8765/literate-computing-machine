import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A Custom Chevron, typically use in a ListTile
class CustomChevron extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const CustomChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/chevron.svg',
      semanticsLabel: 'chevron',
    );
  }
}

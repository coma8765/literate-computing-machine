import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/assets/assets.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/theme/color_theme.dart';

class ImportanceLowIcon extends StatelessWidget {
  const ImportanceLowIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsAssets.priorityLow,
      height: 20.0,
      width: 16.0,
      fit: BoxFit.none,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/assets/assets.dart';
import 'package:todo/src/core/config/config.dart';
import 'package:todo/src/core/theme/color_theme.dart';

class ImportanceHighIcon extends StatelessWidget {
  const ImportanceHighIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final themeOverrides = ThemeOverrides.of(context);

    final importanceColor = themeOverrides.importanceColor != null
        ? Color(themeOverrides.importanceColor!)
        : AppColors.red;

    return SvgPicture.asset(
      IconsAssets.priorityHigh,
      height: 20.0,
      width: 16.0,
      fit: BoxFit.none,
      colorFilter: ColorFilter.mode(importanceColor, BlendMode.srcIn),
    );
  }
}

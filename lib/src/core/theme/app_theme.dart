import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/color_theme.dart';
import 'package:todo/src/core/theme/text_theme.dart';

/// Custom Cupertino Theme Data
class AppTheme extends CupertinoThemeData {
  /// Creates AppTheme's instance for both themes
  factory AppTheme() {
    return AppTheme._(
      primaryColor: AppColors.back.secondary,
      barBackgroundColor: AppColors.support.navbar,
      scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
        color: AppColors.back.primary.color,
        darkColor: AppColors.back.iOSPrimary.darkColor,
      ),
      primaryContrastingColor: AppColors.back.secondary.darkColor,
      textTheme: _textTheme,
    );
  }

  const AppTheme._({
    super.primaryColor,
    super.primaryContrastingColor,
    super.textTheme,
    super.barBackgroundColor,
    super.scaffoldBackgroundColor,
  });

  static CupertinoTextThemeData get _textTheme => CupertinoTextThemeData(
        primaryColor: AppColors.label.primary,
        textStyle: AppTextStyles.body.copyWith(
          color: AppColors.label.primary,
        ),
        navLargeTitleTextStyle: AppTextStyles.largeTitleBold.copyWith(
          color: AppColors.label.primary,
        ),
        navTitleTextStyle: AppTextStyles.headline.copyWith(
          color: AppColors.label.primary,
        ),
      );
}

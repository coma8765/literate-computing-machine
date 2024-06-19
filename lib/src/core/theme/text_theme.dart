import 'package:flutter/cupertino.dart';

/// Application text themes
abstract final class AppTextStyles {
  static TextStyle get _baseDisplay => const TextStyle(
        fontFamily: 'SFProDisplay',
        fontWeight: FontWeight.normal,
        color: CupertinoColors.destructiveRed,
        backgroundColor: Color(0x00000000),
      );

  static TextStyle get _base => const TextStyle(
        fontFamily: 'SFProText',
        fontWeight: FontWeight.normal,
        color: CupertinoColors.destructiveRed,
        backgroundColor: Color(0x00000000),
      );

  /// Large title — 38/46
  static TextStyle get largeTitle => _baseDisplay.copyWith(
        fontSize: 38,
        height: 46 / 38,
        fontWeight: FontWeight.w700,
      );

  /// Large (Default) / Large Title Bold
  static TextStyle get largeTitleBold => _baseDisplay.copyWith(
        fontSize: 34,
        height: 41 / 34,
        letterSpacing: 0.37,
        fontWeight: FontWeight.w700,
      );

  /// Title — 20/24
  static TextStyle get title => _baseDisplay.copyWith(
        fontSize: 20,
        height: 24 / 20,
        fontWeight: FontWeight.w600,
      );

  /// Headline — 17/22
  static TextStyle get headline => _base.copyWith(
        fontSize: 17,
        height: 22 / 17,
        letterSpacing: -0.41,
        fontWeight: FontWeight.w600,
      );

  /// Body — 17/22
  static TextStyle get body => _base.copyWith(
        fontSize: 17,
        height: 22 / 17,
        letterSpacing: -0.41,
        fontWeight: FontWeight.w400,
      );

  /// Subhead — 15/20
  static TextStyle get subhead => _base.copyWith(
        fontSize: 15,
        height: 20 / 15,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
      );

  /// Footnote — 13/18
  static TextStyle get footnote => _base.copyWith(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w600,
      );
}

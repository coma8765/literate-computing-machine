// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';

class _LabelColors {
  const _LabelColors();

  CupertinoDynamicColor get primary =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xff000000),
        darkColor: Color(0xffffffff),
      );

  CupertinoDynamicColor get secondary =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0x99000000),
        darkColor: Color(0x99ffffff),
      );

  CupertinoDynamicColor get tertiary =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0x4c000000),
        darkColor: Color(0x66ffffff),
      );

  CupertinoDynamicColor get disable =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0x26000000),
        darkColor: Color(0x26ffffff),
      );
}

class _SupportColors {
  const _SupportColors();

  CupertinoDynamicColor get separator =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0x33000000),
        darkColor: Color(0x33ffffff),
      );

  CupertinoDynamicColor get overlay =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0x0f000000),
        darkColor: Color(0x51000000),
      );

  CupertinoDynamicColor get navbar =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xccfbfbfb),
        darkColor: Color(0xe51a1a1a),
      );
}

class _BackColors {
  const _BackColors();

  CupertinoDynamicColor get iOSPrimary =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xfff2f2f7),
        darkColor: Color(0xff000000),
      );

  CupertinoDynamicColor get primary =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xfff7f7f2),
        darkColor: Color(0xff161616),
      );

  CupertinoDynamicColor get secondary =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xffffffff),
        darkColor: Color(0xff252528),
      );

  CupertinoDynamicColor get elevated =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xffffffff),
        darkColor: Color(0xff3a3a3f),
      );
}

/// Application colors
abstract final class AppColors {
  static const red = CupertinoDynamicColor.withBrightness(
    color: Color(0xffff3a30),
    darkColor: Color(0xffff443a),
  );
  static const green = CupertinoDynamicColor.withBrightness(
    color: Color(0xff33c659),
    darkColor: Color(0xff33d649),
  );
  static const blue = CupertinoDynamicColor.withBrightness(
    color: Color(0xff007aff),
    darkColor: Color(0xff0a84ff),
  );
  static const grey = CupertinoDynamicColor.withBrightness(
    color: Color(0xff8e8e93),
    darkColor: Color(0xff8e8e93),
  );
  static const greyLight = CupertinoDynamicColor.withBrightness(
    color: Color(0xffd1d1d6),
    darkColor: Color(0xff474749),
  );
  static const white = CupertinoDynamicColor.withBrightness(
    color: Color(0xffffffff),
    darkColor: Color(0xffffffff),
  );

  static const support = _SupportColors();
  static const label = _LabelColors();
  static const back = _BackColors();
}

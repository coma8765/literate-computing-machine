// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

class ColorPalette extends StatelessWidget {
  const ColorPalette({
    required this.colors,
    required this.labels,
    super.key,
  });

  factory ColorPalette.demo() {
    return ColorPalette(
      colors: [
        AppColors.support.separator,
        AppColors.support.overlay,
        AppColors.support.navbar,
        AppColors.label.primary,
        AppColors.label.secondary,
        AppColors.label.tertiary,
        AppColors.label.disable,
        AppColors.back.iOSPrimary,
        AppColors.back.primary,
        AppColors.back.secondary,
        AppColors.back.elevated,
        AppColors.red,
        AppColors.green,
        AppColors.blue,
        AppColors.grey,
        AppColors.greyLight,
        AppColors.white,
      ],
      labels: const [
        'AppColors.support.separator',
        'AppColors.support.overlay',
        'AppColors.support.navbar',
        'AppColors.label.primary',
        'AppColors.label.secondary',
        'AppColors.label.tertiary',
        'AppColors.label.disable',
        'AppColors.back.iOSPrimary',
        'AppColors.back.primary',
        'AppColors.back.secondary',
        'AppColors.back.elevated',
        'AppColors.red',
        'AppColors.green',
        'AppColors.blue',
        'AppColors.grey',
        'AppColors.greyLight',
        'AppColors.white',
      ],
    );
  }

  final List<CupertinoDynamicColor> colors;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery
        .of(context)
        .platformBrightness;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xffe2e2e2),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Current palette $platformBrightness'),
      ),
      child: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildColorTile(colors[index], labels[index]);
        },
      ),
    );
  }

  Widget _buildColorTile(CupertinoDynamicColor color, String label) {
    return Builder(
      builder: (context) {
        final backgroundColor = CupertinoDynamicColor.resolve(color, context);

        return Container(
          height: 50,
          color: backgroundColor,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: backgroundColor.computeLuminance() > 0.7
                    ? CupertinoColors.black
                    : CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

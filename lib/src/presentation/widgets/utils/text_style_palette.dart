// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

class TextStylePalette extends StatelessWidget {
  const TextStylePalette({
    required this.styles,
    required this.labels,
    super.key,
  });

  /// Demonstration of all text styles
  factory TextStylePalette.demo() {
    return TextStylePalette(
      styles: [
        AppTextStyles.largeTitle,
        AppTextStyles.largeTitleBold,
        AppTextStyles.title,
        AppTextStyles.headline,
        AppTextStyles.body,
        AppTextStyles.subhead,
        AppTextStyles.footnote,
      ],
      labels: const [
        'AppTextStyles.largeTitle',
        'AppTextStyles.largeTitleBold',
        'AppTextStyles.title',
        'AppTextStyles.headline',
        'AppTextStyles.body',
        'AppTextStyles.subhead',
        'AppTextStyles.footnote',
      ],
    );
  }

  final List<TextStyle> styles;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Text styles'),
      ),
      child: ListView.builder(
        itemCount: styles.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTextStyleTile(styles[index], labels[index]);
        },
      ),
    );
  }

  Widget _buildTextStyleTile(TextStyle style, String label) {
    return CupertinoListTile(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      title: Text('Lorem Ipsum', style: style),
      subtitle: Text(label),
    );
  }
}

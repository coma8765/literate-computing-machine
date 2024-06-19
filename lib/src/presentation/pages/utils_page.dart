import 'package:flutter/cupertino.dart';
import 'package:todo/src/presentation/widgets/utils/color_palette.dart';
import 'package:todo/src/presentation/widgets/utils/components_palette.dart';
import 'package:todo/src/presentation/widgets/utils/text_style_palette.dart';
import 'package:todo/src/presentation/widgets/widgets.dart';

/// A page with widgets, text styles, colors, themes
class UtilsPage extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const UtilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = _fields()
        .entries
        .map(
          (entry) => _buildActionTile(
            label: entry.key,
            callback: entry.value,
            context: context,
          ),
        )
        .toList();

    return AppSliverScaffold(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(fields),
        ),
      ],
      largeTitle: const Text('Утилиты'),
    );
  }

  Widget _buildActionTile({
    required String label,
    required void Function(BuildContext) callback,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: CustomButton.filled(
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
        onPressed: () => callback(context),
      ),
    );
  }

  void _showAppColors(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (builder) => ColorPalette.demo(),
    );
  }

  void _showTextStyles(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (builder) => TextStylePalette.demo(),
    );
  }

  void _showComponents(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (builder) => ComponentsPalette.demo(),
    );
  }

  Map<String, void Function(BuildContext)> _fields() {
    return {
      'AppColors': _showAppColors,
      'TextStyles': _showTextStyles,
      'ComponentsPalette': _showComponents,
    };
  }
}

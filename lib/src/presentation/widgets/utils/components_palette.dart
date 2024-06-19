// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/presentation/widgets/buttons/button.dart';

class ComponentsPalette extends StatefulWidget {
  const ComponentsPalette({
    required this.widgets,
    required this.labels,
    super.key,
  });

  factory ComponentsPalette.demo() {
    return ComponentsPalette(
      widgets: [
        CustomButton(child: const Text('Lorem Ipsum'), onPressed: () {}),
        CustomButton.filled(child: const Text('Lorem Ipsum'), onPressed: () {}),
        const CustomButton(onPressed: null, child: Text('Lorem Ipsum')),
        const CustomButton.filled(onPressed: null, child: Text('Lorem Ipsum')),
        CustomButton(
          onPressed: () {},
          color: AppColors.blue,
          child: const Text('Lorem Ipsum'),
        ),
        CustomButton.filled(
          onPressed: () {},
          color: AppColors.blue,
          child: const Text('Lorem Ipsum'),
        ),
        CustomButton.filled(
          onPressed: () {},
          color: AppColors.red,
          child: const Text('Lorem Ipsum'),
        ),
      ],
      labels: const [
        'Base button',
        'Filled button',
        'Disabled base button',
        'Disabled filled button',
        'Button with blue color',
        'Filled button with blue color',
        'Filled button with red color',
      ],
    );
  }

  final List<Widget> widgets;
  final List<String> labels;

  @override
  State<ComponentsPalette> createState() => _ComponentsPaletteState();
}

class _ComponentsPaletteState extends State<ComponentsPalette> {
  bool _displayRedBackground = true;

  @override
  void initState() {
    super.initState();

    _displayRedBackground = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Components',
          style: theme.textTheme.navLargeTitleTextStyle,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoButton(
              child: const Text('Toggle _displayRedBackground'),
              onPressed: () => setState(() {
                _displayRedBackground = !_displayRedBackground;
              }),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.widgets.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_displayRedBackground) {
                    return _buildWidgetTileWithRedBackground(
                      widget.widgets[index],
                      widget.labels[index],
                    );
                  }

                  return _buildWidgetTile(
                    widget.widgets[index],
                    widget.labels[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetTileWithRedBackground(Widget widget, String label) {
    return Column(
      children: [
        Text(label),
        Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          color: CupertinoColors.destructiveRed,
          child: widget,
        ),
      ],
    );
  }

  Widget _buildWidgetTile(Widget widget, String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4.0),
            ),
          ),
        ),
        SizedBox(width: double.infinity, child: widget),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4.0),
            ),
          ),
        ),
      ],
    );
  }
}

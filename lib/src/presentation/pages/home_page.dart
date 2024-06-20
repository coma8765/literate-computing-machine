import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/presentation/widgets/list_tiles/slaidable_list_tile.dart';
import 'package:todo/src/presentation/widgets/widgets.dart';

const _kPageTitle = 'Мои дела';
const _kPagePadding = EdgeInsets.symmetric(horizontal: 16.0);

// ignore: use_late_for_private_fields_and_variables,unnecessary_nullable_for_final_variable_declarations
const int? _kPerfectDesignIndex = null;

const _kTODOHeaderPadding = EdgeInsets.symmetric(
  vertical: 7,
  horizontal: 16,
);
const _kTODOHeaderHeight = 20.0;
const _kTODOSpace = 5.0;

const _kTODOBorderRadius = Radius.circular(16.0);
const _kTODODividerMargin = 52.0;
const _kTODOBottomPadding = 78.0;

/// An Home Page of Application
class HomePage extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    const largeTitle = Text(_kPageTitle);
    final slivers = [
      SliverPadding(
        padding: _kPagePadding,
        sliver: SliverList.builder(
          itemCount: 1,
          itemBuilder: (context, _) => _buildTODOSection(context),
        ),
      ),
    ];

    if (_kPerfectDesignIndex != null && kDebugMode) {
      final assetPath = [
        'assets/design/home-screen-',
        _kPerfectDesignIndex,
        '-',
        brightness.name,
        '.jpg',
      ].join();

      return PerfectAppSliverScaffold(
        assetPath: assetPath,
        slivers: slivers,
        largeTitle: largeTitle,
      );
    }

    return AppSliverScaffold(slivers: slivers, largeTitle: largeTitle);
  }

  Widget _buildTODOHeader(BuildContext context) {
    const completeText = 'Выполнено — 5';

    final completeColor = AppColors.label.tertiary.resolveFrom(context);
    final showCompleteColor = AppColors.blue.resolveFrom(context);

    final completeStyle = AppTextStyles.subhead.copyWith(
      color: completeColor,
    );

    final showCompleteStyle = AppTextStyles.subhead.copyWith(
      color: showCompleteColor,
      fontWeight: FontWeight.w600,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          completeText,
          style: completeStyle,
        ),
        Text(
          'Показать',
          style: showCompleteStyle,
        ),
      ],
    );
  }

  Widget _buildTODOListTile(
    BuildContext context, {
    required String title,
    Widget? subtitle,
  }) {
    return CustomSlaidableListTile(
      title: Text(title),
      subtitle: subtitle,
      leading: const RoundedCheckbox(),
      trailing: const CustomChevron(),
    );
  }

  Widget _buildTODOCreate(BuildContext context) {
    final color = AppColors.label.tertiary.resolveFrom(context);
    final textStyle = TextStyle(color: color);

    return CustomListTile(
      title: Text('Новое', style: textStyle),
    );
  }

  List<Widget> _buildRows(BuildContext context) {
    final subtitleColor = AppColors.label.tertiary.resolveFrom(context);
    final subtitleStyle = AppTextStyles.subhead.copyWith(
      color: subtitleColor,
    );

    return <Widget>[
      _buildTODOListTile(context, title: 'Купить сыр'),
      _buildTODOListTile(
        context,
        title: 'Задание',
        subtitle: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  CupertinoIcons.calendar,
                  size: subtitleStyle.fontSize,
                  color: subtitleColor,
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: '14 июня',
                style: subtitleStyle,
              ),
            ],
          ),
        ),
      ),
      _buildTODOListTile(context, title: 'Сделать пиццу'),
    ];
  }

  Widget _buildTODOSection(BuildContext context) {
    final backgroundColor = AppColors.back.secondary.resolveFrom(context);
    final separatorColor = AppColors.support.separator.resolveFrom(context);

    final bottomPadding =
        MediaQuery.of(context).padding.bottom + _kTODOBottomPadding;

    final rows = [
      ..._buildRows(context),
      ..._buildRows(context),
      ..._buildRows(context),
      ..._buildRows(context),
      ..._buildRows(context),
      _buildTODOCreate(context),
    ];

    return Column(
      children: [
        Padding(
          padding: _kTODOHeaderPadding,
          child: SizedBox(
            height: _kTODOHeaderHeight,
            child: Builder(builder: _buildTODOHeader),
          ),
        ),
        const SizedBox(height: _kTODOSpace),
        ClipRRect(
          borderRadius: const BorderRadius.all(_kTODOBorderRadius),
          child: SlidableAutoCloseBehavior(
            child: CupertinoListSection.insetGrouped(
              separatorColor: separatorColor,
              margin: EdgeInsets.zero,
              dividerMargin: 0,
              additionalDividerMargin: _kTODODividerMargin,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              children: rows,
            ),
          ),
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}

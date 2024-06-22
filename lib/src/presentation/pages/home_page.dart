import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todo/src/domain/entities/fake/todo_fake.dart';
import 'package:todo/src/presentation/pages/todo_page/todo_page.dart';
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

final _todos = TODOFactory().generateFakeList(length: 10);

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
        sliver: SliverList.list(
          children: const [_ListSection()],
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
}

class _ListCreateTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = AppColors.label.tertiary.resolveFrom(context);
    final textStyle = TextStyle(color: color);

    return CustomListTile(
      title: Text('Новое', style: textStyle),
      onTap: () {
        final todo = TODO.create();
        showTODOPage(context, todo);
      },
    );
  }
}

class _ListSectionHeader extends StatelessWidget {
  const _ListSectionHeader();

  @override
  Widget build(BuildContext context) {
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
}

class _ListSection extends StatefulWidget {
  const _ListSection();

  @override
  State<_ListSection> createState() => _ListSectionState();
}

class _ListSectionState extends State<_ListSection> {
  late Set<String> removedItemsUid;

  @override
  void initState() {
    super.initState();

    removedItemsUid = {};
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.back.secondary.resolveFrom(context);
    final separatorColor = AppColors.support.separator.resolveFrom(context);

    final bottomPadding =
        MediaQuery.of(context).padding.bottom + _kTODOBottomPadding;

    final rows = [
      ..._todos.where((todo) => !removedItemsUid.contains(todo.uid)).map(
            (todo) => _ListTile(
              key: ValueKey(todo.uid),
              todo: todo,
              onRemove: () {
                setState(() {
                  removedItemsUid.add(todo.uid);
                });
              },
            ),
          ),
      _ListCreateTile(),
    ];

    return Column(
      children: [
        const Padding(
          padding: _kTODOHeaderPadding,
          child: SizedBox(
            height: _kTODOHeaderHeight,
            child: _ListSectionHeader(),
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

class _ListTileSubtitle extends StatelessWidget {
  const _ListTileSubtitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final subtitleColor = AppColors.label.tertiary.resolveFrom(context);
    final subtitleStyle = AppTextStyles.subhead.copyWith(
      color: subtitleColor,
    );

    return RichText(
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
            text: text,
            style: subtitleStyle,
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.todo,
    this.onRemove,
    super.key,
  });

  final TODO todo;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    Widget? subtitle;

    if (todo.deadline != null) {
      final deadlineText = DateFormat('d MMMM', 'ru').format(todo.deadline!);
      subtitle = _ListTileSubtitle(text: deadlineText);
    }

    return CustomSlaidableListTile(
      key: ValueKey(todo.uid),
      onTap: () => showTODOPage(context, todo),
      title: Text(todo.title),
      subtitle: subtitle,
      leading: const RoundedCheckbox(),
      trailing: const CustomChevron(),
      onRemove: onRemove,
    );
  }
}

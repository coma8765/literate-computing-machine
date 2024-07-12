import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show DismissiblePane, SlidableAutoCloseBehavior;
import 'package:logging/logging.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todo/src/presentation/bloc/bloc.dart';
import 'package:todo/src/presentation/pages/edit_todo_page/edit_todo_page.dart';
import 'package:todo/src/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

const _kPagePadding = EdgeInsets.symmetric(horizontal: 16.0);

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
class HomeView extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final largeTitle = Text(context.l10n.homePageTitle);

    final slivers = [
      SliverPadding(
        padding: _kPagePadding,
        sliver: SliverList.list(
          children: const [_ListSection()],
        ),
      ),
    ];

    return AppSliverScaffold(slivers: slivers, largeTitle: largeTitle);
  }
}

class _ListCreateTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = AppColors.label.tertiary.resolveFrom(context);
    final textStyle = TextStyle(color: color);

    return CustomListTile(
      title: Text(context.l10n.createTodo, style: textStyle),
      onTap: () => showTODOPage(context, const Uuid().v4()),
    );
  }
}

class _ListSectionHeader extends StatelessWidget {
  const _ListSectionHeader();

  @override
  Widget build(BuildContext context) {
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
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (a, b) => a.countCompletedTodos != b.countCompletedTodos,
          builder: (context, state) {
            return Text(
              context.l10n.completeCountText(state.countCompletedTodos),
              style: completeStyle,
            );
          },
        ),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (a, b) => a.showAll != b.showAll,
          builder: (context, state) {
            return GestureDetector(
              onTap: () => context
                  .read<HomeBloc>()
                  .add(HomeShowAllToggled(showAll: !state.showAll)),
              child: Text(
                !state.showAll
                    ? context.l10n.showAllTask
                    : context.l10n.hideAllTask,
                style: showCompleteStyle,
              ),
            );
          },
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
  late Logger logger;

  @override
  void initState() {
    super.initState();

    logger = Logger('HomeViewLogger');
    removedItemsUid = {};
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.back.secondary.resolveFrom(context);
    final separatorColor = AppColors.support.separator.resolveFrom(context);

    final bottomPadding =
        MediaQuery.of(context).padding.bottom + _kTODOBottomPadding;

    // final rows = ;

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
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return CupertinoListSection.insetGrouped(
                  separatorColor: separatorColor,
                  margin: EdgeInsets.zero,
                  dividerMargin: 0,
                  additionalDividerMargin: _kTODODividerMargin,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  children: [
                    ...state.filteredTodos.map(
                      (todo) => _ListTile(
                        key: ValueKey(todo),
                        todo: todo,
                        onRemove: () {
                          context
                              .read<HomeBloc>()
                              .add(HomeTodoDeleted(todo: todo));
                        },
                      ),
                    ),
                    _ListCreateTile(),
                  ],
                );
              },
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

  final Todo todo;
  final void Function()? onRemove;

  void _openEdit(BuildContext context) {
    showTODOPage(context, todo.id);
  }

  @override
  Widget build(BuildContext context) {
    Widget? subtitle;

    if (todo.deadline != null) {
      final deadlineText = DateTheme.toMonthDayString(todo.deadline!);
      subtitle = _ListTileSubtitle(text: deadlineText);
    }

    return CustomSlidableListTile(
      key: ValueKey(todo.id),
      onTap: () => _openEdit(context),
      title: Text(
        todo.text,
        style: TextStyle(
          decoration: todo.done ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: subtitle,
      leading: RoundedCheckbox(
        value: todo.done,
        borderColor: todo.importance == Importance.high ? AppColors.red : null,
        inactiveColor: todo.importance == Importance.high
            ? AppColors.red.withAlpha(25)
            : null,
        onChange: (value) {
          if (value == null) return;

          context.read<HomeBloc>().add(
                HomeTodoDoneToggled(
                  todo: todo,
                  isDone: value,
                ),
              );
        },
      ),
      trailing: const CustomChevron(),
      onRemove: onRemove,
      startActionPane: CustomActionPane(
        children: [
          CustomIconSlidableAction(
            icon: CupertinoIcons.check_mark_circled_solid,
            backgroundColor: AppColors.green,
            onPressed: (_) {
              context.read<HomeBloc>().add(
                    HomeTodoDoneToggled(
                      todo: todo,
                      isDone: !todo.done,
                    ),
                  );
            },
          ),
        ],
      ),
      endActionPane: CustomActionPane(
        dismissible: DismissiblePane(onDismissed: onRemove ?? () {}),
        children: [
          CustomIconSlidableAction(
            icon: CupertinoIcons.info_circle_fill,
            backgroundColor: AppColors.greyLight,
            onPressed: _openEdit,
          ),
          CustomIconSlidableAction(
            icon: CupertinoIcons.trash_fill,
            backgroundColor: AppColors.red,
            onPressed: (context) => onRemove?.call(),
          ),
        ],
      ),
    );
  }
}

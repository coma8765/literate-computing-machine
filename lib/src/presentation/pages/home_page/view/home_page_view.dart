import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show DismissiblePane, SlidableAutoCloseBehavior;
import 'package:logging/logging.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/domain/entities/fake/todo_fake.dart';
import 'package:todo/src/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:todo/src/presentation/pages/todo_page/todo_page.dart';
import 'package:todo/src/presentation/widgets/widgets.dart';
import 'package:todos_api/src/models/todo.dart' show Todo;

const _kPageTitle = 'Мои дела';
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

final _todos = TODOFactory().generateFakeList(length: 10);

/// An Home Page of Application
class HomeView extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().stream.listen(print);

    const largeTitle = Text(_kPageTitle);
    final slivers = [
      SliverPadding(
        padding: _kPagePadding,
        sliver: SliverList.list(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return _ListSection(todos: state.todos);
              },
            ),
          ],
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
    final bloc = context.read<HomeBloc>();

    return CustomListTile(
      title: Text('Новое', style: textStyle),
      onTap: () async {
        final todo = await showTODOPage(context, Todo(text: ''));

        if (todo != null) {
          bloc.add(HomeTodoSave(todo: todo));
        }
      },
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

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.showAll != current.showAll ||
          previous.todos.length != current.todos.length,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Выполнено — ${state.todos.length}',
              style: completeStyle,
            ),
            GestureDetector(
              onTap: () => context
                  .read<HomeBloc>()
                  .add(HomeShowAllToggled(showAll: !state.showAll)),
              child: Text(
                !state.showAll ? 'Показать' : 'Скрыть',
                style: showCompleteStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ListSection extends StatefulWidget {
  const _ListSection({required this.todos});

  final List<Todo> todos;

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
                print('object-objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject;');
                print(state.todos);
                return CupertinoListSection.insetGrouped(
                  separatorColor: separatorColor,
                  margin: EdgeInsets.zero,
                  dividerMargin: 0,
                  additionalDividerMargin: _kTODODividerMargin,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  children: [
                    ...state.todos.map(
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
    final bloc = context.read<HomeBloc>();

    showTODOPage(context, todo).then(
      (todo) {
        if (todo != null) {
          bloc.add(HomeTodoSave(todo: todo));
        }
      },
    );
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
      title: Text(todo.text),
      subtitle: subtitle,
      leading: const RoundedCheckbox(),
      trailing: const CustomChevron(),
      onRemove: onRemove,
      startActionPane: CustomActionPane(
        children: const [
          CustomIconSlidableAction(
            icon: CupertinoIcons.check_mark_circled_solid,
            backgroundColor: AppColors.green,
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

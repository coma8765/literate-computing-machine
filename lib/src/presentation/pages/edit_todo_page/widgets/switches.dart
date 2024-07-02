import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todo/src/presentation/bloc/bloc.dart';
import 'package:todo/src/presentation/widgets/date_picker/date_picker.dart';
import 'package:todo/src/presentation/widgets/multi_toggle_switch/multi_toggle_switch.dart';
import 'package:todo/src/presentation/widgets/toggle_switch/toggle_switch.dart';

const _switchTileTitlePadding = EdgeInsets.symmetric(
  horizontal: 16.0,
);

const _switchTileTrailingPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 12.0,
);

abstract class _SwitchTile extends StatelessWidget {
  const _SwitchTile();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.back.secondary.resolveFrom(context);

    return CupertinoListTile(
      backgroundColor: backgroundColor,
      title: Padding(
        padding: _switchTileTitlePadding,
        child: SizedBox(
          // height: _switchTileTitleHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Builder(builder: buildTitle),
          ),
        ),
      ),
      padding: EdgeInsetsDirectional.zero,
      trailing: Padding(
        padding: _switchTileTrailingPadding,
        child: Builder(builder: buildSwitch),
      ),
    );
  }

  Widget buildTitle(BuildContext context);

  Widget buildSwitch(BuildContext context);
}

class _ImportantSwitchTile extends _SwitchTile {
  const _ImportantSwitchTile();

  @override
  Widget buildSwitch(BuildContext context) {
    return BlocBuilder<EditTodoCubit, EditTodoState>(
      buildWhen: (prev, curr) => prev.importance != curr.importance,
      builder: (context, state) {
        final index = Importance.values.indexOf(state.importance);

        return MultiToggleSwitch(
          itemHeight: 31.5,
          itemWeight: 48.0,
          itemCount: 3,
          defaultItem: index,
          onChange: (index) {
            context
                .read<EditTodoCubit>()
                .setImportance(Importance.values[index]);
          },
          itemBuilder: ({
            required BuildContext context,
            required int index,
            required bool isActive,
          }) {
            switch (index) {
              case 0:
                return SvgPicture.asset(
                  'assets/svg/priority-low.svg',
                  height: 20.0,
                  width: 16.0,
                  fit: BoxFit.none,
                );
              case 1:
                final textStyle = AppTextStyles.subhead.copyWith(
                  fontWeight: FontWeight.w500,
                  color: CupertinoTheme.of(context).primaryColor,
                );

                return Text(
                  'нет',
                  style: textStyle,
                  strutStyle: StrutStyle(
                    fontSize: textStyle.fontSize,
                    height: 1.0,
                    forceStrutHeight: true,
                  ),
                );

              case 2:
                return SvgPicture.asset(
                  'assets/svg/priority-high.svg',
                  height: 20.0,
                  width: 16.0,
                  fit: BoxFit.none,
                );
            }

            return const Placeholder(child: Text('???'));
          },
        );
      },
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    return const Text('Важность');
  }
}

class _CalendarCubit extends Cubit<DateTime?> {
  _CalendarCubit() : super(null);

  void set(DateTime? value) => emit(value);
}

class _CalendarSwitchTile extends _SwitchTile {
  const _CalendarSwitchTile();

  @override
  Widget buildSwitch(BuildContext context) {
    final calendarCubit = context.read<_CalendarCubit>();

    return ToggleSwitch(
      defaultValue: false,
      confirm: (hasDeadline) async {
        if (hasDeadline) {
          final dateTime = await datePick(context);

          calendarCubit.set(dateTime);
          if (dateTime == null) {
            return false;
          }
        } else {
          calendarCubit.set(null);
        }
        return true;
      },
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    return BlocBuilder<_CalendarCubit, DateTime?>(
      builder: (context, date) {
        String? deadlineText;
        if (date != null) {
          deadlineText = DateTheme.toFullDateString(date);
        }

        final deadlineColor = AppColors.blue.resolveFrom(context);
        final deadlineTextStyle = AppTextStyles.footnote.copyWith(
          color: deadlineColor,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Сделать до'),
            if (date != null)
              Text(
                deadlineText!,
                style: deadlineTextStyle,
              ),
          ],
        );
      },
    );
  }
}

class Switches extends StatelessWidget {
  const Switches({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const children = [
      _ImportantSwitchTile(),
      _CalendarSwitchTile(),
    ];

    final separatorColor = AppColors.support.separator.resolveFrom(context);
    final todoCubit = context.read<EditTodoCubit>();

    return BlocProvider(
      create: (_) => _CalendarCubit()
        ..stream.forEach(
          (deadline) => deadline != null
              ? todoCubit.setDeadline(deadline)
              : todoCubit.emptyDeadline(),
        ),
      child: CupertinoListSection.insetGrouped(
        margin: EdgeInsetsDirectional.zero,
        backgroundColor: WidgetStateColor.transparent,
        separatorColor: separatorColor,
        dividerMargin: 0.0,
        additionalDividerMargin: 0.0,
        children: children,
      ),
    );
  }
}

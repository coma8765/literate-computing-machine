import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todo/src/presentation/bloc/bloc.dart';
import 'package:todo/src/presentation/pages/edit_todo_page/widgets/widgets.dart';
import 'package:todo/src/presentation/widgets/buttons/buttons.dart';

const _pageBorderRadius = BorderRadius.vertical(top: Radius.circular(12.0));
const _kNavBarPadding = EdgeInsetsDirectional.symmetric(horizontal: 16.0);
const _editItemPadding = EdgeInsets.symmetric(vertical: 8.0);
const _pageContentPadding = EdgeInsets.symmetric(
  horizontal: 16.0,
  vertical: 8.0,
);

/// A TODO information page
class TODOView extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const TODOView({super.key});

  Future<void> saveTodo(BuildContext context, Todo todo) async {
    await context.read<EditTodoCubit>().saveAction();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.back.primary.resolveFrom(context);
    final shadowColor = CupertinoTheme.of(context).scaffoldBackgroundColor;

    final pageShadow = [
      BoxShadow(
        color: shadowColor,
        spreadRadius: 5,
        blurRadius: 7,
      ),
    ];

    final editTodoCubit = context.read<EditTodoCubit>();

    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _pageBorderRadius,
          color: backgroundColor,
          boxShadow: pageShadow,
        ),
        child: ClipRRect(
          borderRadius: _pageBorderRadius,
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              padding: _kNavBarPadding,
              middle: Text(context.l10n.editPageTitle),
              leading: const NavigationCancelButton(),
              trailing: BlocBuilder<EditTodoCubit, EditTodoState>(
                builder: (context, state) {
                  assert(
                    state is EditTodoEditableState,
                    'unable build without editable state',
                  );

                  final todo = (state as EditTodoEditableState).todo;

                  return SaveButton(
                    onPressed: todo != state.initialTodo
                        ? () => saveTodo(context, todo)
                        : null,
                    padding: EdgeInsetsDirectional.zero,
                  );
                },
              ),
              // padding: EdgeInsetsDirectional.zero,
              backgroundColor: backgroundColor,
            ),
            backgroundColor: backgroundColor,
            child: Padding(
              padding: _pageContentPadding,
              child: _TODOEdit(editTodoCubit: editTodoCubit),
            ),
          ),
        ),
      ),
    );
  }
}

class _TODOEdit extends StatelessWidget {
  const _TODOEdit({required this.editTodoCubit});

  final EditTodoCubit editTodoCubit;

  Future<void> deleteTodo(BuildContext context) async {
    Navigator.of(context).pop();

    await editTodoCubit.deleteAction();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundBackground = AppColors.back.secondary.resolveFrom(context);

    final state = editTodoCubit.state as EditTodoEditableState;

    final fields = [
      CustomTextField(
        backgroundBackground: backgroundBackground,
        initialValue: state.initialTodo.text,
        onChanged: editTodoCubit.setText,
      ),
      const Switches(),
      CustomButton.filled(
        onPressed: () => deleteTodo(context),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Text(context.l10n.removeText),
      ),
    ];

    return ListView(
      children: fields.map((child) {
        return Padding(
          padding: _editItemPadding,
          child: child,
        );
      }).toList(),
    );
  }
}

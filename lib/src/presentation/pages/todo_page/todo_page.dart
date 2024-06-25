import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';
import 'package:todo/src/domain/domain.dart';
import 'package:todo/src/presentation/pages/todo_page/description_field.dart';
import 'package:todo/src/presentation/pages/todo_page/switches.dart';
import 'package:todo/src/presentation/widgets/buttons/buttons.dart';

const _pageBorderRadius = BorderRadius.vertical(top: Radius.circular(12.0));
const _kNavBarPadding = EdgeInsetsDirectional.symmetric(horizontal: 16.0);
const _editItemPadding = EdgeInsets.symmetric(vertical: 8.0);
const _pageContentPadding = EdgeInsets.symmetric(
  horizontal: 16.0,
  vertical: 8.0,
);

/// Show a pop-up window for some TODO
void showTODOPage(
  BuildContext context,
  TODO todo,
) {
  showCupertinoModalPopup<TODOPage>(
    context: context,
    builder: (BuildContext context) {
      return TODOPage(
        todo: todo,
        key: ValueKey(todo.uid),
      );
    },
  );
}

/// A TODO information page
class TODOPage extends StatelessWidget {
  /// This class creates an instance of [StatelessWidget].
  const TODOPage({
    required this.todo,
    super.key,
  });

  /// TODO_'s entity
  final TODO todo;

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
              middle: const Text('Дело'),
              leading: const NavigationCancelButton(),
              trailing: SaveButton(
                onPressed: null,
                padding: EdgeInsetsDirectional.zero,
              ),
              // padding: EdgeInsetsDirectional.zero,
              backgroundColor: backgroundColor,
            ),
            backgroundColor: backgroundColor,
            child: Padding(
              padding: _pageContentPadding,
              child: _TODOEdit(todo: todo),
            ),
          ),
        ),
      ),
    );
  }
}

class _TODOEdit extends StatefulWidget {
  const _TODOEdit({
    required this.todo,
  });

  final TODO todo;

  @override
  State<_TODOEdit> createState() => _TODOEditState();
}

class _TODOEditState extends State<_TODOEdit> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundBackground = AppColors.back.secondary.resolveFrom(context);

    final fields = [
      CustomTextField(backgroundBackground: backgroundBackground),
      const Switches(),
      const CustomButton.filled(
        onPressed: null,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: Text('Удалить'),
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

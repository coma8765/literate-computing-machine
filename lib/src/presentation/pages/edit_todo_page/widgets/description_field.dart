import 'package:flutter/cupertino.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/src/core/theme/theme.dart';

const _maxLines = 20;
const _minHeight = 120.0;
const _textPadding = EdgeInsets.all(16.0);

/// A Text Field
class CustomTextField extends StatefulWidget {
  /// This class creates an instance of [StatelessWidget].
  const CustomTextField({
    required Color backgroundBackground,
    this.initialValue,
    this.onChanged,
    super.key,
  }) : _backgroundBackground = backgroundBackground;

  final String? initialValue;
  final Color _backgroundBackground;
  final void Function(String value)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    final cursorColor = AppColors.blue.resolveFrom(context);
    final backgroundBackground = CupertinoDynamicColor.resolve(
      widget._backgroundBackground,
      context,
    );

    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: Container(
        constraints: const BoxConstraints(minHeight: _minHeight),
        decoration: BoxDecoration(
          color: backgroundBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: _textPadding,
          child: CupertinoTextFormFieldRow(
            focusNode: _focusNode,
            initialValue: widget.initialValue,
            decoration: const BoxDecoration(
              color: WidgetStateColor.transparent,
            ),
            padding: EdgeInsetsDirectional.zero,
            maxLines: _maxLines,
            cursorColor: cursorColor,
            minLines: 1,
            placeholder: context.l10n.editTodoTextFieldPlaceholder,
            textAlignVertical: TextAlignVertical.top,
            onChanged: widget.onChanged,
            // onSaved: (text) => onChanged?.call(text ?? ''),
            // onEditingComplete: onChanged,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}

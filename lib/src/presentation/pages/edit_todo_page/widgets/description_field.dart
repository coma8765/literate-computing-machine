import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/theme/theme.dart';

const _placeholderText = 'Что надо сделать?';
const _maxLines = 20;
const _minHeight = 120.0;
const _textPadding = EdgeInsets.all(16.0);

/// A Text Field
class CustomTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final cursorColor = AppColors.blue.resolveFrom(context);
    final backgroundBackground = CupertinoDynamicColor.resolve(
      _backgroundBackground,
      context,
    );

    return Container(
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
          initialValue: initialValue,
          decoration: const BoxDecoration(
            color: WidgetStateColor.transparent,
          ),
          padding: EdgeInsetsDirectional.zero,
          maxLines: _maxLines,
          cursorColor: cursorColor,
          minLines: 1,
          placeholder: _placeholderText,
          textAlignVertical: TextAlignVertical.top,
          onChanged: onChanged,
          // onSaved: (text) => onChanged?.call(text ?? ''),
          // onEditingComplete: onChanged,
        ),
      ),
    );
  }
}

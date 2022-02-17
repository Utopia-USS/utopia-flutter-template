import 'package:DART_PACKAGE_NAME/common/widgets/field/text/app_text_field_theme.dart';
import 'package:DART_PACKAGE_NAME/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppTextFieldRaw extends HookWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final Widget? label, error, hint;
  final Widget? prefix, suffix;

  const AppTextFieldRaw({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.focusNode,
    this.label,
    this.error,
    this.hint,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTextFieldTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null)
          DefaultTextStyle(style: theme.errorStyle, child: error!)
        else if (label != null)
          DefaultTextStyle(style: theme.labelStyle, child: label!),
        _buildField(theme),
      ].separatedWith(const SizedBox(height: 8)),
    );
  }

  Widget _buildField(AppTextFieldThemeData theme) {
    useListenable(controller);
    return DecoratedBox(
      decoration: theme.decoration,
      child: Row(
        children: [
          if (prefix != null) Center(child: prefix!),
          Expanded(
            child: Padding(
              padding: theme.textPadding,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  if (hint != null) _buildHint(theme),
                  _buildTextField(),
                ],
              ),
            ),
          ),
          if (suffix != null) Center(child: suffix!),
        ],
      ),
    );
  }

  Widget _buildHint(AppTextFieldThemeData theme) {
    return AnimatedOpacity(
      opacity: controller.text.isEmpty ? 1 : 0,
      duration: const Duration(milliseconds: 150),
      child: DefaultTextStyle(style: theme.hintStyle, child: hint!),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: null,
    );
  }
}

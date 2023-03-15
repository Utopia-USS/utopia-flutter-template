import 'package:DART_PACKAGE_NAME/common/widget/field/text/app_text_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class AppTextFieldRaw extends HookWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final Widget? label, error, hint;
  final Widget? prefix, suffix;
  final AppTextFieldThemeData? theme;

  const AppTextFieldRaw({
    super.key,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.focusNode,
    this.label,
    this.error,
    this.hint,
    this.prefix,
    this.suffix,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? AppTextFieldTheme.of(context);
    final focusNode = this.focusNode ?? useMemoized(FocusNode.new)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null)
          DefaultTextStyle(style: theme.errorStyle, child: error!)
        else if (label != null)
          DefaultTextStyle(style: theme.labelStyle, child: label!),
        _buildField(theme, focusNode),
      ].separatedWith(const SizedBox(height: 8)),
    );
  }

  Widget _buildField(AppTextFieldThemeData theme, FocusNode focusNode) {
    useListenable(controller);
    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      child: DecoratedBox(
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
                    _buildTextField(theme, focusNode),
                  ],
                ),
              ),
            ),
            if (suffix != null) Center(child: suffix!),
          ],
        ),
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

  Widget _buildTextField(AppTextFieldThemeData theme, FocusNode focusNode) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: theme.style,
      decoration: null,
    );
  }
}

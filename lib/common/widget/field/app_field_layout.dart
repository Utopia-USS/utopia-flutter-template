import 'package:DART_PACKAGE_NAME/common/widget/field/app_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class AppFieldLayout extends HookWidget {
  final Widget? label, error, hint;
  final Widget? prefix, suffix;
  final AppFieldThemeData? theme;
  final bool required;
  final bool showHint;
  final void Function()? onTap;
  final Widget? child;

  const AppFieldLayout({
    super.key,
    this.label,
    this.error,
    this.hint,
    this.prefix,
    this.suffix,
    this.theme,
    this.required = false,
    this.onTap,
    this.child,
    required this.showHint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? AppFieldTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildTop(theme), _buildField(theme)].separatedWith(const SizedBox(height: 8)),
    );
  }

  Widget _buildTop(AppFieldThemeData theme) {
    if (label == null && error == null) return const SizedBox.shrink();
    return DefaultTextStyle(
      style: error != null ? theme.errorStyle : theme.labelStyle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          error ?? label!,
          if (required) const Text(' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildField(AppFieldThemeData theme) {
    return GestureDetector(
      onTap: onTap,
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
                    if (child != null) DefaultTextStyle(style: theme.style, child: child!),
                    if (hint != null) _buildHint(theme),
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

  Widget _buildHint(AppFieldThemeData theme) {
    return AnimatedOpacity(
      opacity: showHint ? 1 : 0,
      duration: const Duration(milliseconds: 150),
      child: DefaultTextStyle(style: theme.hintStyle, child: hint!),
    );
  }
}

import 'package:DART_PACKAGE_NAME/common/constant/app_colors.dart';
import 'package:DART_PACKAGE_NAME/common/widget/field/app_field_layout.dart';
import 'package:DART_PACKAGE_NAME/common/widget/field/app_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppTextField extends HookWidget {
  final FieldState state;
  final MutableValue<bool>? obscuredState;
  final TextInputType? keyboardType;
  final Widget? label, hint;
  final Widget? prefix, suffix;
  final AppFieldThemeData? theme;
  final List<TextInputFormatter> formatters;
  final bool required;

  const AppTextField({
    super.key,
    required this.state,
    this.obscuredState,
    this.keyboardType,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.theme,
    this.formatters = const [],
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? AppFieldTheme.of(context);
    final focusNode = useMemoized(FocusNode.new);
    return TextEditingControllerWrapper(
      text: state,
      builder: (controller) => AppFieldLayout(
        theme: theme,
        showHint: state.value.isEmpty,
        required: required,
        onTap: focusNode.requestFocus,
        label: label,
        hint: hint,
        error: state.errorMessage?.let((it) => Text(it(context))),
        prefix: prefix,
        suffix: suffix ?? obscuredState?.value.let(_buildObscuredSuffix),
        child: TextField(
          controller: controller,
          decoration: null,
          keyboardType: keyboardType,
          obscureText: obscuredState?.value ?? false,
          focusNode: focusNode,
          onTapOutside: (_) => focusNode.unfocus(),
          style: theme.style,
          inputFormatters: formatters,
        ),
      ),
    );
  }

  Widget _buildObscuredSuffix(bool isObscured) {
    return IconButton(
      onPressed: () => obscuredState!.toggle(),
      icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off, color: AppColors.primary),
    );
  }
}

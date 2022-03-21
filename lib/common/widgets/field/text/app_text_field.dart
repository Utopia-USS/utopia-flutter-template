import 'package:DART_PACKAGE_NAME/common/constants/app_colors.dart';
import 'package:DART_PACKAGE_NAME/common/widgets/field/text/app_text_field_raw.dart';
import 'package:DART_PACKAGE_NAME/extensions.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class AppTextField extends HookWidget {
  final FieldState state;
  final MutableValue<bool>? obscuredState;
  final TextInputType? keyboardType;
  final Widget? label, hint;
  final Widget? prefix, suffix;

  const AppTextField({
    Key? key,
    required this.state,
    this.obscuredState,
    this.keyboardType,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: state.value,
      onChanged: state.onChanged,
      child: (controller) => AppTextFieldRaw(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscuredState?.value ?? false,
        label: label,
        hint: hint,
        error: state.errorMessage?.let((it) => Text(it(context))),
        prefix: prefix,
        suffix: suffix ?? obscuredState?.value.let(_buildObscuredSuffix),
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

import 'package:DART_PACKAGE_NAME/common/constant/app_colors.dart';
import 'package:DART_PACKAGE_NAME/common/constant/app_text.dart';
import 'package:DART_PACKAGE_NAME/common/widget/loader/app_loader.dart';
import 'package:DART_PACKAGE_NAME/util/widget/cross_fade_overlay.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';

enum AppButtonType { primary, outlined }

class AppButton extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final bool loading, enabled;
  final AppButtonType type;
  final Color? color;
  final Color? titleColor;

  const AppButton({
    super.key,
    required this.onTap,
    required this.child,
    this.loading = false,
    this.enabled = true,
    this.type = AppButtonType.primary,
    this.color,
    this.titleColor,
  });

  AppButton.withState(
    ButtonState state, {
    super.key,
    required this.child,
    this.type = AppButtonType.primary,
    this.color,
    this.titleColor,
  }) : loading = state.loading,
       enabled = state.enabled,
       onTap = state.onTap;

  Color get _primaryColor => !enabled ? AppColors.disabled : color ?? AppColors.primary;

  Color get _fillColor => type == AppButtonType.outlined ? Colors.transparent : _primaryColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: _primaryColor),
        borderRadius: radius,
        color: _fillColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap.takeIf((_) => enabled),
        child: Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), child: _buildTitle(context)),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return CrossFadeOverlay(
      overlayVisible: loading,
      overlay: Center(child: AppLoader(color: _titleColor)),
      child: IconTheme.merge(
        data: IconThemeData(color: color),
        child: DefaultTextStyle(
          style: AppText.button.copyWith(color: _titleColor),
          child: Center(widthFactor: 1, heightFactor: 1, child: child),
        ),
      ),
    );
  }

  Color get _titleColor {
    if (titleColor != null) return titleColor!;
    switch (type) {
      case AppButtonType.primary:
        return Colors.white;
      case AppButtonType.outlined:
        return !enabled ? AppColors.disabled : color ?? AppColors.primary;
    }
  }
}

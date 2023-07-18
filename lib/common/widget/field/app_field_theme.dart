import 'package:DART_PACKAGE_NAME/common/constant/app_colors.dart';
import 'package:DART_PACKAGE_NAME/common/constant/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppFieldThemeData {
  final TextStyle style, labelStyle, errorStyle, hintStyle;
  final BoxDecoration decoration;
  final EdgeInsets textPadding;

  const AppFieldThemeData({
    required this.style,
    required this.labelStyle,
    required this.errorStyle,
    required this.hintStyle,
    required this.decoration,
    required this.textPadding,
  });

  AppFieldThemeData copyWith({
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    TextStyle? hintStyle,
    BoxDecoration? decoration,
    EdgeInsets? textPadding,
  }) {
    return AppFieldThemeData(
      style: style ?? this.style,
      labelStyle: labelStyle ?? this.labelStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      decoration: decoration ?? this.decoration,
      textPadding: textPadding ?? this.textPadding,
    );
  }

  static final standard = AppFieldThemeData(
    style: AppText.input,
    labelStyle: AppText.inputLabel,
    errorStyle: AppText.inputLabel.copyWith(color: AppColors.error),
    hintStyle: AppText.inputHint,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Colors.white,
    ),
    textPadding: const EdgeInsets.all(16),
  );
}

class AppFieldTheme extends StatelessWidget {
  final AppFieldThemeData Function(AppFieldThemeData) transform;

  const AppFieldTheme.transform({super.key, required this.transform});

  AppFieldTheme({super.key, required AppFieldThemeData theme}) : transform = ((_) => theme);

  static AppFieldThemeData of(BuildContext context) => context.watch() ?? AppFieldThemeData.standard;

  @override
  Widget build(BuildContext context) => Provider.value(value: transform(of(context)));
}

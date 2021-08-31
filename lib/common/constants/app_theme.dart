import 'package:DART_PACKAGE_NAME/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/navigation/route_config.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  accentColor: AppColors.accent,
  appBarTheme: AppBarTheme(backwardsCompatibility: false, systemOverlayStyle: RouteConfig.darkTop),
);
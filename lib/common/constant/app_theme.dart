import 'package:DART_PACKAGE_NAME/common/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';

// TODO Adjust default AppBarTheme
final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  appBarTheme: AppBarTheme(systemOverlayStyle: RouteConfig.darkTop),
);

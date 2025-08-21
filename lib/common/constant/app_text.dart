import 'package:DART_PACKAGE_NAME/common/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';

// TODO Specify styles
class AppText {
  const AppText._();

  static const input = TextStyle();

  static const inputLabel = TextStyle();

  static final inputHint = input.copyWith(color: AppColors.textSecondary);

  static const button = TextStyle();
}

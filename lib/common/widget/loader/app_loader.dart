import 'package:DART_PACKAGE_NAME/common/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';

// TODO Setup loader
class AppLoader extends StatelessWidget {
  final Color color;

  const AppLoader({this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) => CupertinoActivityIndicator(color: color);
}

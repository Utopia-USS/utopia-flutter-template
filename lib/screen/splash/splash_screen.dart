import 'package:flutter/cupertino.dart';
import 'package:utopia_arch/navigation/route_config.dart';

class SplashScreen extends StatelessWidget {
  static const route = '/splash';
  static final routeConfig = RouteConfig.material(() => SplashScreen());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
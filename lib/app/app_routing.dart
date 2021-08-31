import 'package:DART_PACKAGE_NAME/screen/splash/splash_screen.dart';
import 'package:utopia_arch/navigation/route_config.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    SplashScreen.route: SplashScreen.routeConfig,
  };

  static const initialRoute = SplashScreen.route;
}

import 'package:DART_PACKAGE_NAME/app/app_injector.dart';
import 'package:DART_PACKAGE_NAME/app/app_reporter.dart';
import 'package:DART_PACKAGE_NAME/app/app_routing.dart';
import 'package:DART_PACKAGE_NAME/app/state/setup/setup_state_provider.dart';
import 'package:DART_PACKAGE_NAME/common/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:utopia_arch/injector/injector_provider.dart';
import 'package:utopia_arch/navigation/route_config.dart';
import 'package:utopia_arch/navigation/scoped_navigator_state.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/reporter/run_app_with_reporter.dart';

class App extends HookWidget {
  static void run() {
    UtopiaHooks.reporter = appReporter;
    runAppWithReporter(appReporter, App());
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = useMemoized(() => GlobalKey<NavigatorState>());
    return MultiProvider(
      providers: _buildProviders(navigatorKey: navigatorKey),
      child: _buildApp(navigatorKey: navigatorKey),
    );
  }

  List<SingleChildWidget> _buildProviders({required GlobalKey<NavigatorState> navigatorKey}) {
    return [
      Provider<ScopedNavigatorState>.value(value: ScopedNavigatorState(navigatorKey: navigatorKey)),
      InjectorProvider(setupInjector: () => AppInjector.setup()),
      SetupStateProvider(),
    ];
  }

  Widget _buildApp({required GlobalKey<NavigatorState> navigatorKey}) {
    return MaterialApp(
      theme: appTheme,
      scrollBehavior: MaterialScrollBehavior().copyWith(physics: BouncingScrollPhysics()),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateInitialRoutes: (name) => [RouteConfig.generateInitialRoute(AppRouting.routes, name)],
      onGenerateRoute: (settings) => RouteConfig.generateRoute(AppRouting.routes, settings),
      navigatorObservers: [RouteConfig.createNavigationObserver(AppRouting.routes)],
      initialRoute: AppRouting.initialRoute,
    );
  }
}

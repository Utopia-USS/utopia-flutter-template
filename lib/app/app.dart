import 'package:DART_PACKAGE_NAME/app/app_injector.dart';
import 'package:DART_PACKAGE_NAME/app/app_reporter.dart';
import 'package:DART_PACKAGE_NAME/app/app_routing.dart';
import 'package:DART_PACKAGE_NAME/app/state/setup/setup_state_provider.dart';
import 'package:DART_PACKAGE_NAME/app/widget/app_global_error_dialog.dart';
import 'package:DART_PACKAGE_NAME/common/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class App extends HookWidget {
  static void run() {
    runWithReporterAndUiErrors(appReporter, (uiErrors) {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(App(uiErrors: uiErrors));
    });
  }

  final Stream<UiGlobalError> uiErrors;

  const App({Key? key, required this.uiErrors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorKey = useMemoized(GlobalKey<NavigatorState>.new);

    return _buildApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => MultiProvider(
        providers: _buildProviders(),
        child: HookBuilder(builder: (context) {
          if (!kDebugMode) {
            useStreamSubscription<UiGlobalError>(
              uiErrors,
              (error) => _handleUiError(context, error, navigatorKey.currentState!),
            );
          }
          return child;
        }),
      ),
    );
  }

  Widget _buildApp({
    required GlobalKey<NavigatorState> navigatorKey,
    required Widget Function(BuildContext context, Widget child) builder,
  }) {
    return MaterialApp(
      // theming
      theme: appTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(physics: const BouncingScrollPhysics()),
      // navigation
      navigatorKey: navigatorKey,
      onGenerateInitialRoutes: (name) => [RouteConfig.generateInitialRoute(AppRouting.routes, name)],
      onGenerateRoute: (settings) => RouteConfig.generateRoute(AppRouting.routes, settings),
      navigatorObservers: [RouteConfig.createNavigationObserver(AppRouting.routes)],
      initialRoute: AppRouting.initialRoute,
      // localization
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      // other
      debugShowCheckedModeBanner: false,
      builder: (context, child) => builder(context, child!),
    );
  }

  List<SingleChildWidget> _buildProviders() {
    return [
      const InjectorProvider(setupInjector: AppInjector.setup),
      SetupStateProvider(),
    ];
  }

  void _handleUiError(BuildContext context, UiGlobalError error, NavigatorState navigator) {
    final route = DialogRoute<void>(
      context: context,
      builder: (context) => AppGlobalErrorDialog(error: error),
    );
    navigator.push(route);
  }
}

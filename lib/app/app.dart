import 'package:DART_PACKAGE_NAME/app/app_injector.dart';
import 'package:DART_PACKAGE_NAME/app/app_localizations.dart';
import 'package:DART_PACKAGE_NAME/app/app_reporter.dart';
import 'package:DART_PACKAGE_NAME/app/app_routing.dart';
import 'package:DART_PACKAGE_NAME/app/state/firebase/firebase_state.dart';
import 'package:DART_PACKAGE_NAME/app/state/initialization/initialization_state.dart';
import 'package:DART_PACKAGE_NAME/app/state/precache/image_precache_state.dart';
import 'package:DART_PACKAGE_NAME/app/widget/app_global_error_dialog.dart';
import 'package:DART_PACKAGE_NAME/common/constant/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_localization_utils/utopia_localization_utils.dart';

typedef NavigatorKey = GlobalKey<NavigatorState>;

class App extends HookWidget {
  static void run() {
    runWithReporterAndUiErrors(appReporter, (uiErrors) {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(App(uiErrors: uiErrors));
    });
  }

  final Stream<UiGlobalError> uiErrors;

  const App({super.key, required this.uiErrors});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = useMemoized(GlobalKey<NavigatorState>.new);

    return _buildApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => HookProviderContainerWidget(
        _buildProviders(navigatorKey),
        child: HookBuilder(builder: (context) {
          useStreamSubscription<UiGlobalError>(
            uiErrors,
            strategy: StreamSubscriptionStrategy.drop,
            (error) async => _handleUiError(context, error, navigatorKey.currentState!),
          );
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
        UtopiaLocalizationsDelegate<AppLocalizationsData>(appLocalizationsData),
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: appLocalizationsData.supportedLocales,
      // other
      debugShowCheckedModeBanner: false,
      builder: (context, child) => builder(context, child!),
    );
  }

  Map<Type, Object? Function()> _buildProviders(NavigatorKey navigatorKey) {
    return {
      NavigatorKey: () => navigatorKey,
      Injector: AppInjector.use,
      FirebaseState: useFirebaseState,
      ImagePrecacheState: useImagePrecacheState,
      InitializationState: useInitializationState, // leave at the end
    };
  }

  Future<void> _handleUiError(BuildContext context, UiGlobalError error, NavigatorState navigator) async {
    // skip debug-time assertion errors
    if (error.error is! AssertionError) {
      final route = DialogRoute<void>(
        context: context,
        builder: (context) => AppGlobalErrorDialog(error: error),
      );
      await navigator.push(route);
    }
  }
}

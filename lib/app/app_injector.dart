import 'package:DART_PACKAGE_NAME/app/app_config.dart';
import 'package:injector/injector.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppInjector {
  const AppInjector._();

  static Injector setup() {
    final injector = Injector();
    injector
      ..registerSingleton(() => AppConfig.current)
      ..registerSingleton(() => PreferencesService());
    return injector;
  }
}

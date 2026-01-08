import 'package:DART_PACKAGE_NAME/app/app_config.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppInjector {
  const AppInjector._();

  static Injector use() => useMemoized(() => Injector.build(_setup));

  static void _setup(InjectorRegister register) {
    register.instance(AppConfig.current);
    register.noarg(PreferencesService.new);
  }
}

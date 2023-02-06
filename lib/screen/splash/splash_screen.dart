import 'package:DART_PACKAGE_NAME/app/state/initialization/initialization_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SplashScreen extends HookWidget {
  static const route = '/splash';
  static final routeConfig = RouteConfig.material(SplashScreen.new);

  @override
  Widget build(BuildContext context) {
    final initializationState = useProvided<InitializationState>();

    useSimpleEffect(() {
      if(initializationState.isInitialized) {
        // TODO Navigate to the next screen
      }
    }, [initializationState.isInitialized]);

    return Container();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SplashScreen extends HookWidget {
  static const route = '/splash';
  static final routeConfig = RouteConfig.material(SplashScreen.new);

  @override
  Widget build(BuildContext context) {
    final submitState = useSubmitState();

    useSimpleEffect(() {
      submitState.run<void>(() async {
        await Future<void>.delayed(const Duration(seconds: 1));
        throw Exception("Test");
      });
    }, []);

    return Container();
  }
}
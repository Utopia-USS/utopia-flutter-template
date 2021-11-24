import 'package:DART_PACKAGE_NAME/app/state/setup/setup_state.dart';
import 'package:DART_PACKAGE_NAME/common/constants/app_images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_firebase_crashlytics/utopia_firebase_crashlytics.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SetupStateProvider extends HookStateProviderWidget<SetupState> {
  @override
  SetupState use() {
    final isInitializedValue = useState<bool>(false);
    final context = useContext();

    useSimpleEffect(() async {
      await Future.wait([
        _precacheImages(context),
        _setupFirebase(),
        Future.delayed(Duration(seconds: 1)), // workaround: ensure long enough wait to prevent startup lag
      ]);
      isInitializedValue.value = true;
    }, []);

    return SetupState(isInitialized: isInitializedValue.value);
  }

  Future<void> _precacheImages(BuildContext context) async {
    await Future.wait(AppImages.precached.map((image) => precacheImage(AssetImage(image), context)));
  }

  Future<void> _setupFirebase() async {
    await Firebase.initializeApp();
    await UtopiaFirebaseCrashlytics.setup();
  }
}

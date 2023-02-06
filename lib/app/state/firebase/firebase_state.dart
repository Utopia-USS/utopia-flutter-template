import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class FirebaseState extends HasInitialized {
  const FirebaseState({required super.isInitialized});
}

FirebaseState useFirebaseState() {
  final state = useAutoComputedState(
    compute: () async {
      // TODO uncomment after firebase setup
      //await Firebase.initializeApp();
      //await UtopiaFirebaseCrashlytics.setup();
    },
    keys: [],
  );

  return FirebaseState(isInitialized: state.value is ComputedStateValueReady);
}

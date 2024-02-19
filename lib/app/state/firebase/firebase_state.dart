import 'package:utopia_arch/utopia_arch.dart';

class FirebaseState extends HasInitialized {
  const FirebaseState({required super.isInitialized});
}

FirebaseState useFirebaseState() {
  final state = useAutoComputedState(() async {
    // TODO uncomment after firebase setup
    //await Firebase.initializeApp();
    //await UtopiaFirebaseCrashlytics.setup();
  });

  return FirebaseState(isInitialized: state.value is ComputedStateValueReady);
}

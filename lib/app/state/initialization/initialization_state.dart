import 'package:DART_PACKAGE_NAME/app/state/firebase/firebase_state.dart';
import 'package:DART_PACKAGE_NAME/app/state/precache/image_precache_state.dart';
import 'package:utopia_arch/utopia_arch.dart';

class InitializationState extends HasInitialized {
  const InitializationState({required super.isInitialized});
}

InitializationState useInitializationState() {
  final states = [
    useProvided<FirebaseState>(),
    useProvided<ImagePrecacheState>(),
  ];

  return InitializationState(isInitialized: HasInitialized.all(states));
}

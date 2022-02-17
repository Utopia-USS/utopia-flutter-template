import 'package:DART_PACKAGE_NAME/app/state/setup/setup_state.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

void useAsyncEffectAfterSetup(Future<void> Function() effect, [List<Object>? keys]) {
  final appInitializationState = useProvided<SetupState>();
  useSimpleEffect(() async {
    if (appInitializationState.isInitialized) await effect();
  }, [appInitializationState, ...?keys]);
}

void useStreamSubscriptionAfterSetup<T>(Stream<T> Function() streamProvider, Function(T) block) {
  final setupState = useProvided<SetupState>();

  useStreamSubscription(
    useMemoized(() => setupState.isInitialized ? streamProvider() : null, [setupState.isInitialized]),
    block,
  );
}

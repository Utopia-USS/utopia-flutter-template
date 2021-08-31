import 'package:DART_PACKAGE_NAME/app/state/setup/setup_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_hooks/hook/effect/use_async_effect.dart';
import 'package:utopia_hooks/hook/provider/use_provided.dart';
import 'package:utopia_hooks/hook/stream/use_stream_subscription.dart';

void useAsyncEffectAfterSetup(Future<void> Function() effect, [List<Object>? keys]) {
  final appInitializationState = useProvided<SetupState>();
  useAsyncEffect(() async {
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

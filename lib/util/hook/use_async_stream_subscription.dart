import 'package:utopia_hooks/utopia_hooks.dart';

void useAsyncStreamSubscription<T>(Stream<T> stream, Future<void> Function(T) block) {
  final isHandlingState = useRef(false);
  useStreamSubscription<T>(stream, (value) async {
    if(isHandlingState.value) return;
    isHandlingState.value = true;
    await block(value);
    isHandlingState.value = false;
  });
}
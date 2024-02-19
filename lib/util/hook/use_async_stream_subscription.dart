import 'package:utopia_arch/utopia_arch.dart';

void useAsyncStreamSubscription<T>(Stream<T> stream, Future<void> Function(T) block) {
  final isHandlingState = useState(false, listen: false);
  useStreamSubscription<T>(stream, (value) async {
    if(isHandlingState.value) return;
    isHandlingState.value = true;
    await block(value);
    isHandlingState.value = false;
  });
}

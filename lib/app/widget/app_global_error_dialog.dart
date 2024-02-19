import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppGlobalErrorDialog extends StatelessWidget {
  final UiGlobalError error;

  const AppGlobalErrorDialog({required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: const Text("Something has gone wrong."),
      actions: [
        TextButton(onPressed: () => context.navigator.pop(), child: const Text("Close")),
        if (error.canRetry)
          TextButton(
            onPressed: () {
              context.navigator.pop();
              error.retry!();
            },
            child: const Text("Retry"),
          ),
      ],
    );
  }
}

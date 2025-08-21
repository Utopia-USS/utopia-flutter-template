import 'package:flutter/material.dart';

class CrossFadeOverlay extends StatelessWidget {
  final bool overlayVisible;
  final Duration duration;
  final Widget overlay, child;

  const CrossFadeOverlay({
    required this.overlayVisible,
    this.duration = const Duration(milliseconds: 200),
    required this.overlay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        AnimatedOpacity(duration: duration, curve: Curves.easeInOut, opacity: !overlayVisible ? 1 : 0, child: child),
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: duration,
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            // KeyedSubtree to prevent switching when overlay changes
            child: overlayVisible ? KeyedSubtree(child: overlay) : const SizedBox(),
          ),
        ),
      ],
    );
  }
}

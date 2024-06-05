import 'package:flutter/material.dart';

class MyFab extends StatelessWidget {
  const MyFab({
    super.key,
    required this.showFabNotifier,
    required this.onPressed,
    required this.child
  });

  final ValueNotifier<bool> showFabNotifier;
  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showFabNotifier,
      builder: (_, value, __) {
        return AnimatedSlide(
          offset: value ? Offset.zero : const Offset(0, 2.0),
          curve: Curves.ease, 
          duration: Durations.medium2,
          child: FloatingActionButton(
            onPressed: () {
              onPressed();
            },
            child: child,
          ),
        );
      },
    );
  }
}
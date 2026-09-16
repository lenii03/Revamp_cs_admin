import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppDragToMoveArea extends StatelessWidget {
  final Widget child;

  const AppDragToMoveArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) => windowManager.startDragging(),
      child: child,
    );
  }
}

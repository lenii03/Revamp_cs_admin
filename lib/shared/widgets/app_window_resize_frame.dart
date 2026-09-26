import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
class AppWindowResizeFrame extends StatelessWidget {
  const AppWindowResizeFrame({super.key, required this.child});

  final Widget child;

  static const double _resizeArea = 6;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF233246)
        : const Color(0xFFD5DEE9);

    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: borderColor)),
          ),
        ),
        _ResizeArea(
          alignment: Alignment.topCenter,
          cursor: SystemMouseCursors.resizeUpDown,
          edge: ResizeEdge.top,
          width: double.infinity,
          height: _resizeArea,
        ),
        _ResizeArea(
          alignment: Alignment.bottomCenter,
          cursor: SystemMouseCursors.resizeUpDown,
          edge: ResizeEdge.bottom,
          width: double.infinity,
          height: _resizeArea,
        ),
        _ResizeArea(
          alignment: Alignment.centerLeft,
          cursor: SystemMouseCursors.resizeLeftRight,
          edge: ResizeEdge.left,
          width: _resizeArea,
          height: double.infinity,
        ),
        _ResizeArea(
          alignment: Alignment.centerRight,
          cursor: SystemMouseCursors.resizeLeftRight,
          edge: ResizeEdge.right,
          width: _resizeArea,
          height: double.infinity,
        ),
        _ResizeArea(
          alignment: Alignment.topLeft,
          cursor: SystemMouseCursors.resizeUpLeftDownRight,
          edge: ResizeEdge.topLeft,
          width: _resizeArea * 2,
          height: _resizeArea * 2,
        ),
        _ResizeArea(
          alignment: Alignment.topRight,
          cursor: SystemMouseCursors.resizeUpRightDownLeft,
          edge: ResizeEdge.topRight,
          width: _resizeArea * 2,
          height: _resizeArea * 2,
        ),
        _ResizeArea(
          alignment: Alignment.bottomLeft,
          cursor: SystemMouseCursors.resizeUpRightDownLeft,
          edge: ResizeEdge.bottomLeft,
          width: _resizeArea * 2,
          height: _resizeArea * 2,
        ),
        _ResizeArea(
          alignment: Alignment.bottomRight,
          cursor: SystemMouseCursors.resizeUpLeftDownRight,
          edge: ResizeEdge.bottomRight,
          width: _resizeArea * 2,
          height: _resizeArea * 2,
        ),
      ],
    );
  }
}

class _ResizeArea extends StatelessWidget {
  const _ResizeArea({
    required this.alignment,
    required this.cursor,
    required this.edge,
    required this.width,
    required this.height,
  });

  final Alignment alignment;
  final MouseCursor cursor;
  final ResizeEdge edge;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: MouseRegion(
        cursor: cursor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (_) => windowManager.startResizing(edge),
          child: SizedBox(width: width, height: height),
        ),
      ),
    );
  }
}

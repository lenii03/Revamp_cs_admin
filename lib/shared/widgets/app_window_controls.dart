import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowControls extends StatefulWidget {
  const AppWindowControls({super.key});

  @override
  State<AppWindowControls> createState() => _AppWindowControlsState();
}

class _AppWindowControlsState extends State<AppWindowControls>
    with WindowListener {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _syncMaximizedState();
  }

  Future<void> _syncMaximizedState() async {
    final isMaximized = await windowManager.isMaximized();
    if (mounted) setState(() => _isMaximized = isMaximized);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    if (mounted) setState(() => _isMaximized = true);
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) setState(() => _isMaximized = false);
  }

  Future<void> _toggleMaximize() async {
    if (await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
    await _syncMaximizedState();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color ?? Colors.white;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowControlButton(
          tooltip: 'Minimize',
          icon: Icons.remove,
          iconColor: iconColor,
          onPressed: windowManager.minimize,
        ),
        _WindowControlButton(
          tooltip: _isMaximized ? 'Restore' : 'Maximize',
          icon: _isMaximized ? Icons.filter_none : Icons.crop_square,
          iconColor: iconColor,
          onPressed: _toggleMaximize,
        ),
        _WindowControlButton(
          tooltip: 'Close',
          icon: Icons.close,
          iconColor: iconColor,
          isClose: true,
          onPressed: windowManager.close,
        ),
      ],
    );
  }
}

class _WindowControlButton extends StatefulWidget {
  final String tooltip;
  final IconData icon;
  final Color iconColor;
  final bool isClose;
  final Future<void> Function() onPressed;

  const _WindowControlButton({
    required this.tooltip,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    this.isClose = false,
  });

  @override
  State<_WindowControlButton> createState() => _WindowControlButtonState();
}

class _WindowControlButtonState extends State<_WindowControlButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = widget.isClose
        ? const Color(0xFFE81123)
        : widget.iconColor.withValues(alpha: 0.10);

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Material(
          color: _hovered ? hoverColor : Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            child: SizedBox(
              width: 46,
              height: 32,
              child: Icon(
                widget.icon,
                size: widget.icon == Icons.remove ? 18 : 15,
                color: _hovered && widget.isClose
                    ? Colors.white
                    : widget.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

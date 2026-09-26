import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsManageHelper {
  const WindowsManageHelper._();

  static final bool _isDesktop =
      !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

  static Future<void> setLoginWindow() async {
    if (!_isDesktop) return;

    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow();

    if (await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    }
    await windowManager.setSize(const Size(800, 460));
    await windowManager.center();
    await windowManager.setResizable(true);
    await windowManager.setAsFrameless();
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.show();
    await windowManager.focus();
  }

  static Future<void> setMainWindow() async {
    if (!_isDesktop) return;

    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow();
    if (await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    }
    await windowManager.setSize(const Size(1280, 720));
    await windowManager.center();
    await windowManager.setResizable(true);
    await windowManager.setAsFrameless();
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.show();
    await windowManager.focus();
  }

  static Future<void> toggleFullScreen() async {
    if (!_isDesktop) return;

    await windowManager.ensureInitialized();
    if (await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }
}

import 'package:flutter/material.dart';

import '../../data/local/session_service.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../injector.dart';
import '../navigation/app_navigator.dart';
import '../theme/src/app_colors.dart';

class SessionExpiredHandler {
  SessionExpiredHandler._();

  static bool _isHandling = false;

  static Future<void> handle() async {
    if (_isHandling) return;

    final sessionService = locator<SessionService>();
    if (sessionService.read(SessionKey.token).isEmpty) return;

    _isHandling = true;
    try {
      await Future.wait([
        sessionService.remove(SessionKey.token),
        sessionService.remove(SessionKey.loginId),
        sessionService.remove(SessionKey.password),
      ]);

      final navigator = AppNavigator.navigatorKey.currentState;
      final dialogContext = navigator?.overlay?.context;
      if (navigator == null || dialogContext == null) return;

      await showDialog<void>(
        // ignore: use_build_context_synchronously
        context: dialogContext,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (context) => Dialog(
          backgroundColor: AppColors.systemGroupedBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_clock_outlined,
                  color: Colors.amber,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Session Expired',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your session has expired. Please log in again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryTextColorDark,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),   
                    child: const Text(
                      'Log In Again',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      AppNavigator.navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const LoginPage()),
        (_) => false,
      );
    } finally {
      _isHandling = false;
    }
  }
}

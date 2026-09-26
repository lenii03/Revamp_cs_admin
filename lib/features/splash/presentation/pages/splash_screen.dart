import 'package:el_csadmin/features/authentication/presentation/pages/login_page.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_bloc.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_event.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/network/server_config.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../../../../injector.dart';
import '../../../../shared/widgets/app_drag_to_move_area.dart';
import '../../../../shared/widgets/app_window_controls.dart';
import '../../../../shared/widgets/server_config_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.simulateUpdate = false});
  final bool simulateUpdate;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AutoUpdateBloc _autoUpdateBloc;
  bool _downloadStarted = false;
  bool _installStarted = false;
  bool _navigatingToLogin = false;
  AutoUpdateState? _simulatedState;

  @override
  void initState() {
    super.initState();
    _autoUpdateBloc = locator<AutoUpdateBloc>();
    if (widget.simulateUpdate) {
      _runUpdateSimulation();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkAndStartUpdate();
      });
    }
  }

  Future<void> _checkAndStartUpdate({bool showConfigIfFailed = true}) async {
    if (!mounted) return;
    _downloadStarted = false;
    _installStarted = false;

    _setSimulatedState(
      AutoUpdateLoading('Menghubungi server update (localhost:9008)...'),
    );

    final isConnected = await ServerConfig.checkConnection(
      host: 'localhost',
      port: '9008',
    );

    if (!isConnected) {
      if (!mounted) return;
      _setSimulatedState(
        AutoUpdateFailure(
          'Tidak dapat terhubung ke server update dummy (localhost:9008). Pastikan auto-update-server.exe aktif.',
        ),
      );
      return;
    }

    if (!mounted) return;
    setState(() => _simulatedState = null);
    _autoUpdateBloc.add(CheckForUpdateStarted());
  }

  Future<void> _openServerConfig() async {
    final saved = await ServerConfigDialog.show(context, isDismissible: true);
    if (saved == true && mounted) {
      _checkAndStartUpdate(showConfigIfFailed: true);
    }
  }

  Future<void> _runUpdateSimulation() async {
    _setSimulatedState(AutoUpdateLoading('Checking simulated update...'));
    await Future<void>.delayed(const Duration(milliseconds: 900));

    const totalFiles = 3;
    for (var file = 1; file <= totalFiles; file++) {
      for (var step = 0; step <= 10; step++) {
        if (!mounted) return;
        _setSimulatedState(AutoUpdateDownloading(file, totalFiles, step / 10));
        await Future<void>.delayed(const Duration(milliseconds: 90));
      }
    }

    if (!mounted) return;
    _setSimulatedState(AutoUpdateReadyToInstall());
    await Future<void>.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    _setSimulatedState(AutoUpdateSuccess());
    await Future<void>.delayed(const Duration(milliseconds: 1400));

    if (mounted) _navigateToLogin();
  }

  void _setSimulatedState(AutoUpdateState state) {
    if (!mounted) return;
    setState(() => _simulatedState = state);
  }

  @override
  void dispose() {
    _autoUpdateBloc.close();
    super.dispose();
  }

  void _navigateToLogin() {
    if (_navigatingToLogin || !mounted) return;
    _navigatingToLogin = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, animation, secondaryAnimation) => const LoginPage(),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _retry() {
    _installStarted = false;
    _downloadStarted = false;
    _checkAndStartUpdate(showConfigIfFailed: true);
  }

  void _triggerRestart() {
    if (!_installStarted) {
      _installStarted = true;
      _autoUpdateBloc.add(InstallUpdateStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _autoUpdateBloc,
      child: BlocConsumer<AutoUpdateBloc, AutoUpdateState>(
        listener: (context, state) {
          if (widget.simulateUpdate) return;
          if (state is AutoUpdateUpToDate) {
            _navigateToLogin();
          } else if (state is AutoUpdateAvailable && !_downloadStarted) {
            _downloadStarted = true;
            _autoUpdateBloc.add(
              DownloadUpdateStarted(filesToUpdate: state.filesToDownload),
            );
          }
        },
        builder: (context, state) {
          final effectiveState = _simulatedState ?? state;
          final view = _UpdateViewData.fromState(effectiveState);
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                const Positioned.fill(child: _SplashBackground()),
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final compactHeight = constraints.maxHeight < 560;
                      final outerPadding = compactHeight ? 12.0 : 24.0;
                      return SingleChildScrollView(
                        padding: EdgeInsets.all(outerPadding),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                constraints.maxHeight - (outerPadding * 2),
                          ),
                          child: Center(
                            child: Container(
                              width: compactHeight ? 500 : 520,
                              padding: EdgeInsets.fromLTRB(
                                compactHeight ? 28 : 40,
                                compactHeight ? 18 : 32,
                                compactHeight ? 28 : 40,
                                compactHeight ? 20 : 36,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF101D2B,
                                ).withValues(alpha: 0.94),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.32),
                                    blurRadius: 38,
                                    offset: const Offset(0, 20),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: compactHeight ? 30 : 34,
                                        height: compactHeight ? 30 : 34,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.admin_panel_settings_outlined,
                                          color: AppColors.primaryColor,
                                          size: compactHeight ? 19 : 21,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'CS Admin',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: compactHeight ? 17 : 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: compactHeight ? 120 : 210,
                                    child: Lottie.asset(
                                      'assets/animations/paperplane_loading.json',
                                      repeat: view.animate,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    view.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: compactHeight ? 20 : 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (view.description.isNotEmpty) ...[
                                    SizedBox(height: compactHeight ? 6 : 10),
                                    Text(
                                      view.description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF9EB0C2),
                                        height: compactHeight ? 1.35 : 1.5,
                                        fontSize: compactHeight ? 13 : 14,
                                      ),
                                    ),
                                  ],
                                  if (effectiveState
                                      is AutoUpdateDownloading) ...[
                                    SizedBox(height: compactHeight ? 16 : 28),
                                    _DownloadProgress(state: effectiveState),
                                  ] else if (effectiveState
                                      is AutoUpdateLoading) ...[
                                    SizedBox(height: compactHeight ? 16 : 28),
                                    const LinearProgressIndicator(
                                      minHeight: 5,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: AppColors.primaryColor,
                                      backgroundColor: Color(0xFF203244),
                                    ),
                                  ],
                                  SizedBox(height: compactHeight ? 16 : 28),
                                  _buildActions(
                                    effectiveState,
                                    compact: compactHeight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 28,
                  child: AppDragToMoveArea(child: SizedBox.expand()),
                ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: AppWindowControls(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions(AutoUpdateState state, {required bool compact}) {
    if (state is AutoUpdateFailure) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _navigateToLogin,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: compact ? 10 : 14),
                foregroundColor: const Color(0xFF9EB0C2),
                side: const BorderSide(color: Color(0xFF30445A)),
              ),
              child: const Text('Skip'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _openServerConfig,
              icon: const Icon(Icons.settings_ethernet, size: 15),
              label: const Text('Server IP', style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: compact ? 10 : 14),
                foregroundColor: AppColors.primaryColor,
                side: const BorderSide(color: Color(0xFF30445A)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: _retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: const Color(0xFF07111A),
                padding: EdgeInsets.symmetric(vertical: compact ? 10 : 14),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      );
    }

    if (state is AutoUpdateReadyToInstall) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _triggerRestart,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: const Color(0xFF07111A),
            padding: EdgeInsets.symmetric(vertical: compact ? 10 : 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Restart',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
      );
    }

    return const Text(
      'The update check runs automatically. Please wait a moment.',
      textAlign: TextAlign.center,
      style: TextStyle(color: Color(0xFF6F8498), fontSize: 12),
    );
  }
}

class _DownloadProgress extends StatelessWidget {
  const _DownloadProgress({required this.state});

  final AutoUpdateDownloading state;

  @override
  Widget build(BuildContext context) {
    final progress = state.progress.clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'File ${state.currentFileIndex} of ${state.totalFiles}',
              style: const TextStyle(color: Color(0xFF9EB0C2), fontSize: 12),
            ),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        LinearProgressIndicator(
          value: progress,
          minHeight: 7,
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
          backgroundColor: const Color(0xFF203244),
        ),
      ],
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.55, -0.65),
          radius: 1.35,
          colors: [Color(0xFF123247), Color(0xFF07111A)],
        ),
      ),
      child: CustomPaint(painter: _GridPainter()),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 1;
    const gap = 48.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UpdateViewData {
  const _UpdateViewData({
    required this.title,
    required this.description,
    this.animate = true,
  });

  final String title;
  final String description;
  final bool animate;

  factory _UpdateViewData.fromState(AutoUpdateState state) {
    if (state is AutoUpdateDownloading) {
      return const _UpdateViewData(
        title: 'Downloading update',
        description: 'We are preparing the latest version for you.',
      );
    }
    if (state is AutoUpdateReadyToInstall) {
      return const _UpdateViewData(
        title: 'Pembaruan Berhasil Diunduh',
        description: '',
        animate: false,
      );
    }
    if (state is AutoUpdateFailure) {
      return _UpdateViewData(
        title: 'Update was not completed',
        description: state.message,
        animate: false,
      );
    }
    if (state is AutoUpdateSuccess) {
      return const _UpdateViewData(
        title: 'Restarting application',
        description:
            'The update is complete. The application will reopen shortly.',
      );
    }
    return const _UpdateViewData(
      title: 'Preparing CS Admin',
      description:
          'Checking for the latest updates to keep the application secure and optimized.',
    );
  }
}

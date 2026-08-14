import 'package:el_csadmin/features/authentication/presentation/pages/login_page.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_bloc.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_event.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/src/app_colors.dart';
import '../../../../injector.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.simulateUpdate = false});

  /// Khusus preview alur update pada mode Debug. Tidak mengakses server,
  /// mengunduh file, maupun menjalankan update.exe.
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
      _autoUpdateBloc.add(CheckForUpdateStarted());
    }
  }

  Future<void> _runUpdateSimulation() async {
    _setSimulatedState(
      AutoUpdateLoading('Memeriksa pembaruan simulasi...'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 900));

    const totalFiles = 3;
    for (var file = 1; file <= totalFiles; file++) {
      for (var step = 0; step <= 10; step++) {
        if (!mounted) return;
        _setSimulatedState(
          AutoUpdateDownloading(file, totalFiles, step / 10),
        );
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
    _downloadStarted = false;
    _installStarted = false;
    _autoUpdateBloc.add(CheckForUpdateStarted());
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
          } else if (state is AutoUpdateReadyToInstall && !_installStarted) {
            _installStarted = true;
            _autoUpdateBloc.add(InstallUpdateStarted());
          }
        },
        builder: (context, state) {
          final effectiveState = _simulatedState ?? state;
          final view = _UpdateViewData.fromState(effectiveState);
          return Scaffold(
            backgroundColor: const Color(0xFF07111A),
            body: Stack(
              children: [
                const Positioned.fill(child: _SplashBackground()),
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 48,
                          ),
                          child: Center(
                            child: Container(
                              width: 520,
                              padding: const EdgeInsets.fromLTRB(
                                40,
                                32,
                                40,
                                36,
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
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.admin_panel_settings_outlined,
                                          color: AppColors.primaryColor,
                                          size: 21,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'CS Admin',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 210,
                                    child: Lottie.asset(
                                      'assets/animations/paperplane_loading.json',
                                      repeat: view.animate,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    view.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    view.description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF9EB0C2),
                                      height: 1.5,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (effectiveState
                                      is AutoUpdateDownloading) ...[
                                    const SizedBox(height: 28),
                                    _DownloadProgress(state: effectiveState),
                                  ] else if (effectiveState
                                      is AutoUpdateLoading) ...[
                                    const SizedBox(height: 28),
                                    const LinearProgressIndicator(
                                      minHeight: 5,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: AppColors.primaryColor,
                                      backgroundColor: Color(0xFF203244),
                                    ),
                                  ],
                                  const SizedBox(height: 28),
                                  _buildActions(effectiveState),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions(AutoUpdateState state) {
    if (state is AutoUpdateFailure) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _navigateToLogin,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                foregroundColor: const Color(0xFF9EB0C2),
                side: const BorderSide(color: Color(0xFF30445A)),
              ),
              child: const Text('Lewati'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: const Color(0xFF07111A),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Coba Lagi',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      );
    }

    return const Text(
      'Pemeriksaan berjalan otomatis. Mohon tunggu sebentar.',
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
              'File ${state.currentFileIndex} dari ${state.totalFiles}',
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
        title: 'Mengunduh pembaruan',
        description: 'Kami sedang menyiapkan versi terbaru untuk Anda.',
      );
    }
    if (state is AutoUpdateReadyToInstall) {
      return const _UpdateViewData(
        title: 'Menerapkan pembaruan',
        description: 'Aplikasi akan dimulai ulang secara otomatis.',
      );
    }
    if (state is AutoUpdateFailure) {
      return _UpdateViewData(
        title: 'Pembaruan belum berhasil',
        description: state.message,
        animate: false,
      );
    }
    if (state is AutoUpdateSuccess) {
      return const _UpdateViewData(
        title: 'Memulai ulang aplikasi',
        description: 'Pembaruan selesai. Aplikasi akan segera dibuka kembali.',
      );
    }
    return const _UpdateViewData(
      title: 'Menyiapkan CS Admin',
      description:
          'Memeriksa pembaruan terbaru agar aplikasi tetap aman dan optimal.',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auto_update_bloc.dart';
import '../bloc/auto_update_state.dart';
import '../../../../../core/theme/src/app_colors.dart';

class AutoUpdateDialog extends StatelessWidget {
  const AutoUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoUpdateBloc, AutoUpdateState>(
      builder: (context, state) {
        double progressValue = 0.0;
        String statusText = "Menyiapkan pembaruan...";
        String detailText = "";

        if (state is AutoUpdateDownloading) {
          progressValue = state.progress;
          statusText = "Mengunduh pembaruan...";
          detailText =
              "File ${state.currentFileIndex} dari ${state.totalFiles} (${(progressValue * 100).toStringAsFixed(1)}%)";
        } else if (state is AutoUpdateSuccess) {
          progressValue = 1.0;
          statusText = "Pembaruan Selesai!";
          detailText = "Siap menerapkan versi terbaru.";
        } else if (state is AutoUpdateFailure) {
          statusText = "Pembaruan Gagal";
          detailText = state.message;
        }

        return Dialog(
          backgroundColor: AppColors.cardDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.system_update_rounded,
                  color: AppColors.primaryColor,
                  size: 48,
                ),
                const SizedBox(height: 24),
                Text(
                  statusText,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  detailText,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (state is AutoUpdateDownloading ||
                    state is AutoUpdateLoading) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: state is AutoUpdateDownloading
                          ? progressValue
                          : null,
                      backgroundColor: AppColors.backgroundDark,
                      color: AppColors.primaryColor,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (state is AutoUpdateFailure)
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorRed,
                    ),
                    child: const Text(
                      "Tutup",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:async'; // 👇 Wajib di-import untuk menggunakan Timer
import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_event.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_state.dart';
import 'package:el_csadmin/features/online/approval/presentation/widgets/approval_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/src/app_colors.dart';

class DashboardPendingApprovalWidget extends StatefulWidget {
  const DashboardPendingApprovalWidget({super.key});

  @override
  State<DashboardPendingApprovalWidget> createState() =>
      _DashboardPendingApprovalWidgetState();
}

class _DashboardPendingApprovalWidgetState
    extends State<DashboardPendingApprovalWidget> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      context.read<ApprovalScreenBloc>().add(FetchApprovalsEvent());
      print("🔄 [DASHBOARD] Auto-refresh antrean persetujuan dieksekusi!");
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  String _getLoginTypeName(String typeStr) {
    int type = int.tryParse(typeStr) ?? -1;
    switch (type) {
      case 1:
        return 'Client';
      case 2:
        return 'Sales';
      case 3:
        return 'Branch';
      case 0:
        return 'Demo Account';
      default:
        return 'Tipe Lain';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pending Approval",
                  style: TextStyle(
                    color: AppColors.textColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Arahkan ke halaman Approval Screen penuh
                  },
                  child: const Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.separatorDark, height: 1),

          // LIST DATA DENGAN BLOCBUILDER
          Expanded(
            child: BlocBuilder<ApprovalScreenBloc, ApprovalScreenState>(
              builder: (context, state) {
                if (state is ApprovalScreenLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryDark,
                    ),
                  );
                } else if (state is ApprovalScreenError) {
                  return Center(
                    child: Text(
                      "Gagal memuat data:\n${state.message}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.destructiveRedDark,
                      ),
                    ),
                  );
                } else if (state is ApprovalScreenLoaded) {
                  final pendingList = state.data
                      .where((e) => e.status.toLowerCase() == 'pending')
                      .take(5)
                      .toList();

                  if (pendingList.isEmpty) {
                    return const Center(
                      child: Text(
                        "Tidak ada nasabah yang menunggu persetujuan 🎉",
                        style: TextStyle(
                          color: AppColors.secondaryTextColorDark,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: pendingList.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.separatorDark,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final ApprovalScreenModel data = pendingList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12.0,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryDark.withValues(
                                alpha: 0.15,
                              ),
                              child: Text(
                                data.loginId.isNotEmpty
                                    ? data.loginId[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.loginId,
                                    style: const TextStyle(
                                      color: AppColors.textColorDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColorDark,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${data.action} ${_getLoginTypeName(data.loginType)}",
                                style: const TextStyle(
                                  color: AppColors.secondaryTextColorDark,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent.withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.orangeAccent.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Menunggu",
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // 5. Tombol Aksi
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                      ApprovalDetailDialog(data: data),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.secondaryTextColorDark,
                                size: 16,
                              ),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

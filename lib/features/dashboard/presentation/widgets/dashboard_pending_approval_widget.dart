import 'dart:async'; // 👇 Wajib di-import untuk menggunakan Timer
import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_event.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_state.dart';
import 'package:el_csadmin/features/online/approval/presentation/pages/approval_screen_page.dart';
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
      context.read<ApprovalScreenBloc>().add(
        const ApprovalScreenEvent.fetchApprovals(),
      );
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
        color: Theme.of(
          context,
        ).extension<ThemeColors>()?.appContainerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.separatorDark
              : AppColors.separatorLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pending Approval",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ApprovalScreenPage(showBackButton: true),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
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
          Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.separatorDark
                : AppColors.separatorLight,
            height: 1,
          ),
          Expanded(
            child: BlocBuilder<ApprovalScreenBloc, ApprovalScreenState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  error: (message) => Center(
                    child: Text(
                      "Failed to load data:\n$message",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.destructiveRedDark,
                      ),
                    ),
                  ),
                  loaded: (data) {
                    final pendingList = data
                        .where((e) => e.status.toLowerCase() == 'pending' || e.status == '1')
                        .toList();

                    if (pendingList.isEmpty) {
                      return Center(
                        child: Text(
                          "No customers are awaiting approval 🎉",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).extension<ThemeColors>()?.unselectedLabel,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: pendingList.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.separatorDark
                            : AppColors.separatorLight,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final ApprovalScreenModel item = pendingList[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryDark
                                    .withValues(alpha: 0.15),
                                child: Text(
                                  item.loginId.isNotEmpty
                                      ? item.loginId[0].toUpperCase()
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
                                      item.loginId,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.email,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .extension<ThemeColors>()
                                            ?.unselectedLabel,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${item.action} ${_getLoginTypeName(item.loginType)}",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).extension<ThemeColors>()?.unselectedLabel,
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
                                  "Pending",
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => ApprovalDetailDialog(
                                      data: item,
                                      onApprove: () {
                                        context.read<ApprovalScreenBloc>().add(
                                          ApprovalScreenEvent.approveItem(item),
                                        );
                                      },
                                      onReject: () {
                                        context.read<ApprovalScreenBloc>().add(
                                          ApprovalScreenEvent.rejectItem(item),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(
                                    context,
                                  ).extension<ThemeColors>()?.unselectedLabel,
                                  size: 16,
                                ),
                                splashRadius: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  orElse: () => const SizedBox(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

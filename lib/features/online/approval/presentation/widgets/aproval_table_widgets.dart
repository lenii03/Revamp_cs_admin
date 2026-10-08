import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_event.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_state.dart';
import 'package:el_csadmin/features/online/approval/presentation/widgets/approval_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../shared/widgets/app_data_grid.dart';

class ApprovalTableWidget extends StatelessWidget {
  const ApprovalTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: separatorColor),
      ),
      child: BlocConsumer<ApprovalScreenBloc, ApprovalScreenState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              final cleanMessage = message.replaceAll('Exception: ', '');

              showDialog(
                context: context,
                builder: (dialogContext) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Theme.of(
                      dialogContext,
                    ).extension<ThemeColors>()?.appContainerBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.warning_rounded,
                            color: Colors.amber,
                            size: 72,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Notice',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            cleanMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 48,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: const Text(
                              'Close',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
            error: (_) => _buildEmptyState(
              context,
              'Unable to complete the approval request.',
            ),
            loaded: (data) {
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    "No user data found.",
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).extension<ThemeColors>()?.unselectedLabel,
                    ),
                  ),
                );
              }
              return _buildTable(context, data);
            },
            orElse: () => Center(
              child: Text(
                "Loading table data...",
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).extension<ThemeColors>()?.unselectedLabel,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).extension<ThemeColors>()?.unselectedLabel,
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<ApprovalScreenModel> dataList) {
    String normalizeStatus(String status) {
      if (status == '1' || status.toLowerCase() == 'pending') return 'Pending';
      if (status == '2' || status.toLowerCase() == 'approved') {
        return 'Approved';
      }
      if (status == '0' ||
          status == '3' ||
          status.toLowerCase() == 'rejected') {
        return 'Rejected';
      }
      return status;
    }

    Widget actionRenderer(TrinaColumnRendererContext renderContext) {
      final action = renderContext.cell.value.toString();
      final isDark = Theme.of(context).brightness == Brightness.dark;
      Color textColor = AppColors.textColorDark;
      if (action.toLowerCase() == 'add') {
        textColor = isDark ? Colors.greenAccent : const Color(0xFF4CAF50);
      } else if (action.toLowerCase() == 'delete') {
        textColor = isDark ? Colors.redAccent : const Color(0xFFF44336);
      } else if (action.toLowerCase() == 'edit') {
        textColor = isDark ? Colors.orangeAccent : const Color(0xFFFF9800);
      }

      return InkWell(
        onTap: () {
          final rowApprovalId = renderContext.row.cells['approvalId']?.value;
          final selectedRowData = dataList.firstWhere(
            (e) => e.approvalId == rowApprovalId,
            orElse: () => dataList.first,
          );

          showDialog(
            context: context,
            builder: (ctx) => ApprovalDetailDialog(
              data: selectedRowData,
              onApprove: () {
                context.read<ApprovalScreenBloc>().add(
                  ApprovalScreenEvent.approveItem(selectedRowData),
                );
              },
              onReject: () {
                context.read<ApprovalScreenBloc>().add(
                  ApprovalScreenEvent.rejectItem(selectedRowData),
                );
              },
              loadLinkedAccounts: context
                  .read<ApprovalScreenBloc>()
                  .getLinkedAccountsDetail,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            action,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              decoration: TextDecoration.underline,
              decorationColor: textColor,
            ),
          ),
        ),
      );
    }

    Widget statusRenderer(TrinaColumnRendererContext renderContext) {
      final status = renderContext.cell.value.toString();
      Color bgColor = Colors.grey.shade600;
      if (status.toLowerCase() == 'approved') {
        bgColor = const Color(0xFF4CAF50);
      } else if (status.toLowerCase() == 'rejected') {
        bgColor = const Color(0xFFF44336);
      } else if (status.toLowerCase() == 'pending') {
        bgColor = const Color(0xFFC08080);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Action',
        field: 'action',
        type: TrinaColumnType.text(),
        width: 80,
        renderer: actionRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 200,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: 116,
        renderer: statusRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Account Expired',
        field: 'accountExpired',
        type: TrinaColumnType.text(),
        width: 140,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Sales / Branch Id',
        field: 'salesOrBranch',
        type: TrinaColumnType.text(),
        width: 130,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Created By',
        field: 'createdBy',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Permissions',
        field: 'permissions',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Approval Id',
        field: 'approvalId',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
    ];

    final List<TrinaRow> rows = dataList.map((data) {
      return TrinaRow(
        cells: {
          'action': TrinaCell(value: data.action),
          'loginId': TrinaCell(value: data.loginId),
          'email': TrinaCell(value: data.email),
          'loginType': TrinaCell(
            value: _getLoginTypeName(int.tryParse(data.loginType) ?? -1),
          ),
          'status': TrinaCell(value: normalizeStatus(data.status)),
          'accountExpired': TrinaCell(
            value: data.accountExpired == ""
                ? "Never Expired"
                : data.accountExpired,
          ),
          'salesOrBranch': TrinaCell(value: data.salesBranchId),
          'createdBy': TrinaCell(value: data.createdBy),
          'permissions': TrinaCell(value: data.permissions),
          'approvalId': TrinaCell(value: data.approvalId),
        },
      );
    }).toList();

    return AppDataGrid(
      columns: columns,
      rows: rows,
      // Preserve readable status badges and use horizontal scrolling instead
      // of squeezing columns when the desktop window is not maximized.
      autoSizeMode: TrinaAutoSizeMode.none,
    );
  }

  String _getLoginTypeName(int type) {
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
        return 'Tipe Lain ($type)';
    }
  }
}

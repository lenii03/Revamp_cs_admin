import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_state.dart';
import 'package:el_csadmin/features/online/approval/presentation/widgets/approval_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../shared/widgets/app_data_grid.dart';

class ApprovalTableWidget extends StatelessWidget {
  const ApprovalTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: BlocBuilder<ApprovalScreenBloc, ApprovalScreenState>(
        builder: (context, state) {
          if (state is ApprovalScreenLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryDark),
            );
          } else if (state is ApprovalScreenError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${state.message}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.destructiveRedDark),
              ),
            );
          } else if (state is ApprovalScreenLoaded) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada data pengguna yang ditemukan.",
                  style: TextStyle(color: AppColors.secondaryTextColorDark),
                ),
              );
            }
            return _buildTable(context, state.data);
          }
          return const Center(
            child: Text(
              "Memuat data tabel...",
              style: TextStyle(color: AppColors.secondaryTextColorDark),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<ApprovalScreenModel> dataList) {
    Widget actionRenderer(TrinaColumnRendererContext renderContext) {
      final action = renderContext.cell.value.toString();
      Color textColor = Colors.white;
      if (action.toLowerCase() == 'add')
        textColor = Colors.greenAccent;
      else if (action.toLowerCase() == 'delete')
        textColor = Colors.redAccent;
      else if (action.toLowerCase() == 'edit')
        textColor = Colors.orangeAccent;

      return InkWell(
        onTap: () {
          final rowApprovalId = renderContext.row.cells['approvalId']?.value
              .toString();
          final rowData = dataList.firstWhere(
            (e) => e.approvalId == rowApprovalId,
          );
          showDialog(
            context: context,
            builder: (ctx) => ApprovalDetailDialog(data: rowData),
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

    // Renderer Status (Kotak Background)
    Widget statusRenderer(TrinaColumnRendererContext renderContext) {
      final status = renderContext.cell.value.toString();
      Color bgColor = Colors.grey.shade600;
      if (status.toLowerCase() == 'approved')
        bgColor = const Color(0xFF4CAF50); // Hijau
      else if (status.toLowerCase() == 'rejected')
        bgColor = const Color(0xFFF44336); // Merah
      else if (status.toLowerCase() == 'pending')
        bgColor = const Color(0xFFC08080); // Coklat/Orange

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

    // 💡 PENYESUAIAN WIDTH AGAR PAS 1 LAYAR
    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Action',
        field: 'action',
        type: TrinaColumnType.text(),
        width: 80,
        renderer: actionRenderer,
      ),
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 200,
      ), // Email agak lebar
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: 120,
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: statusRenderer,
      ),
      TrinaColumn(
        title: 'Account Expired',
        field: 'accountExpired',
        type: TrinaColumnType.text(),
        width: 140,
      ),
      TrinaColumn(
        title: 'Sales / Branch Id',
        field: 'salesOrBranch',
        type: TrinaColumnType.text(),
        width: 130,
      ),
      TrinaColumn(
        title: 'Created By',
        field: 'createdBy',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'Permissions',
        field: 'permissions',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'Approval Id',
        field: 'approvalId',
        type: TrinaColumnType.text(),
        width: 100,
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
          'status': TrinaCell(value: data.status),
          'accountExpired': TrinaCell(
            value: data.accountExpired == ""
                ? "Never Expired"
                : data.accountExpired,
          ), // Atasi string kosong dari API
          'salesOrBranch': TrinaCell(value: data.salesBranchId),
          'createdBy': TrinaCell(value: data.createdBy),
          'permissions': TrinaCell(value: data.permissions),
          'approvalId': TrinaCell(value: data.approvalId),
        },
      );
    }).toList();

    return AppDataGrid(columns: columns, rows: rows);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/online_id_model.dart';
import '../bloc/online_id_bloc.dart';
import '../bloc/online_id_state.dart';

class OnlineIdTableWidget extends StatelessWidget {
  const OnlineIdTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: BlocBuilder<OnlineIdBloc, OnlineIdState>(
        builder: (context, state) {
          if (state is OnlineIdLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryDark),
            );
          } else if (state is OnlineIdError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${state.message}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.destructiveRedDark),
              ),
            );
          } else if (state is OnlineIdLoaded) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada data pengguna yang ditemukan.",
                  style: TextStyle(color: AppColors.secondaryTextColorDark),
                ),
              );
            }
            return _buildTable(state.data);
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

  Widget _buildTable(List<OnlineIdModel> dataList) {
    Widget permissionRenderer(TrinaColumnRendererContext renderContext) {
      final value = renderContext.cell.value.toString();
      final bool hasPermission = value == 'Y';

      return Center(
        child: Text(
          hasPermission ? '✔️' : '❌',
          style: const TextStyle(fontSize: 14),
        ),
      );
    }

    Widget statusRenderer(TrinaColumnRendererContext renderContext) {
      final value = renderContext.cell.value.toString();
      final bool isActive = value == 'Active';
      return Text(
        value,
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      );
    }

    final List<TrinaColumn> columns = [
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 120,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 220,
      ),
      TrinaColumn(
        title: 'Email Approved At',
        field: 'approvedBy',
        type: TrinaColumnType.text(),
        width: 160,
      ),
      TrinaColumn(
        title: 'Handphone No',
        field: 'handphoneNo',
        type: TrinaColumnType.text(),
        width: 150,
      ),
      TrinaColumn(
        title: 'Handphone',
        field: 'handphone',
        type: TrinaColumnType.text(),
        width: 120,
      ),
      TrinaColumn(
        title: 'Birth Date',
        field: 'birthDate',
        type: TrinaColumnType.text(),
        width: 150,
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: 150,
      ),

      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: 150,
        renderer: statusRenderer,
      ),

      TrinaColumn(
        title: 'PWD Retry',
        field: 'errorPwdRetry',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'PIN Retry',
        field: 'errorPinRetry',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'Account Expired',
        field: 'accountExpired',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'Created At',
        field: 'created',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        title: 'Sales Or Branch',
        field: 'salesOrBranch',
        type: TrinaColumnType.text(),
        width: 150,
      ),

      TrinaColumn(
        title: 'View Only',
        field: 'viewOnly',
        type: TrinaColumnType.text(),
        width: 150,
        renderer: permissionRenderer,
      ),
      TrinaColumn(
        title: 'Syariah',
        field: 'syariah',
        type: TrinaColumnType.text(),
        width: 110,
        renderer: permissionRenderer,
      ),
      TrinaColumn(
        title: 'Delayed',
        field: 'delayed',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
      ),
      TrinaColumn(
        title: 'VIP',
        field: 'vip',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
      ),
      TrinaColumn(
        title: 'Research',
        field: 'research',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
      ),
      TrinaColumn(
        title: 'Announcement',
        field: 'announcement',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
      ),
    ];

    final List<TrinaRow> rows = dataList.map((data) {
      bool hasPermission(int bitOffset) {
        return (data.permissions & (1 << bitOffset)) != 0;
      }

      return TrinaRow(
        cells: {
          'loginId': TrinaCell(value: data.loginId),
          'email': TrinaCell(value: data.email),
          'approvedBy': TrinaCell(
            value: data.emailApprovedAt != '-'
                ? data.emailApprovedAt
                : data.approvedBy,
          ),
          'handphoneNo': TrinaCell(value: data.handphoneNo),
          'handphone': TrinaCell(value: data.handphone),
          'birthDate': TrinaCell(value: data.birthDate),
          'loginType': TrinaCell(value: _getLoginTypeName(data.loginType)),
          'status': TrinaCell(value: data.status == 1 ? 'Active' : 'Inactive'),
          'errorPinRetry': TrinaCell(value: data.errorPinRetry.toString()),
          'accountExpired': TrinaCell(value: data.accountExpired.toString()),
          'created': TrinaCell(value: data.created),
          'salesOrBranch': TrinaCell(value: data.salesId),
          'viewOnly': TrinaCell(value: hasPermission(0) ? 'Y' : 'N'),
          'syariah': TrinaCell(value: hasPermission(1) ? 'Y' : 'N'),
          'delayed': TrinaCell(value: hasPermission(2) ? 'Y' : 'N'),
          'vip': TrinaCell(value: hasPermission(3) ? 'Y' : 'N'),
          'research': TrinaCell(value: hasPermission(4) ? 'Y' : 'N'),
          'announcement': TrinaCell(value: hasPermission(5) ? 'Y' : 'N'),
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

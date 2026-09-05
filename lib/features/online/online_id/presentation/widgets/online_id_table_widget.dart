import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/online_id_model.dart';
import '../bloc/online_id_bloc.dart';
import '../bloc/online_id_state.dart';

class OnlineIdTableWidget extends StatelessWidget {
  const OnlineIdTableWidget({super.key});

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
      child: BlocConsumer<OnlineIdBloc, OnlineIdState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              final cleanMessage = message.replaceAll('Exception: ', '');

              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Theme.of(
                      context,
                    ).extension<ThemeColors>()?.appContainerBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
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
            error: (_) => _buildEmptyState(context, "Failed to load data."),
            loaded: (dataList, selectedUser) {
              if (dataList.isEmpty) {
                return _buildEmptyState(
                  context,
                  "No user data found.",
                );
              }
              return _buildTable(context, dataList);
            },
            orElse: () => _buildEmptyState(context, "Loading table data..."),
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

  Widget _buildTable(BuildContext context, List<OnlineIdModel> dataList) {
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

    // 👇 SEMUA readOnly DIUBAH MENJADI true
    final List<TrinaColumn> columns = [
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 220,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Email Approved At',
        field: 'approvedBy',
        type: TrinaColumnType.text(),
        width: 160,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Handphone No',
        field: 'handphoneNo',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Handphone',
        field: 'handphone',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Birth Date',
        field: 'birthDate',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: 150,
        renderer: statusRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'PWD Retry',
        field: 'errorPwdRetry',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'PIN Retry',
        field: 'errorPinRetry',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Account Expired',
        field: 'accountExpired',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Created At',
        field: 'created',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Sales Or Branch',
        field: 'salesOrBranch',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'View Only',
        field: 'viewOnly',
        type: TrinaColumnType.text(),
        width: 150,
        renderer: permissionRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Syariah',
        field: 'syariah',
        type: TrinaColumnType.text(),
        width: 110,
        renderer: permissionRenderer,
        readOnly: true, // Pastikan ini juga diset, sebelumnya tidak ada
      ),
      TrinaColumn(
        title: 'Delayed',
        field: 'delayed',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'VIP',
        field: 'vip',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Research',
        field: 'research',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Announcement',
        field: 'announcement',
        type: TrinaColumnType.text(),
        width: 100,
        renderer: permissionRenderer,
        readOnly: true,
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

    return AppDataGrid(
      columns: columns,
      rows: rows,
      mode: TrinaGridMode.selectWithOneTap,
      onSelected: (event) {
        final rowIndex = event.rowIdx as int?;
        if (rowIndex == null || rowIndex < 0 || rowIndex >= dataList.length) {
          return;
        }
        context.read<OnlineIdBloc>().add(
          OnlineIdEvent.selectOnlineId(dataList[rowIndex]),
        );
      },
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

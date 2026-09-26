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

class OnlineIdTableWidget extends StatefulWidget {
  const OnlineIdTableWidget({super.key});

  @override
  State<OnlineIdTableWidget> createState() => _OnlineIdTableWidgetState();
}

class _OnlineIdTableWidgetState extends State<OnlineIdTableWidget> {
  static const _loadMoreThreshold = 160.0;

  TrinaGridStateManager? _gridStateManager;
  ScrollController? _verticalScrollController;
  int _renderedRowCount = 0;

  @override
  void dispose() {
    _detachGridScrollListener();
    super.dispose();
  }

  void _onGridLoaded(TrinaGridOnLoadedEvent event) {
    _detachGridScrollListener();
    _gridStateManager = event.stateManager;
    _renderedRowCount = event.stateManager.refRows.length;
    _verticalScrollController = event.stateManager.scroll.bodyRowsVertical
      ?..addListener(_loadMoreWhenNeeded);
  }

  void _detachGridScrollListener() {
    _verticalScrollController?.removeListener(_loadMoreWhenNeeded);
    _verticalScrollController = null;
    _gridStateManager = null;
    _renderedRowCount = 0;
  }

  void _loadMoreWhenNeeded() {
    final controller = _verticalScrollController;
    if (controller == null || !controller.hasClients) return;

    final position = controller.position;
    if (position.pixels < position.maxScrollExtent - _loadMoreThreshold) {
      return;
    }
    context.read<OnlineIdBloc>().add(const OnlineIdEvent.loadMoreOnlineIds());
  }

  void _appendNewRows(List<OnlineIdModel> data) {
    final stateManager = _gridStateManager;
    if (stateManager == null || data.length <= _renderedRowCount) return;

    final rows = _buildRows(data.skip(_renderedRowCount));
    if (rows.isEmpty) return;

    stateManager.appendRows(rows);
    _renderedRowCount += rows.length;
  }

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
            loading: _detachGridScrollListener,
            loaded: (data, _, _, _) => _appendNewRows(data),
            error: (message) {
              _detachGridScrollListener();
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
            loaded: (dataList, _, isLoadingMore, _) {
              if (dataList.isEmpty) {
                return _buildEmptyState(context, "No user data found.");
              }
              return _buildTable(
                context,
                dataList,
                isLoadingMore: isLoadingMore,
              );
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

  Widget _buildTable(
    BuildContext context,
    List<OnlineIdModel> dataList, {
    required bool isLoadingMore,
  }) {
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
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Created At',
        field: 'created',
        type: TrinaColumnType.text(),
        // Reserve room for the complete API date-time value and the cell
        // padding, rather than truncating the date with an ellipsis.
        width: 180,
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
        readOnly: true, 
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

    final rows = _buildRows(dataList);

    return Stack(
      children: [
        AppDataGrid(
          columns: columns,
          rows: rows,
          mode: TrinaGridMode.selectWithOneTap,
          onLoaded: _onGridLoaded,
          onSelected: (event) {
            final rowIndex = event.rowIdx as int?;
            final currentState = context.read<OnlineIdBloc>().state;
            currentState.maybeWhen(
              loaded: (currentData, _, _, _) {
                if (rowIndex == null ||
                    rowIndex < 0 ||
                    rowIndex >= currentData.length) {
                  return;
                }
                context.read<OnlineIdBloc>().add(
                  OnlineIdEvent.selectOnlineId(currentData[rowIndex]),
                );
              },
              orElse: () {},
            );
          },
        ),
        if (isLoadingMore)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }

  List<TrinaRow> _buildRows(Iterable<OnlineIdModel> dataList) {
    return dataList.map((data) {
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

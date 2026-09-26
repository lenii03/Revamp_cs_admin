import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../domain/entities/cs_log.dart';
import '../bloc/cs_logs_bloc.dart';
import '../bloc/cs_logs_state.dart';

class CsLogsTableWidget extends StatelessWidget {
  const CsLogsTableWidget({super.key});

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
      child: BlocBuilder<CsLogsBloc, CsLogsState>(
        builder: (context, state) {
          final displayedLogs = state.logType < 0
              ? state.logs
              : state.logs
                    .where(
                      (log) => int.tryParse(log.logType) == state.logType,
                    )
                    .toList(growable: false);

          if (state.isLoading && state.logs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryDark),
            );
          } else if (state.hasError && state.logs.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: AppColors.destructiveRedDark),
              ),
            );
          } else {
            if (displayedLogs.isEmpty) {
              return const Center(
                child: Text(
                  "No logs match the selected filter.",
                  style: TextStyle(color: AppColors.secondaryTextColorDark),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return _buildLogTable(displayedLogs, constraints.maxWidth);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildLogTable(List<CsLog> logs, double maxWidth) {
    double wLoginId = maxWidth * 0.14;
    double wOnlineId = maxWidth * 0.14;
    double wLogTime = maxWidth * 0.18;
    double wApprovalId = maxWidth * 0.12;
    double wLogType = maxWidth * 0.10;

    double wDescriptions =
        maxWidth -
        (wLoginId + wOnlineId + wLogTime + wApprovalId + wLogType) -
        5;

    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Cs Login Id',
        field: 'csLoginId',
        type: TrinaColumnType.text(),
        width: wLoginId,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Online Login Id',
        field: 'onlineLoginId',
        type: TrinaColumnType.text(),
        width: wOnlineId,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Log Time',
        field: 'logTime',
        type: TrinaColumnType.text(),
        width: wLogTime,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Approval Id',
        field: 'approvalId',
        type: TrinaColumnType.text(),
        width: wApprovalId,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Log Type',
        field: 'logType',
        type: TrinaColumnType.text(),
        width: wLogType,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Descriptions',
        field: 'descriptions',
        type: TrinaColumnType.text(),
        width: wDescriptions,
        readOnly: true,
      ),
    ];

    final List<TrinaRow> rows = logs.map((log) {
      return TrinaRow(
        cells: {
          'csLoginId': TrinaCell(value: log.csLoginId),
          'onlineLoginId': TrinaCell(value: log.onlineLoginId),
          'logTime': TrinaCell(value: log.logTime),
          'approvalId': TrinaCell(value: log.approvalId),
          'logType': TrinaCell(value: log.logType),
          'descriptions': TrinaCell(value: log.descriptions),
        },
      );
    }).toList();

    // TrinaGrid owns an internal row store. Recreate it when either the
    // available width or the returned log content changes; otherwise a new
    // search can remain visually stale until the window is resized.
    final dataVersion = Object.hashAll(
      logs.map(
        (log) => Object.hash(
          log.csLoginId,
          log.onlineLoginId,
          log.logTime,
          log.approvalId,
          log.logType,
          log.descriptions,
        ),
      ),
    );
    return AppDataGrid(
      key: ValueKey('cs-logs-${maxWidth.floor()}-$dataVersion'),
      columns: columns,
      rows: rows,
    );
  }
}

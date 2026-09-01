import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/cs_log_model.dart';
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
          if (state is CsLogsLoading || state is CsLogsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryDark),
            );
          } else if (state is CsLogsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.destructiveRedDark),
              ),
            );
          } else if (state is CsLogsLoaded) { 
            if (state.logs.isEmpty) {
              return const Center(
                child: Text(
                  "No Data",
                  style: TextStyle(color: AppColors.secondaryTextColorDark),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return _buildLogTable(state.logs, constraints.maxWidth);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLogTable(List<CsLogModel> logs, double maxWidth) {
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

    return AppDataGrid(columns: columns, rows: rows);
  }
}


import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/injector.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../data/models/cs_log_model.dart';
import '../bloc/cs_logs_bloc.dart';
import '../bloc/cs_logs_event.dart';
import '../bloc/cs_logs_state.dart';

class ShowCsLogsPage extends StatefulWidget {
  const ShowCsLogsPage({super.key});

  @override
  State<ShowCsLogsPage> createState() => _ShowCsLogsPageState();
}

class _ShowCsLogsPageState extends State<ShowCsLogsPage> {
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _targetIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CsLogsBloc>()..add(FetchCsLogsEvent()),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.systemGroupedBackgroundDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.separatorDark),
                    ),
                    child: TextField(
                      controller: _loginIdController,
                      style: TextStyle(
                        color: AppColors.textColorDark,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'CS Login ID',
                        hintStyle: TextStyle(
                          color: AppColors.secondaryTextColorDark,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.textColorDark,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.systemGroupedBackgroundDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.separatorDark),
                    ),
                    child: TextField(
                      controller: _targetIdController,
                      style: TextStyle(
                        color: AppColors.textColorDark,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Target ID',
                        hintStyle: TextStyle(
                          color: AppColors.secondaryTextColorDark,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.systemGroupedBackgroundDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.separatorDark),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'Show All',
                        dropdownColor: AppColors.systemGroupedBackgroundDark,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textColorDark,
                        ),
                        style: const TextStyle(
                          color: AppColors.textColorDark,
                          fontSize: 14,
                        ),
                        items: ['Show All', 'Option 1', 'Option 2'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                ElevatedButton(
                  onPressed: () {
                    context.read<CsLogsBloc>().add(
                      FetchCsLogsEvent(
                        loginId: _loginIdController.text,
                        targetId: _targetIdController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A2A36),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColorDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.systemGroupedBackgroundDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.separatorDark),
                ),
                child: BlocBuilder<CsLogsBloc, CsLogsState>(
                  builder: (context, state) {
                    if (state is CsLogsLoading || state is CsLogsInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryDark,
                        ),
                      );
                    } else if (state is CsLogsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: AppColors.destructiveRedDark,
                          ),
                        ),
                      );
                    } else if (state is CsLogsLoaded) {
                      if (state.logs.isEmpty) {
                        return const Center(
                          child: Text(
                            "Data Kosong",
                            style: TextStyle(
                              color: AppColors.secondaryTextColorDark,
                            ),
                          ),
                        );
                      }
                      return _buildLogTable(state.logs);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogTable(List<CsLogModel> logs) {
    // 1. Definisikan Kolom
    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Cs Login Id',
        field: 'csLoginId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Online Login Id',
        field: 'onlineLoginId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Log Time',
        field: 'logTime',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Approval Id',
        field: 'approvalId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Log Type',
        field: 'logType',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Descriptions',
        field: 'descriptions',
        type: TrinaColumnType.text(),
      ),
    ];

    // 2. Definisikan Baris Data
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

    // 3. Panggil Widget Reusable
    return AppDataGrid(columns: columns, rows: rows);
  }
}

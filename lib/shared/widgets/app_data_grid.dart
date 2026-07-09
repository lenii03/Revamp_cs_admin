import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../core/theme/src/app_colors.dart';

class AppDataGrid extends StatelessWidget {
  final List<TrinaColumn> columns;
  final List<TrinaRow> rows;
  final void Function(TrinaGridOnLoadedEvent)? onLoaded;
  final void Function(int rowIndex)? onRowDoubleTap;

  const AppDataGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.onLoaded,
    this.onRowDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: TrinaGrid(
        columns: columns,
        rows: rows,
        onRowDoubleTap: onRowDoubleTap == null 
                ? null 
                : (event) {
                    onRowDoubleTap!(event.rowIdx);
                  },
        onLoaded: onLoaded,
        configuration: TrinaGridConfiguration(
          columnSize: const TrinaGridColumnSizeConfig(
            autoSizeMode: TrinaAutoSizeMode.none,
          ),
          style: TrinaGridStyleConfig.dark(
            gridBackgroundColor: AppColors.systemGroupedBackgroundDark,
            rowColor: AppColors.systemGroupedBackgroundDark,
            gridBorderColor: AppColors.separatorDark,
            borderColor: AppColors.separatorDark,
            activatedColor: AppColors.primaryDark.withValues(alpha: 0.2),
            cellTextStyle: const TextStyle(
              color: AppColors.textColorDark,
              fontSize: 13,
            ),
            columnTextStyle: const TextStyle(
              color: AppColors.textColorDark,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            menuBackgroundColor: AppColors.systemBackgroundDark,
          ),
        ),
      ),
    );
  }
}

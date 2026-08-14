import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../core/theme/src/app_colors.dart';
import '../../core/theme/theme.dart';

class AppDataGrid extends StatelessWidget {
  final List<TrinaColumn> columns;
  final List<TrinaRow> rows;
  final void Function(TrinaGridOnLoadedEvent)? onLoaded;
  final void Function(int rowIndex)? onRowDoubleTap;
  final void Function(dynamic event)? onSelected;
  final TrinaGridMode mode;

  const AppDataGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.onLoaded,
    this.onRowDoubleTap,
    this.onSelected,
    this.mode = TrinaGridMode.normal,
  });

  @override
  Widget build(BuildContext context) {
    final themePluto = Theme.of(context).extension<ThemePluto>();
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.textColorDark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: TrinaGrid(
        mode: mode,
        columns: columns,
        rows: rows,
        onRowDoubleTap: onRowDoubleTap == null
            ? null
            : (event) {
                onRowDoubleTap!(event.rowIdx);
              },
        onSelected: onSelected,
        onLoaded: onLoaded,
        configuration: TrinaGridConfiguration(
          columnSize: const TrinaGridColumnSizeConfig(
            autoSizeMode: TrinaAutoSizeMode.none,
          ),
          style: TrinaGridStyleConfig(
            gridBackgroundColor:
                themePluto?.gridBackgroundColor ??
                AppColors.systemGroupedBackgroundDark,
            rowColor:
                themePluto?.rowColor ?? AppColors.systemGroupedBackgroundDark,
            gridBorderColor:
                themePluto?.gridBorderColor ?? AppColors.separatorDark,
            borderColor: themePluto?.borderColor ?? AppColors.separatorDark,
            activatedColor:
                themePluto?.activatedColor ??
                AppColors.primaryDark.withValues(alpha: 0.2),
            menuBackgroundColor:
                themePluto?.menuBackgroundColor ??
                AppColors.systemBackgroundDark,
            iconColor: themePluto?.iconColor ?? AppColors.white,
            cellTextStyle:
                themePluto?.cellTextStyle ?? const TextStyle(fontSize: 13),
            columnTextStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

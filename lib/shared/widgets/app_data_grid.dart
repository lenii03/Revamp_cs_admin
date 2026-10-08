import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../core/theme/src/app_colors.dart';
import '../../core/theme/theme.dart';

class AppDataGrid extends StatelessWidget {
  static const double _columnHeight = 48;
  static const double _rowHeight = 52;

  final List<TrinaColumn> columns;
  final List<TrinaRow> rows;
  final void Function(TrinaGridOnLoadedEvent)? onLoaded;
  final void Function(int rowIndex)? onRowDoubleTap;
  final void Function(dynamic event)? onSelected;
  final TrinaGridMode mode;
  final bool enableHeaderTools;
  final TrinaGridSelectingMode selectingMode;
  final TrinaAutoSizeMode autoSizeMode;

  const AppDataGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.onLoaded,
    this.onRowDoubleTap,
    this.onSelected,
    this.mode = TrinaGridMode.normal,
    this.enableHeaderTools = false,
    this.selectingMode = TrinaGridSelectingMode.row,
    this.autoSizeMode = TrinaAutoSizeMode.none,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableHeaderTools) {
      for (final column in columns) {
        column.enableContextMenu = false;
        column.enableDropToResize = false;
      }
    }

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
          selectingMode: selectingMode,
          columnSize: TrinaGridColumnSizeConfig(
            // Keep useful column widths instead of compressing every label.
            // The grid provides horizontal scrolling when the content is wider.
            autoSizeMode: autoSizeMode,
          ),
          style: TrinaGridStyleConfig(
            columnHeight: _columnHeight,
            rowHeight: _rowHeight,
            gridBackgroundColor:
                themePluto?.gridBackgroundColor ??
                AppColors.systemGroupedBackgroundDark,
            rowColor:
                themePluto?.rowColor ?? AppColors.systemGroupedBackgroundDark,
            gridBorderColor:
                themePluto?.gridBorderColor ?? AppColors.separatorDark,
            borderColor: themePluto?.borderColor ?? AppColors.separatorDark,
            // A table reads more calmly with row dividers only, rather than a
            // full spreadsheet grid.
            enableColumnBorderVertical: false,
            enableColumnBorderHorizontal: true,
            enableCellBorderVertical: false,
            enableCellBorderHorizontal: true,
            enableRowHoverColor: true,
            rowHoveredColor: AppColors.primaryColor.withValues(alpha: 0.08),
            activatedColor:
                themePluto?.activatedColor ??
                AppColors.primaryDark.withValues(alpha: 0.2),
            activatedBorderColor:
                themePluto?.activatedBorderColor ?? Colors.transparent,
            menuBackgroundColor:
                themePluto?.menuBackgroundColor ??
                AppColors.systemBackgroundDark,
            iconColor: themePluto?.iconColor ?? AppColors.white,
            defaultCellPadding: const EdgeInsets.symmetric(horizontal: 14),
            cellTextStyle:
                themePluto?.cellTextStyle ?? const TextStyle(fontSize: 13),
            columnTextStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

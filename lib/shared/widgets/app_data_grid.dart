import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../core/theme/src/app_colors.dart';
import '../../core/theme/theme.dart';

class AppDataGrid extends StatelessWidget {
  static const double _columnHeight = 45;
  static const double _rowHeight = 46;

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

    final borderColor = themePluto?.borderColor ?? AppColors.separatorDark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final emptyAreaTop = _columnHeight + (rows.length * _rowHeight);
          final emptyAreaBottom = constraints.maxHeight - 16;

          return Stack(
            children: [
              TrinaGrid(
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
                autoSizeMode: TrinaAutoSizeMode.scale,
              ),
              style: TrinaGridStyleConfig(
                columnHeight: _columnHeight,
                rowHeight: _rowHeight,
                gridBackgroundColor:
                    themePluto?.gridBackgroundColor ??
                    AppColors.systemGroupedBackgroundDark,
                rowColor:
                    themePluto?.rowColor ??
                    AppColors.systemGroupedBackgroundDark,
                gridBorderColor:
                    themePluto?.gridBorderColor ?? AppColors.separatorDark,
                borderColor: borderColor,
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
              if (emptyAreaTop < emptyAreaBottom)
                Positioned(
                  top: emptyAreaTop,
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: CustomPaint(
                    painter: _EmptyRowLinesPainter(
                      firstLineY: 0,
                      rowHeight: _rowHeight,
                      color: borderColor,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyRowLinesPainter extends CustomPainter {
  final double firstLineY;
  final double rowHeight;
  final Color color;

  const _EmptyRowLinesPainter({
    required this.firstLineY,
    required this.rowHeight,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    final bottom = size.height - 16;
    for (double y = firstLineY; y < bottom; y += rowHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _EmptyRowLinesPainter oldDelegate) {
    return firstLineY != oldDelegate.firstLineY ||
        rowHeight != oldDelegate.rowHeight ||
        color != oldDelegate.color;
  }
}

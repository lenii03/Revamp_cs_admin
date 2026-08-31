import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/theme.dart';

class SendEmailForgotTableWidget extends StatelessWidget {
  final List<SendEmailForgotModel> dataList;

  const SendEmailForgotTableWidget({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeColors.appContainerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          return _buildTable(context, dataList, maxWidth);
        },
      ),
    );
  }

  Widget _buildTable(
    BuildContext context,
    List<SendEmailForgotModel> data,
    double maxWidth,
  ) {
    Widget actionRenderer(TrinaColumnRendererContext renderContext) {
      final actionType = int.tryParse(renderContext.cell.value.toString()) ?? 9;
      String text = "Unknown";
      Color textColor = Colors.grey;

      if (actionType == 1) {
        text = "PIN";
        textColor = Colors.greenAccent;
      } else if (actionType == 0) {
        text = "Password";
        textColor = Colors.orangeAccent;
      }

      return Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      );
    }

    Widget statusRenderer(TrinaColumnRendererContext renderContext) {
      final status = int.tryParse(renderContext.cell.value.toString()) ?? 9;
      String text = "Unknown";
      Color color = Colors.grey;
      IconData icon = Icons.help_outline_rounded;

      if (status == 1) {
        text = "Pending";
        color = const Color(0xFFE58A9B);
        icon = Icons.schedule_rounded;
      } else if (status == 2) {
        text = "Email Sent";
        color = const Color(0xFF22C55E);
        icon = Icons.mark_email_read_outlined;
      } else if (status == 0) {
        text = "Rejected";
        color = const Color(0xFFEF4444);
        icon = Icons.cancel_outlined;
      }

      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: color.withValues(alpha: 0.45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Renderer Login Type
    Widget loginTypeRenderer(TrinaColumnRendererContext renderContext) {
      final type = int.tryParse(renderContext.cell.value.toString()) ?? 9;
      final text = switch (type) {
        0 => 'Demo Account',
        1 => 'Client',
        2 => 'Sales',
        3 => 'Branch',
        4 => 'CS View All Account',
        5 => 'CS Branch',
        _ => 'Tipe Lain ($type)',
      };
      return Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 13,
        ),
      );
    }

    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Action',
        field: 'actionType',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.12,
        renderer: actionRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.18,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.38,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.16,
        renderer: loginTypeRenderer,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.16,
        renderer: statusRenderer,
        readOnly: true,
      ),
    ];

    final List<TrinaRow> rows = data.map((item) {
      return TrinaRow(
        cells: {
          'actionType': TrinaCell(value: item.actionType),
          'loginId': TrinaCell(value: item.loginId),
          'email': TrinaCell(value: item.email),
          'loginType': TrinaCell(value: item.loginType),
          'status': TrinaCell(value: item.status),
        },
      );
    }).toList();

    return AppDataGrid(
      key: ValueKey(
        data
            .map((item) => '${item.loginId}:${item.actionType}:${item.status}')
            .join('|'),
      ),
      columns: columns,
      rows: rows,
    );
  }
}

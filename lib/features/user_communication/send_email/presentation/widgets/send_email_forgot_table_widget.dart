import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_bloc.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_event.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';

class SendEmailForgotTableWidget extends StatelessWidget {
  final List<SendEmailForgotModel> dataList;

  const SendEmailForgotTableWidget({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          return _buildTable(context, dataList, maxWidth);
        },
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext pageContext,
    SendEmailForgotModel data,
  ) {
    if (data.status == 2) return;
    final actionName = data.actionType.toString() == '1' ? "PIN" : "Password";

    showDialog(
      context: pageContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.systemGroupedBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ikon Peringatan Kuning
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.priority_high,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),

              // Judul
              Text(
                "Send Email Forgot $actionName",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Are you sure want to send email forgot $actionName\n[LoginId : ${data.loginId} & Email: ${data.email}]?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.secondaryTextColorDark,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Action
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Cancel
                  OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryDark),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 16),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      final index = dataList.indexOf(data);
                      pageContext.read<SendEmailForgotBloc>().add(
                        SubmitSendEmail(data: data, index: index),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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

    // 2. Renderer Kotak Status (0 = Rejected, 1 = Pending, 2 = Email Send)
    Widget statusRenderer(TrinaColumnRendererContext renderContext) {
      final status = int.tryParse(renderContext.cell.value.toString()) ?? 9;
      String text = "Unknown";
      Color bgColor = Colors.grey.shade600;

      if (status == 1) {
        text = "Pending";
        bgColor = const Color(0xFFC08080);
      } else if (status == 2) {
        text = "Email Send";
        bgColor = const Color(0xFF4CAF50);
      } else if (status == 0) {
        text = "Rejected";
        bgColor = Colors.redAccent;
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
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
        style: const TextStyle(color: Colors.white, fontSize: 13),
      );
    }

    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Action',
        field: 'actionType',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.12,
        renderer: actionRenderer,
      ),
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.18,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.38,
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.16,
        renderer: loginTypeRenderer,
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: maxWidth * 0.16,
        renderer: statusRenderer,
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
      onRowDoubleTap: (index) {
        final selectedData = data[index];
        _showConfirmationDialog(context, selectedData);
      },
    );
  }
}

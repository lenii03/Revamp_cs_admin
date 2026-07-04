import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

class SendEmailForgotPage extends StatefulWidget {
  const SendEmailForgotPage({super.key});

  @override
  State<SendEmailForgotPage> createState() => _SendEmailForgotPageState();
}

class _SendEmailForgotPageState extends State<SendEmailForgotPage> {
  // Data Dummy untuk preview UI
  final List<SendEmailForgotModel> _dummyData = [
    SendEmailForgotModel(
      action: 'PIN',
      loginId: 'Hidayat',
      email: 'dayatburgerkill389@gmail.com',
      loginType: 'Client',
      status: 'Pending',
    ),
    SendEmailForgotModel(
      action: 'Password',
      loginId: 'A007',
      email: 'dalamsyah09@gmail.com',
      loginType: 'Client',
      status: 'Pending',
    ),
    SendEmailForgotModel(
      action: 'PIN',
      loginId: 'Hidayat',
      email: 'dayatburgerkill389@gmail.com',
      loginType: 'Client',
      status: 'Pending',
    ),
    SendEmailForgotModel(
      action: 'Password',
      loginId: 'Hidayat',
      email: 'dayatburgerkill389@gmail.com',
      loginType: 'Client',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE HEADER
          const Text(
            "Send Email Forgot PIN & Password",
            style: TextStyle(
              color: AppColors.textColorDark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // TABEL DATA
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.systemGroupedBackgroundDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.separatorDark),
              ),
              child: _buildTable(_dummyData),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET PEMBANTU TABEL
  Widget _buildTable(List<SendEmailForgotModel> dataList) {
    // 1. Renderer Warna Teks Action
    Widget actionRenderer(TrinaColumnRendererContext renderContext) {
      final action = renderContext.cell.value.toString();
      Color textColor = Colors.white;

      if (action.toLowerCase() == 'pin')
        textColor = Colors.greenAccent;
      else if (action.toLowerCase() == 'password')
        textColor = Colors.orangeAccent;

      return Text(
        action,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      );
    }

    // 2. Renderer Kotak Status
    Widget statusRenderer(TrinaColumnRendererContext renderContext) {
      final status = renderContext.cell.value.toString();
      Color bgColor = Colors.grey.shade600;

      if (status.toLowerCase() == 'pending')
        bgColor = const Color(0xFFC08080); // Warna kecoklatan/merah pudar

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    // 3. Definisi Kolom
    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Action',
        field: 'action',
        type: TrinaColumnType.text(),
        width: 120,
        renderer: actionRenderer,
      ),
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 150,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 250,
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
        width: 150,
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
        width: 150,
        renderer: statusRenderer,
      ),
    ];

    // 4. Mapping Baris Data
    final List<TrinaRow> rows = dataList.map((data) {
      return TrinaRow(
        cells: {
          'action': TrinaCell(value: data.action),
          'loginId': TrinaCell(value: data.loginId),
          'email': TrinaCell(value: data.email),
          'loginType': TrinaCell(value: data.loginType),
          'status': TrinaCell(value: data.status),
        },
      );
    }).toList();

    return AppDataGrid(columns: columns, rows: rows);
  }
}


import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/report_send_pwd_pin_model.dart';

class ReportSendPwdPinPage extends StatefulWidget {
  const ReportSendPwdPinPage({super.key});

  @override
  State<ReportSendPwdPinPage> createState() => _ReportSendPwdPinPageState();
}

class _ReportSendPwdPinPageState extends State<ReportSendPwdPinPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedYear = '2026';
  String _selectedMonth = 'Show All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. TITLE & PRINT ICON ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Report Reset Password dan PIN code",
                style: TextStyle(
                  color: AppColors.textColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.print, color: AppColors.primaryDark),
                tooltip: 'Print Report',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryDark.withValues(alpha: 0.1),
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- 2. FILTERS (YEAR, MONTH, SEARCH) ---
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _buildFilterContainer(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedYear,
                      isExpanded: true,
                      dropdownColor: AppColors.systemGroupedBackgroundDark,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.textColorDark,
                      ),
                      style: const TextStyle(
                        color: AppColors.textColorDark,
                        fontSize: 14,
                      ),
                      items: ['2024', '2025', '2026'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) =>
                          setState(() => _selectedYear = newValue!),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: _buildFilterContainer(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedMonth,
                      isExpanded: true,
                      dropdownColor: AppColors.systemGroupedBackgroundDark,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.textColorDark,
                      ),
                      style: const TextStyle(
                        color: AppColors.textColorDark,
                        fontSize: 14,
                      ),
                      items:
                          [
                            'Show All',
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (newValue) =>
                          setState(() => _selectedMonth = newValue!),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: _buildFilterContainer(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      color: AppColors.textColorDark,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search...',
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
              const Spacer(flex: 3),
            ],
          ),
          const SizedBox(height: 24),

          // --- 3. DATA TABLE ---
          Expanded(
            child: _buildTable([]), // Sementara list kosong
          ),
        ],
      ),
    );
  }

  // --- WIDGET PEMBANTU ---
  Widget _buildFilterContainer({required Widget child}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: child,
    );
  }

  Widget _buildTable(List<ReportSendPwdPinModel> dataList) {
    // 1. Definisikan Kolom
    final List<TrinaColumn> columns = [
      TrinaColumn(title: 'No', field: 'no', type: TrinaColumnType.text()),
      TrinaColumn(
        title: 'Client Code',
        field: 'clientCode',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Client Name',
        field: 'clientName',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Create By',
        field: 'createBy',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Create Date',
        field: 'createDate',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Approve By',
        field: 'approveBy',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Approve Date',
        field: 'approveDate',
        type: TrinaColumnType.text(),
      ),
    ];

    // 2. Definisikan Baris
    final List<TrinaRow> rows = dataList.map((data) {
      return TrinaRow(
        cells: {
          'no': TrinaCell(value: data.no),
          'clientCode': TrinaCell(value: data.clientCode),
          'clientName': TrinaCell(value: data.clientName),
          'createBy': TrinaCell(value: data.createBy),
          'createDate': TrinaCell(value: data.createDate),
          'approveBy': TrinaCell(value: data.approveBy),
          'approveDate': TrinaCell(value: data.approveDate),
        },
      );
    }).toList();

    // 3. Panggil Widget Reusable
    return AppDataGrid(columns: columns, rows: rows);
  }
}

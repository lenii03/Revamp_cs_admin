import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../../data/models/reset_password_report_model.dart';

class ResetPasswordReportPage extends StatefulWidget {
  const ResetPasswordReportPage({super.key});

  @override
  State<ResetPasswordReportPage> createState() =>
      _ResetPasswordReportPageState();
}

class _ResetPasswordReportPageState extends State<ResetPasswordReportPage> {
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
                "Reset Password Report",
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
                  backgroundColor: AppColors.primaryDark.withOpacity(0.1),
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- 2. FILTERS (YEAR, MONTH, SEARCH) ---
          Row(
            children: [
              // Filter Year
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

              // Filter Month
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

              // Search Input
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
              const Spacer(
                flex: 3,
              ), // Agar filter tidak melebar penuh sampai kanan
            ],
          ),
          const SizedBox(height: 24),

          // --- 3. DATA TABLE ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.systemGroupedBackgroundDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.separatorDark),
              ),
              // SEMENTARA MENGGUNAKAN LIST KOSONG SAMPAI BLOC DIBUAT
              child: _buildTable([]),
            ),
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

  Widget _buildTable(List<ResetPasswordReportModel> dataList) {
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
        title: 'Request Date',
        field: 'requestDate',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Reason',
        field: 'reason',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Validation 1',
        field: 'validation1',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Validation 2',
        field: 'validation2',
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
          'requestDate': TrinaCell(value: data.requestDate),
          'reason': TrinaCell(value: data.reason),
          'validation1': TrinaCell(value: data.validation1),
          'validation2': TrinaCell(value: data.validation2),
          'approveBy': TrinaCell(value: data.approveBy),
          'approveDate': TrinaCell(value: data.approveDate),
        },
      );
    }).toList();

    // 3. Panggil Widget Reusable (Bersih dari logic warna/tema!)
    return AppDataGrid(columns: columns, rows: rows);
  }
}

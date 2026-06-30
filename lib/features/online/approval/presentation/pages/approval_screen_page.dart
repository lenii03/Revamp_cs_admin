
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../injector.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/approval_screen_model.dart';
import '../bloc/approval_bloc.dart';
import '../bloc/approval_event.dart';
import '../bloc/approval_state.dart';

class ApprovalScreenPage extends StatefulWidget {
  const ApprovalScreenPage({super.key});

  @override
  State<ApprovalScreenPage> createState() => _ApprovalScreenPageState();
}

class _ApprovalScreenPageState extends State<ApprovalScreenPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedAction = 'Add';
  String _selectedStatus = 'Show All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Membungkus halaman dengan BlocProvider agar event Fetch berjalan saat halaman dibuka
    return BlocProvider(
      create: (context) =>
          locator<ApprovalScreenBloc>()..add(FetchApprovalsEvent()),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HEADER: FILTERS ---
            Row(
              children: [
                // Search Bar
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
                const SizedBox(width: 16),

                // Action Dropdown
                Expanded(
                  flex: 2,
                  child: _buildFilterContainer(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedAction,
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
                        items: ['Add', 'Edit', 'Delete'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() => _selectedAction = newValue!);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Status Dropdown
                Expanded(
                  flex: 2,
                  child: _buildFilterContainer(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStatus,
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
                        items: ['Show All', 'Approved', 'Rejected'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() => _selectedStatus = newValue!);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- 2. DATA TABLE WITH BLOC BUILDER ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.systemGroupedBackgroundDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.separatorDark),
                ),
                child: BlocBuilder<ApprovalScreenBloc, ApprovalScreenState>(
                  builder: (context, state) {
                    if (state is ApprovalScreenLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryDark,
                        ),
                      );
                    } else if (state is ApprovalScreenError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: AppColors.destructiveRedDark,
                          ),
                        ),
                      );
                    } else if (state is ApprovalScreenLoaded) {
                      return _buildTable(state.data);
                    }
                    return _buildTable([]); // Tampilan awal kosong
                  },
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildTable(List<ApprovalScreenModel> dataList) {
    // 1. Definisikan Kolom
    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Action',
        field: 'action',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(title: 'Email', field: 'email', type: TrinaColumnType.text()),
      TrinaColumn(
        title: 'Login Type',
        field: 'loginType',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Account Expired',
        field: 'accountExpired',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Sales / Branch Id',
        field: 'salesBranchId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Created By',
        field: 'createdBy',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Permissions',
        field: 'permissions',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'ApprovalId',
        field: 'approvalId',
        type: TrinaColumnType.text(),
      ),
    ];

    // 2. Definisikan Baris
    final List<TrinaRow> rows = dataList.map((data) {
      return TrinaRow(
        cells: {
          'action': TrinaCell(value: data.action),
          'loginId': TrinaCell(value: data.loginId),
          'email': TrinaCell(value: data.email),
          'loginType': TrinaCell(value: data.loginType),
          'status': TrinaCell(value: data.status),
          'accountExpired': TrinaCell(value: data.accountExpired),
          'salesBranchId': TrinaCell(value: data.salesBranchId),
          'createdBy': TrinaCell(value: data.createdBy),
          'permissions': TrinaCell(value: data.permissions),
          'approvalId': TrinaCell(value: data.approvalId),
        },
      );
    }).toList();

    // 3. Panggil Widget Reusable
    return AppDataGrid(columns: columns, rows: rows);
  }
}

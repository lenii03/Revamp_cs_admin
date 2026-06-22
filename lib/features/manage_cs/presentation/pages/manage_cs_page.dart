import 'package:el_csadmin/injector.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../data/models/cs_user_model.dart';
import '../bloc/manage_cs_bloc.dart';
import '../bloc/manage_cs_event.dart';
import '../bloc/manage_cs_state.dart';

class ManageCsPage extends StatelessWidget {
  const ManageCsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ManageCsBloc>()..add(FetchCsList()),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.systemGroupedBackgroundDark,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.separatorDark),
                  ),
                  child: const TextField(
                    style: TextStyle(
                      color: AppColors.textColorDark,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: AppColors.secondaryTextColorDark,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.secondaryTextColorDark,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.textColorDark,
                    size: 20,
                  ),
                  label: const Text(
                    "Add New User",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColorDark,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.systemGroupedBackgroundDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.separatorDark),
                ),
                child: BlocBuilder<ManageCsBloc, ManageCsState>(
                  builder: (context, state) {
                    if (state is ManageCsLoading || state is ManageCsInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryDark,
                        ),
                      );
                    } else if (state is ManageCsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: AppColors.destructiveRedDark,
                          ),
                        ),
                      );
                    } else if (state is ManageCsLoaded) {
                      if (state.csUsers.isEmpty) {
                        return const Center(
                          child: Text(
                            "Data Kosong",
                            style: TextStyle(
                              color: AppColors.secondaryTextColorDark,
                            ),
                          ),
                        );
                      }
                      return _buildDataTable(state.csUsers);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(List<CsUserModel> dataList) {
    // 1. Definisikan Kolom
    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'LoginId',
        field: 'loginId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Employee Id',
        field: 'employeeId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(title: 'Email', field: 'email', type: TrinaColumnType.text()),
      TrinaColumn(
        title: 'Active',
        field: 'isActive',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(title: 'CS', field: 'isCs', type: TrinaColumnType.text()),
      TrinaColumn(
        title: 'Online',
        field: 'isOnline',
        type: TrinaColumnType.text(),
      ),
      // Kolom aksi sementara menggunakan teks
      TrinaColumn(
        title: 'Action',
        field: 'action',
        type: TrinaColumnType.text(),
      ),
    ];

    // 2. Definisikan Baris Data
    final List<TrinaRow> rows = dataList.map((csUser) {
      return TrinaRow(
        cells: {
          'loginId': TrinaCell(value: csUser.loginId),
          'employeeId': TrinaCell(value: csUser.employeeId),
          'email': TrinaCell(value: csUser.email),
          // Mengubah boolean menjadi String agar kompatibel dengan TrinaColumnType.text
          'isActive': TrinaCell(value: csUser.isActive ? 'Yes' : 'No'),
          'isCs': TrinaCell(value: csUser.isCs ? 'Yes' : 'No'),
          'isOnline': TrinaCell(value: csUser.isOnline ? 'Yes' : 'No'),
          'action': TrinaCell(value: 'Edit/Delete'), // Placeholder untuk tombol
        },
      );
    }).toList();

    // 3. Panggil Widget Reusable
    return AppDataGrid(columns: columns, rows: rows);
  }
}

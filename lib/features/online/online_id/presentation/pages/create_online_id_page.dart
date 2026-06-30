import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/injector.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../data/models/online_id_model.dart';
import '../bloc/online_id_bloc.dart';
import '../bloc/online_id_event.dart';
import '../bloc/online_id_state.dart';

class CreateOnlineIdPage extends StatefulWidget {
  const CreateOnlineIdPage({super.key});

  @override
  State<CreateOnlineIdPage> createState() => _CreateOnlineIdPageState();
}

class _CreateOnlineIdPageState extends State<CreateOnlineIdPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kita bungkus dengan BlocProvider untuk menyediakan BLoC dan memicu Event Fetch
    return BlocProvider(
      create: (context) => locator<OnlineIdBloc>()..add(FetchOnlineIdsEvent()),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HEADER: SEARCH & PRINT ICON ---
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.systemGroupedBackgroundDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.separatorDark),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: AppColors.textColorDark,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search Login ID / Email...',
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
                const Spacer(flex: 5),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.print, color: AppColors.textColorDark),
                  tooltip: 'Print Data',
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
                // BlocBuilder untuk mendengarkan perubahan State
                child: BlocBuilder<OnlineIdBloc, OnlineIdState>(
                  builder: (context, state) {
                    if (state is OnlineIdLoading) {
                      // Tampilkan loading spinner saat mengambil data
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryDark,
                        ),
                      );
                    } else if (state is OnlineIdError) {
                      // Tampilkan pesan error jika gagal
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: AppColors.destructiveRedDark,
                          ),
                        ),
                      );
                    } else if (state is OnlineIdLoaded) {
                      // Tampilkan tabel jika data sukses dimuat
                      return _buildTable(state.data);
                    }

                    // Initial State (kosong)
                    return _buildTable([]);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- 3. ACTION BUTTONS ---
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: [
                _buildActionButton("Add", Icons.add, isPrimary: true),
                _buildActionButton("Edit", Icons.edit),
                _buildActionButton("Delete", Icons.delete, isDestructive: true),
                _buildActionButton("Reset Password", Icons.lock_reset),
                _buildActionButton("Reset PIN", Icons.pin),
                _buildActionButton("Link Account", Icons.link, isPrimary: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET PEMBANTU ---

  Widget _buildTable(List<OnlineIdModel> dataList) {
    // 1. Definisikan Kolom
    final List<TrinaColumn> columns = [
      TrinaColumn(
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(title: 'Email', field: 'email', type: TrinaColumnType.text()),
      TrinaColumn(
        title: 'Email Approved At',
        field: 'approvedAt',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Handphone No',
        field: 'hp',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Birth Date',
        field: 'birth',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Login Type',
        field: 'type',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Status',
        field: 'status',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'PWD Retry',
        field: 'pwdRetry',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'PIN Retry',
        field: 'pinRetry',
        type: TrinaColumnType.text(),
      ),
    ];

    // 2. Definisikan Baris
    final List<TrinaRow> rows = dataList.map((data) {
      return TrinaRow(
        cells: {
          'loginId': TrinaCell(value: data.loginId),
          'email': TrinaCell(value: data.email),
          'approvedAt': TrinaCell(value: data.approvedAt),
          'hp': TrinaCell(value: data.hp),
          'birth': TrinaCell(value: data.birth),
          'type': TrinaCell(value: data.type),
          'status': TrinaCell(value: data.status),
          'pwdRetry': TrinaCell(value: data.pwdRetry),
          'pinRetry': TrinaCell(value: data.pinRetry),
        },
      );
    }).toList();

    // 3. Panggil Widget Reusable
    return AppDataGrid(columns: columns, rows: rows);
  }

  Widget _buildActionButton(
    String title,
    IconData icon, {
    bool isPrimary = false,
    bool isDestructive = false,
  }) {
    Color bgColor = const Color(0xFF2A2A36);
    Color textColor = AppColors.textColorDark;

    if (isPrimary) {
      bgColor = AppColors.primaryDark;
      textColor = Colors.white;
    } else if (isDestructive) {
      bgColor = AppColors.destructiveRedDark.withValues(alpha: 0.2);
      textColor = AppColors.destructiveRedDark;
    }

    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: textColor, size: 18),
      label: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }
}

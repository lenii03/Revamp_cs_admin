import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../injector.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/approve_opening_account_model.dart';
import '../bloc/approve_opening_bloc.dart';
import '../bloc/approve_opening_event.dart';

class AddOpeningAccountDialog extends StatefulWidget {
  final ApproveOpeningBloc parentBloc;
  const AddOpeningAccountDialog({super.key, required this.parentBloc});

  @override
  State<AddOpeningAccountDialog> createState() =>
      _AddOpeningAccountDialogState();
}

class _AddOpeningAccountDialogState extends State<AddOpeningAccountDialog> {
  List<ApproveOpeningAccountModel> _apiResults = [];
  List<ApproveOpeningAccountModel> _filteredResults = [];
  bool _isLoading = false;
  ApproveOpeningAccountModel? _selectedAccount;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    final result = await locator<ApiDatafeedRepository>()
        .fetchOpeningAccounts();
    result.fold(
      (error) => debugPrint("Error: $error"),
      (data) => setState(() {
        _apiResults = data;
        _filteredResults = data;
      }),
    );
    setState(() => _isLoading = false);
  }

  void _runFilter(String enteredKeyword) {
    List<ApproveOpeningAccountModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _apiResults;
    } else {
      results = _apiResults.where((item) {
        final searchLower = enteredKeyword.toLowerCase();
        return item.loginId.toLowerCase().contains(searchLower) ||
            item.custId.toLowerCase().contains(searchLower) ||
            item.name.toLowerCase().contains(searchLower);
      }).toList();
    }

    setState(() {
      _filteredResults = results;
      _selectedAccount = null;
    });
  }

  Widget _buildDialogTable() {
    final List<TrinaColumn> columns = [
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 100,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Account Id',
        field: 'custId',
        type: TrinaColumnType.text(),
        width: 120,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Name',
        field: 'name',
        type: TrinaColumnType.text(),
        width: 200,
      ),
      TrinaColumn(
        title: 'RDN Account',
        field: 'rdnAccount',
        type: TrinaColumnType.text(),
        width: 150,
      ),
      TrinaColumn(
        title: 'RDN Bank',
        field: 'rdnBank',
        type: TrinaColumnType.text(),
        width: 120,
      ),
      TrinaColumn(
        title: 'Investor No',
        field: 'investorNo',
        type: TrinaColumnType.text(),
        width: 150,
      ),
      TrinaColumn(
        title: 'KSEI Id',
        field: 'kseiId',
        type: TrinaColumnType.text(),
        width: 120,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 200,
      ),
    ];

    final List<TrinaRow> rows = _filteredResults.map((item) {
      return TrinaRow(
        cells: {
          'loginId': TrinaCell(value: item.loginId),
          'custId': TrinaCell(value: item.custId),
          'name': TrinaCell(value: item.name),
          'rdnAccount': TrinaCell(value: item.rdnAccount),
          'rdnBank': TrinaCell(value: item.rdnBank),
          'investorNo': TrinaCell(value: item.investorNo),
          'kseiId': TrinaCell(value: item.kseiId),
          'email': TrinaCell(value: item.email),
        },
      );
    }).toList();

    return AppDataGrid(
      mode: TrinaGridMode.selectWithOneTap,
      columns: columns,
      rows: rows,
      onSelected: (event) {
        try {
          final String clickedLoginId =
              event.row.cells['loginId']?.value.toString() ?? '';
          setState(() {
            _selectedAccount = _filteredResults.firstWhere(
              (acc) => acc.loginId == clickedLoginId,
            );
          });
        } catch (e) {
          debugPrint("❌ ERROR SAAT KLIK BARIS: $e");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 👇 Ambil tema dinamis
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBgColor = isDark
        ? AppColors.systemGroupedBackgroundDark
        : AppColors.white;
    final textColor = isDark ? Colors.white : AppColors.black;
    final hintColor = isDark ? Colors.white54 : Colors.black54;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.lighterGrey;

    return Dialog(
      backgroundColor: dialogBgColor, // 👈 Dinamis
      surfaceTintColor: Colors.transparent, // 👈 Bersihkan bias warna M3
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 900,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Opening Account",
                  style: TextStyle(
                    color: textColor, // 👈 Dinamis
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.destructiveRedDark,
                  ), // Merah agar terlihat
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              style: TextStyle(color: textColor), // 👈 Dinamis
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: "Search Account ID or Name",
                hintStyle: TextStyle(color: hintColor), // 👈 Dinamis
                suffixIcon: Icon(Icons.search, color: hintColor), // 👈 Dinamis
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: separatorColor), // 👈 Dinamis
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ), // 👈 Seragam Cyan
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor, // 👈 Seragam Cyan
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: separatorColor), // 👈 Dinamis
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _buildDialogTable(),
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Close",
                    style: TextStyle(color: hintColor), // 👈 Dinamis
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedAccount != null) {
                      widget.parentBloc.add(AddToStaging(_selectedAccount!));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Silakan pilih akun terlebih dahulu"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // 👈 Seragam Cyan
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

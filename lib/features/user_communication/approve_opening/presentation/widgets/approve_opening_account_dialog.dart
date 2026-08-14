import 'package:flutter/material.dart';
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
  List<ApproveOpeningAccountModel> _suggestions = [];
  ApproveOpeningAccountModel? _selectedAccount;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final result = await locator<ApiDatafeedRepository>()
        .fetchOpeningAccountSuggestions();
    if (!mounted) return;
    result.fold(
      (error) => debugPrint('Suggestion error: $error'),
      (data) => setState(() => _suggestions = data),
    );
  }

  Future<void> _selectSuggestion(ApproveOpeningAccountModel suggestion) async {
    final result = await locator<ApiDatafeedRepository>().fetchOpeningAccounts(
      size: 30,
      custId: suggestion.custId,
      loginId: suggestion.loginId,
    );
    if (!mounted) return;
    result.fold(
      (error) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load accounts: $error'))),
      (data) => setState(() {
        _filteredResults = data;
        _selectedAccount = data.isNotEmpty ? data.first : null;
      }),
    );
  }

  Future<void> _fetchData() async {
    final cachedData = widget.parentBloc.apiAccountsList;

    if (cachedData.isNotEmpty) {
      setState(() {
        _apiResults = List.from(cachedData);
        _filteredResults = List.from(cachedData);
      });
      return;
    }

    final result = await locator<ApiDatafeedRepository>().fetchOpeningAccounts(
      size: 30,
    );
    if (!mounted) return;
    result.fold(
      (error) => debugPrint("Error: $error"),
      (data) => setState(() {
        widget.parentBloc.apiAccountsList = data;
        _apiResults = data;
        _filteredResults = data;
      }),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ApproveOpeningAccountModel> results = [];
    final keyword = enteredKeyword.trim();
    if (keyword.isEmpty) {
      results = _apiResults;
    } else if (keyword.contains(' - ')) {
      final parts = keyword.split(' - ');
      final custId = parts.first.trim().toLowerCase();
      final loginId = parts.skip(1).join(' - ').trim().toLowerCase();
      results = _apiResults.where((item) {
        return item.custId.toLowerCase() == custId &&
            item.loginId.toLowerCase() == loginId;
      }).toList();
    } else {
      results = _apiResults.where((item) {
        final searchLower = keyword.toLowerCase();
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
        readOnly: true,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Account Id',
        field: 'custId',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Name',
        field: 'name',
        type: TrinaColumnType.text(),
        width: 200,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'RDN Account',
        field: 'rdnAccount',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'RDN Bank',
        field: 'rdnBank',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Investor No',
        field: 'investorNo',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'KSEI Id',
        field: 'kseiId',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 200,
        readOnly: true,
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
          final String clickedCustId =
              event.row.cells['custId']?.value.toString() ?? '';
          setState(() {
            _selectedAccount = _filteredResults.firstWhere(
              (acc) =>
                  acc.loginId == clickedLoginId && acc.custId == clickedCustId,
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
            Autocomplete<ApproveOpeningAccountModel>(
              displayStringForOption: (item) =>
                  '${item.custId} - ${item.loginId}',
              optionsBuilder: (textEditingValue) {
                final query = textEditingValue.text.trim().toLowerCase();
                if (query.isEmpty) {
                  return const Iterable<ApproveOpeningAccountModel>.empty();
                }
                return _suggestions.where(
                  (item) =>
                      item.custId.toLowerCase().contains(query) ||
                      item.loginId.toLowerCase().contains(query) ||
                      item.name.toLowerCase().contains(query),
                );
              },
              onSelected: _selectSuggestion,
              fieldViewBuilder:
                  (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      style: TextStyle(color: textColor),
                      onChanged: _runFilter,
                      onSubmitted: (_) => onFieldSubmitted(),
                      decoration: InputDecoration(
                        hintText: "Search Account ID, Login ID, or Name",
                        hintStyle: TextStyle(color: hintColor),
                        suffixIcon: Icon(Icons.search, color: hintColor),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: separatorColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 8,
                    color: dialogBgColor,
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 240,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final item = options.elementAt(index);
                          return ListTile(
                            dense: true,
                            title: Text(
                              '${item.custId} - ${item.loginId}',
                              style: TextStyle(color: textColor),
                            ),
                            subtitle: Text(
                              item.name,
                              style: TextStyle(color: hintColor),
                            ),
                            onTap: () => onSelected(item),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: separatorColor),
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
                    final selected = _selectedAccount;
                    if (selected == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an account first"),
                        ),
                      );
                      return;
                    }

                    if (widget.parentBloc.isStaged(selected)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "This Login ID and Account ID have already been added",
                          ),
                        ),
                      );
                      return;
                    }

                    widget.parentBloc.add(AddToStaging(selected));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${selected.loginId} - ${selected.custId} added successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
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

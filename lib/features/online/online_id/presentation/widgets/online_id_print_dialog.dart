import 'dart:typed_data';

import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/online/online_id/data/repositories/online_id_repository.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class OnlineIdPrintDialog extends StatefulWidget {
  final OnlineIdRepository repository;

  const OnlineIdPrintDialog({super.key, required this.repository});

  @override
  State<OnlineIdPrintDialog> createState() => _OnlineIdPrintDialogState();
}

class _OnlineIdPrintDialogState extends State<OnlineIdPrintDialog> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = TextEditingController(text: '1');
  final _perPageController = TextEditingController(text: '30');
  final _searchController = TextEditingController();
  List<OnlineIdModel> _searchOptions = const [];
  bool _isLoadingSearchOptions = true;
  bool _isPrinting = false;
  bool _printAll = false;

  @override
  void initState() {
    super.initState();
    _loadSearchOptions();
  }

  Future<void> _loadSearchOptions() async {
    final result = await widget.repository.fetchOnlineIds(page: 1, size: 1000);
    if (!mounted) return;
    result.fold(
      (_) => setState(() => _isLoadingSearchOptions = false),
      (data) => setState(() {
        _searchOptions = data;
        _isLoadingSearchOptions = false;
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _perPageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _print() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isPrinting = true);
    final page = _printAll ? 1 : int.parse(_pageController.text);
    final perPage = _printAll ? 100 : int.parse(_perPageController.text);
    final search = _searchController.text.trim();
    final result = _printAll
        ? await _fetchAllOnlineIds(search)
        : await _fetchOnlineIdsPage(page, perPage, search);

    if (!mounted) return;
    if (result.error != null) {
      setState(() => _isPrinting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve print data: ${result.error}'),
          backgroundColor: AppColors.destructiveRedDark,
        ),
      );
      return;
    }

    final data = result.data;
    if (data.isEmpty) {
      setState(() => _isPrinting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data available to print.')),
      );
      return;
    }

    try {
      final navigator = Navigator.of(context);
      setState(() => _isPrinting = false);
      navigator.pop();
      await showDialog<void>(
        context: navigator.context,
        barrierDismissible: false,
        builder: (_) => _OnlineIdPdfPreviewDialog(
          fileName: _printAll
              ? 'All_Online_Users.pdf'
              : 'Online_User_Page_$page.pdf',
          buildPdf: (pageFormat) => _buildPdf(
            data,
            page,
            perPage,
            search,
            pageFormat,
            printAll: _printAll,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _isPrinting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create PDF preview: $error'),
          backgroundColor: AppColors.destructiveRedDark,
        ),
      );
    }
  }

  Future<({String? error, List<OnlineIdModel> data})> _fetchOnlineIdsPage(
    int page,
    int perPage,
    String search,
  ) async {
    String? error;
    List<OnlineIdModel> data = const [];
    final result = await widget.repository.fetchOnlineIds(
      page: page,
      size: perPage,
      search: search,
    );
    result.fold((value) => error = value, (value) => data = value);
    return (error: error, data: data);
  }

  Future<({String? error, List<OnlineIdModel> data})> _fetchAllOnlineIds(
    String search,
  ) async {
    const batchSize = 100;
    const maximumPages = 1000;
    final allData = <OnlineIdModel>[];
    final collectedLoginIds = <String>{};

    for (var page = 1; page <= maximumPages; page++) {
      final result = await _fetchOnlineIdsPage(page, batchSize, search);
      if (result.error != null) return result;
      if (result.data.isEmpty) return (error: null, data: allData);

      final newData = result.data
          .where((item) => collectedLoginIds.add(item.loginId))
          .toList();
      allData.addAll(newData);
      if (result.data.isNotEmpty && newData.isEmpty) {
        return (error: null, data: allData);
      }
    }

    return (
      error: 'The print limit was reached. Please use a search filter.',
      data: allData,
    );
  }

  Future<Uint8List> _buildPdf(
    List<OnlineIdModel> data,
    int page,
    int perPage,
    String search,
    PdfPageFormat pageFormat, {
    required bool printAll,
  }) async {
    final document = pw.Document();
    final createdBy = locator<SessionService>().read(SessionKey.loginId);
    document.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        margin: const pw.EdgeInsets.all(24),
        header: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Online User Report',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Search: ${search.isEmpty ? '-' : search}    '
              'Created By: ${createdBy.isEmpty ? 'admin' : createdBy}    '
              '${printAll ? 'Scope: All Data (${data.length} records)' : 'Page: $page    Per Page: $perPage'}',
              style: const pw.TextStyle(fontSize: 9),
            ),
            pw.SizedBox(height: 12),
          ],
        ),
        build: (_) => [
          _buildPermissionLegend(),
          pw.SizedBox(height: 14),
          pw.TableHelper.fromTextArray(
            headers: const [
              'Login ID',
              'Email',
              'Login Type',
              'Status',
              'PWD Retry',
              'PIN Retry',
              'Account Expired',
              'Created At',
              'Sales / Branch',
              'Permissions',
            ],
            data: data
                .map(
                  (item) => [
                    item.loginId,
                    item.email,
                    _loginTypeName(item.loginType),
                    item.status == 1 ? 'Active' : 'Inactive',
                    item.errorPwdRetry.toString(),
                    item.errorPinRetry.toString(),
                    item.accountExpired.toString(),
                    item.created,
                    item.salesId,
                    item.permissions.toString(),
                  ],
                )
                .toList(),
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.indigo),
            cellStyle: const pw.TextStyle(fontSize: 7),
            cellPadding: const pw.EdgeInsets.all(4),
            border: pw.TableBorder.all(color: PdfColors.grey400, width: .5),
          ),
        ],
        footer: (context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 8),
          ),
        ),
      ),
    );
    return document.save();
  }

  pw.Widget _buildPermissionLegend() {
    const permissions = [
      ['1', 'View Only'],
      ['2', 'Syariah'],
      ['4', 'Delayed'],
      ['8', 'VIP'],
      ['16', 'Research'],
      ['32', 'Announcement'],
    ];
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 130,
          child: pw.TableHelper.fromTextArray(
            headers: const ['Value', 'Feature'],
            data: permissions,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.deepPurple100,
            ),
            headerStyle: pw.TextStyle(
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: const pw.TextStyle(fontSize: 7),
            cellPadding: const pw.EdgeInsets.all(2),
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Expanded(
          child: pw.Text(
            'Note\n'
            'The permission value is calculated by adding up the values of '
            'the active features.\n'
            'Value 0: No features are active.\n'
            'Value 63: All features are active.\n'
            'Value 14: Syariah, Delayed, and VIP features are active '
            '(2 + 4 + 8).',
            style: const pw.TextStyle(fontSize: 7),
          ),
        ),
      ],
    );
  }

  String _loginTypeName(int type) {
    return switch (type) {
      0 => 'Demo Account',
      1 => 'Client',
      2 => 'Sales',
      3 => 'Branch',
      4 => 'CS View All Account',
      5 => 'CS Branch',
      _ => 'Type $type',
    };
  }

  String? _positiveNumberValidator(String? value) {
    final number = int.tryParse(value?.trim() ?? '');
    if (number == null || number < 1) return 'Must be greater than 0';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.systemGroupedBackgroundDark
        : AppColors.white;
    final textColor = isDark ? Colors.white : AppColors.black;

    return Dialog(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 700,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Form Print Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _isPrinting
                          ? null
                          : () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.destructiveRedDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _fieldRow(
                  'Print Scope',
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment<bool>(
                        value: false,
                        icon: Icon(Icons.description_outlined),
                        label: Text('Current Page'),
                      ),
                      ButtonSegment<bool>(
                        value: true,
                        icon: Icon(Icons.library_books_outlined),
                        label: Text('All Data'),
                      ),
                    ],
                    selected: {_printAll},
                    showSelectedIcon: false,
                    onSelectionChanged: _isPrinting
                        ? null
                        : (selection) {
                            setState(() => _printAll = selection.first);
                          },
                  ),
                  textColor,
                ),
                _fieldRow(
                  'Page',
                  TextFormField(
                    controller: _pageController,
                    autofocus: true,
                    enabled: !_printAll,
                    keyboardType: TextInputType.number,
                    validator: _printAll ? null : _positiveNumberValidator,
                    decoration: _inputDecoration('Insert Page'),
                  ),
                  textColor,
                ),
                _fieldRow(
                  'Per Page',
                  TextFormField(
                    controller: _perPageController,
                    enabled: !_printAll,
                    keyboardType: TextInputType.number,
                    validator: _printAll ? null : _positiveNumberValidator,
                    decoration: _inputDecoration('Insert Per Page'),
                  ),
                  textColor,
                ),
                _fieldRow(
                  'Search',
                  DropdownMenu<OnlineIdModel>(
                    controller: _searchController,
                    expandedInsets: EdgeInsets.zero,
                    enableFilter: true,
                    enableSearch: true,
                    requestFocusOnTap: true,
                    hintText: _isLoadingSearchOptions
                        ? 'Loading data...'
                        : 'Search Login ID / Email',
                    menuHeight: 240,
                    trailingIcon: _isLoadingSearchOptions
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : const Icon(Icons.arrow_drop_down),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    dropdownMenuEntries: _searchOptions
                        .map(
                          (option) => DropdownMenuEntry(
                            value: option,
                            label: '${option.loginId} - ${option.email}',
                          ),
                        )
                        .toList(),
                    onSelected: (option) {
                      if (option == null) return;
                      _searchController.text =
                          '${option.loginId} - ${option.email}';
                    },
                  ),
                  textColor,
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: _isPrinting
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _isPrinting ? null : _print,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: _isPrinting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldRow(String label, Widget field, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 210,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(label, style: TextStyle(color: textColor)),
            ),
          ),
          Expanded(child: field),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}

class _OnlineIdPdfPreviewDialog extends StatelessWidget {
  final String fileName;
  final Future<Uint8List> Function(PdfPageFormat pageFormat) buildPdf;

  const _OnlineIdPdfPreviewDialog({
    required this.fileName,
    required this.buildPdf,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.systemGroupedBackgroundDark
        : AppColors.white;
    final textColor = isDark ? Colors.white : AppColors.black;
    final screenSize = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: screenSize.width * .82,
        height: screenSize.height * .82,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Report Online User Preview',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.destructiveRedDark,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PdfPreview(
                build: buildPdf,
                initialPageFormat: PdfPageFormat.a4.landscape,
                pdfFileName: fileName,
                allowPrinting: true,
                allowSharing: false,
                canChangeOrientation: false,
                canChangePageFormat: true,
                canDebug: false,
                actionBarTheme: PdfActionBarTheme(
                  backgroundColor: background,
                  iconColor: textColor,
                  height: 52,
                  elevation: 0,
                  actionSpacing: 8,
                  alignment: WrapAlignment.center,
                  textStyle: TextStyle(color: textColor, fontSize: 13),
                ),
                scrollViewDecoration: BoxDecoration(
                  color: isDark
                      ? AppColors.black.withValues(alpha: .35)
                      : AppColors.separatorLight,
                ),
                loadingWidget: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

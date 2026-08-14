import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/features/online/online_id/data/models/account_link_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/online/online_id/data/repositories/online_id_repository.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/src/app_colors.dart';

class LinkAccountDialog extends StatefulWidget {
  const LinkAccountDialog({
    super.key,
    required this.user,
    required this.onSave,
  });

  final OnlineIdModel user;
  final ValueChanged<Map<String, dynamic>> onSave;

  @override
  State<LinkAccountDialog> createState() => _LinkAccountDialogState();
}

class _LinkAccountDialogState extends State<LinkAccountDialog> {
  final _searchController = TextEditingController();
  final List<AccountLinkModel> _candidates = [];
  final List<AccountLinkModel> _existing = [];
  final List<AccountLinkModel> _toLink = [];
  final List<AccountLinkModel> _toUnlink = [];
  AccountLinkModel? _selectedCandidate;
  bool _loading = true;
  String? _error;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final repository = locator<OnlineIdRepository>();
    final candidateResult = await repository.fetchAccountLinks();
    final linkedResult = await repository.fetchLinkedAccounts(
      widget.user.loginId,
    );
    if (!mounted) return;

    String? error;
    List<AccountLinkModel> candidates = const [];
    List<AccountLinkModel> existing = const [];
    candidateResult.fold(
      (value) => error = value,
      (value) => candidates = value,
    );
    linkedResult.fold(
      (value) => error ??= value,
      (value) => existing = value,
    );
    setState(() {
      _candidates
        ..clear()
        ..addAll(candidates);
      _existing
        ..clear()
        ..addAll(existing);
      _toLink.clear();
      _toUnlink.clear();
      _selectedCandidate = null;
      _loading = false;
      _error = error;
    });
  }

  List<AccountLinkModel> get _filteredCandidates {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return const [];
    return _candidates.where((account) {
      final unavailable = _existing.any(
            (item) => item.custId == account.custId,
          ) ||
          _toLink.any((item) => item.custId == account.custId);
      return !unavailable &&
          (account.custId.toLowerCase().contains(query) ||
              account.name.toLowerCase().contains(query));
    }).take(30).toList();
  }

  Iterable<AccountLinkModel> get _activeExisting => _existing.where(
        (account) => !_toUnlink.any(
          (item) => item.custId == account.custId,
        ),
      );

  void _save() {
    if (_toLink.isEmpty && _toUnlink.isEmpty) {
      _showNotice('No changes detected');
      return;
    }
    final expired = widget.user.accountExpired?.toString() ?? '';
    final phoneNumber = widget.user.handphoneNo != '-'
        ? widget.user.handphoneNo
        : widget.user.handphone != '-'
        ? widget.user.handphone
        : '';
    final birthDate = widget.user.birthDate == '-'
        ? ''
        : widget.user.birthDate.trim();
    final missingFields = <String>[
      if (phoneNumber.trim().isEmpty) 'Handphone No',
      if (birthDate.isEmpty) 'Birth Date',
    ];
    if (missingFields.isNotEmpty) {
      _showNotice(
        'Lengkapi ${missingFields.join(' dan ')} melalui menu Edit sebelum '
        'mengubah linked account.',
        title: 'Data user belum lengkap',
      );
      return;
    }
    widget.onSave({
      'LoginId': widget.user.loginId,
      'LoginType': widget.user.loginType,
      'ActionType': 2,
      'Permissions': widget.user.permissions,
      'SalesId': widget.user.salesId == '-' ? '' : widget.user.salesId,
      'Email': widget.user.email == '-' ? '' : widget.user.email,
      'CreatedBy': locator<SessionService>().read(SessionKey.loginId),
      'LoginStatus': widget.user.status,
      'AccountExpired': expired == '-' || expired == 'Never Expired'
          ? ''
          : expired,
      'ArrayAccountLink': _toLink.map((item) => item.custId).toList(),
      'ArrayAccountUnLink': _toUnlink.map((item) => item.custId).toList(),
      'BirthDate': birthDate,
      'HandphoneNo': phoneNumber,
    });
    Navigator.pop(context);
  }

  void _stageSelectedCandidate() {
    final account = _selectedCandidate;
    if (account == null) {
      _showNotice('Please select an account');
      return;
    }
    if (_toLink.any((item) => item.custId == account.custId)) {
      _showNotice('Selected account already added');
      return;
    }
    setState(() {
      _toLink.add(account);
      _selectedCandidate = null;
      _query = '';
      _searchController.clear();
    });
  }

  Future<void> _showNotice(
    String message, {
    String title = 'Pemberitahuan',
  }) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showChangeList() async {
    if (_toLink.isEmpty && _toUnlink.isEmpty) {
      await _showNotice('No changes detected');
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('List Link Account'),
        content: SizedBox(
          width: 520,
          child: ListView(
            shrinkWrap: true,
            children: [
              ..._toLink.map(
                (account) => ListTile(
                  leading: const Icon(
                    Icons.add_link,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(account.custId),
                  subtitle: Text(account.name),
                  trailing: const Text('New Link'),
                ),
              ),
              ..._toUnlink.map(
                (account) => ListTile(
                  leading: const Icon(
                    Icons.link_off,
                    color: AppColors.destructiveRedDark,
                  ),
                  title: Text(account.custId),
                  subtitle: Text(account.name),
                  trailing: const Text('Unlink'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.systemGroupedBackgroundDark
        : AppColors.white;
    final panel = isDark
        ? AppColors.systemBackgroundDark
        : AppColors.backgroundLight;
    final textColor = isDark ? Colors.white : AppColors.black;
    final border = isDark ? AppColors.separatorDark : AppColors.lighterGrey;

    return Dialog(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780, maxHeight: 680),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.link, color: AppColors.primaryColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Link Account',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Login ID: ${widget.user.loginId}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.destructiveRedDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (_loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_error != null)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.destructiveRedDark,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _loadData,
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: _searchController,
                          onChanged: (value) => setState(() => _query = value),
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: 'Cari Account ID atau nama',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: panel,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        if (_query.trim().isNotEmpty)
                          _accountPanel(
                            accounts: _filteredCandidates,
                            emptyText: 'Account tidak ditemukan',
                            border: border,
                            textColor: textColor,
                            selectedId: _selectedCandidate?.custId,
                            onTap: (account) => setState(
                              () => _selectedCandidate = account,
                            ),
                            trailing: (account) => Icon(
                              _selectedCandidate?.custId == account.custId
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _showChangeList,
                                icon: const Icon(Icons.list_alt, size: 18),
                                label: const Text('List Link Account'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _stageSelectedCandidate,
                                icon: const Icon(Icons.add_link, size: 18),
                                label: const Text('Link Account'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _section(
                          title: 'Linked Account saat ini',
                          accounts: _activeExisting.toList(),
                          emptyText: 'Belum ada linked account',
                          border: border,
                          textColor: textColor,
                          trailing: (account) => TextButton.icon(
                            onPressed: () => setState(
                              () => _toUnlink.add(account),
                            ),
                            icon: const Icon(Icons.link_off, size: 17),
                            label: const Text('Unlink'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.destructiveRedDark,
                            ),
                          ),
                        ),
                        if (_toLink.isNotEmpty)
                          _section(
                            title: 'Account baru (${_toLink.length})',
                            accounts: _toLink,
                            emptyText: '',
                            border: border,
                            textColor: textColor,
                            trailing: (account) => IconButton(
                              onPressed: () =>
                                  setState(() => _toLink.remove(account)),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppColors.destructiveRedDark,
                              ),
                            ),
                          ),
                        if (_toUnlink.isNotEmpty)
                          _section(
                            title: 'Akan dilepas (${_toUnlink.length})',
                            accounts: _toUnlink,
                            emptyText: '',
                            border: border,
                            textColor: textColor,
                            trailing: (account) => TextButton.icon(
                              onPressed: () =>
                                  setState(() => _toUnlink.remove(account)),
                              icon: const Icon(Icons.undo, size: 17),
                              label: const Text('Batalkan'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _loading || _error != null ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required List<AccountLinkModel> accounts,
    required String emptyText,
    required Color border,
    required Color textColor,
    required Widget Function(AccountLinkModel) trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          _accountPanel(
            accounts: accounts,
            emptyText: emptyText,
            border: border,
            textColor: textColor,
            trailing: trailing,
          ),
        ],
      ),
    );
  }

  Widget _accountPanel({
    required List<AccountLinkModel> accounts,
    required String emptyText,
    required Color border,
    required Color textColor,
    required Widget Function(AccountLinkModel) trailing,
    ValueChanged<AccountLinkModel>? onTap,
    String? selectedId,
  }) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 190),
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: accounts.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(18),
              child: Center(
                child: Text(
                  emptyText,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: accounts.length,
              separatorBuilder: (_, _) => Divider(height: 1, color: border),
              itemBuilder: (context, index) {
                final account = accounts[index];
                return ListTile(
                  dense: true,
                  selected: selectedId == account.custId,
                  selectedTileColor: AppColors.primaryColor.withValues(
                    alpha: 0.12,
                  ),
                  onTap: onTap == null ? null : () => onTap(account),
                  title: Text(
                    account.custId,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    account.name,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: trailing(account),
                );
              },
            ),
    );
  }
}

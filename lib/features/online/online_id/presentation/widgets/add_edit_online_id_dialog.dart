import 'package:flutter/material.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/features/online/online_id/data/models/account_link_model.dart';
import 'package:el_csadmin/features/online/online_id/data/repositories/online_id_repository.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../../core/theme/src/app_colors.dart';

class AddEditOnlineIdDialog extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSave;

  const AddEditOnlineIdDialog({
    super.key,
    required this.isEdit,
    required this.onSave,
    this.initialData,
  });

  @override
  State<AddEditOnlineIdDialog> createState() => _AddEditOnlineIdDialogState();
}

class _AddEditOnlineIdDialogState extends State<AddEditOnlineIdDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _loginIdCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _retypeEmailCtrl;
  late TextEditingController _handphoneCtrl;
  late TextEditingController _birthDateCtrl;
  late TextEditingController _expiredDateCtrl;
  late TextEditingController _accountSearchCtrl;

  // State Variables
  int _loginType = 0; // 0: Demo, 1: Client, 2: Sales, 3: Branch
  bool _neverExpired = false;

  // Permissions Booleans
  bool _viewOnly = false;
  bool _syariah = false;
  bool _delayed = false;
  bool _vip = false;
  bool _research = false;
  bool _announcement = false;
  final List<AccountLinkModel> _accountLinks = [];
  final List<AccountLinkModel> _existingAccountLinks = [];
  final List<AccountLinkModel> _selectedAccountLinks = [];
  final List<AccountLinkModel> _unlinkedAccountLinks = [];
  bool _accountLinksLoading = false;
  bool _accountLinksLoaded = false;
  String? _accountLinksError;
  String _accountSearch = '';

  @override
  void initState() {
    super.initState();
    _loginIdCtrl = TextEditingController(
      text: widget.initialData?['loginId']?.toString() ?? '',
    );
    _emailCtrl = TextEditingController(
      text: widget.initialData?['email']?.toString() ?? '',
    );
    _retypeEmailCtrl = TextEditingController();
    _handphoneCtrl = TextEditingController(
      text: widget.initialData?['handphoneNo']?.toString() ?? '',
    );
    _birthDateCtrl = TextEditingController(
      text: widget.initialData?['birthDate']?.toString() ?? '',
    );

    String expDate = widget.initialData?['accountExpired']?.toString() ?? '';
    _neverExpired =
        (expDate.isEmpty || expDate == 'Never Expired' || expDate == '-');
    _expiredDateCtrl = TextEditingController(
      text: _neverExpired ? '' : expDate,
    );
    _accountSearchCtrl = TextEditingController();

    if (widget.initialData?['loginType'] != null) {
      final val = widget.initialData!['loginType'].toString();
      if (val == 'Client') {
        _loginType = 1;
      } else if (val == 'Sales') {
        _loginType = 2;
      } else if (val == 'Branch') {
        _loginType = 3;
      } else if (val == 'Demo Account') {
        _loginType = 0;
      } else {
        _loginType = int.tryParse(val) ?? 0;
      }
    }

    if (widget.initialData?['permissions'] != null) {
      int perms =
          int.tryParse(widget.initialData!['permissions'].toString()) ?? 0;
      _viewOnly = (perms & 1) != 0;
      _syariah = (perms & 2) != 0;
      _delayed = (perms & 4) != 0;
      _vip = (perms & 8) != 0;
      _research = (perms & 16) != 0;
      _announcement = (perms & 32) != 0;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadAccountLinks();
    });
  }

  @override
  void dispose() {
    _loginIdCtrl.dispose();
    _emailCtrl.dispose();
    _retypeEmailCtrl.dispose();
    _handphoneCtrl.dispose();
    _birthDateCtrl.dispose();
    _expiredDateCtrl.dispose();
    _accountSearchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAccountLinks() async {
    if (_accountLinksLoading || _accountLinksLoaded) return;
    setState(() {
      _accountLinksLoading = true;
      _accountLinksError = null;
    });

    final repository = locator<OnlineIdRepository>();
    final candidateResult = await repository.fetchAccountLinks();
    final linkedResult = widget.isEdit
        ? await repository.fetchLinkedAccounts(_loginIdCtrl.text.trim())
        : null;
    if (!mounted) return;

    String? error;
    List<AccountLinkModel> candidates = const [];
    List<AccountLinkModel> existing = const [];
    candidateResult.fold(
      (value) => error = value,
      (value) => candidates = value,
    );
    linkedResult?.fold((value) => error ??= value, (value) => existing = value);

    setState(() {
      _accountLinks
        ..clear()
        ..addAll(candidates);
      _existingAccountLinks
        ..clear()
        ..addAll(existing);
      _accountLinksLoading = false;
      _accountLinksError = error;
      _accountLinksLoaded = error == null;
    });
  }

  List<AccountLinkModel> get _filteredAccountLinks {
    final query = _accountSearch.trim().toLowerCase();
    return _accountLinks
        .where((account) {
          if (_selectedAccountLinks.any(
            (item) => item.custId == account.custId,
          )) {
            return false;
          }
          if (_existingAccountLinks.any(
            (item) => item.custId == account.custId,
          )) {
            return false;
          }
          return query.isEmpty ||
              account.custId.toLowerCase().contains(query) ||
              account.name.toLowerCase().contains(query);
        })
        .take(30)
        .toList();
  }

  void _selectAccount(AccountLinkModel account) {
    if (_selectedAccountLinks.any((item) => item.custId == account.custId)) {
      return;
    }
    setState(() {
      _selectedAccountLinks.add(account);
      _accountSearchCtrl.clear();
      _accountSearch = '';
    });
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        final month = picked.month.toString().padLeft(2, '0');
        final day = picked.day.toString().padLeft(2, '0');
        controller.text = '${picked.year}-$month-$day';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBgColor = isDark
        ? AppColors.systemGroupedBackgroundDark
        : AppColors.white;
    final textColor = isDark ? Colors.white : AppColors.black;

    return Dialog(
      backgroundColor: dialogBgColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 650,
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isEdit ? 'Edit Online User' : 'Create Online User',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.destructiveRedDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildFormRow(
                  'Login Id',
                  textColor,
                  _buildTextField(
                    controller: _loginIdCtrl,
                    hint: 'Insert Login Id',
                    enabled: !widget.isEdit,
                    isDark: isDark,
                    maxLength: 32,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9._]'),
                      ),
                    ],
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Login Id cannot be empty';
                      if (val.length < 3)
                        return 'Login Id must be at least 3 characters';
                      final validPattern = RegExp(
                        r'^(?!.*[._]{2,})(?![._])[a-zA-Z0-9._]{1,64}$',
                      );
                      if (!validPattern.hasMatch(val)) {
                        return 'Invalid pattern. No consecutive underscores/dots allowed.';
                      }
                      return null;
                    },
                  ),
                ),
                _buildFormRow('Login Type', textColor, _buildDropdown(isDark)),
                _buildFormRow(
                  'Email',
                  textColor,
                  _buildTextField(
                    controller: _emailCtrl,
                    hint: 'Insert Email',
                    isDark: isDark,
                    maxLength: 100,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!val.contains('@')) return 'Invalid email format';
                      return null;
                    },
                  ),
                ),
                _buildFormRow(
                  'Retype Email',
                  textColor,
                  _buildTextField(
                    controller: _retypeEmailCtrl,
                    hint: 'Retype Email',
                    isDark: isDark,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Re-enter email is required';
                      }
                      if (val.trim() != _emailCtrl.text.trim()) {
                        return 'Emails do not match';
                      }
                      return null;
                    },
                  ),
                ),
                _buildFormRow(
                  'Handphone No',
                  textColor,
                  _buildTextField(
                    controller: _handphoneCtrl,
                    hint: '08xx-xxxx-xxxxx',
                    isDark: isDark,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '####-####-#####',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                      LengthLimitingTextInputFormatter(17),
                    ],
                    validator: (val) {
                      final digitsOnly =
                          val?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
                      if (digitsOnly.isEmpty) return 'Handphone No is required';
                      if (digitsOnly.length < 10)
                        return 'Phone number is too short';
                      if (digitsOnly.length > 15)
                        return 'Phone number is too long';

                      // Wajib diawali 08
                      final regex = RegExp(r'^08\d{8,13}$');
                      if (!regex.hasMatch(digitsOnly)) {
                        return 'Must start with 08 and be a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                _buildFormRow(
                  'Birth Date',
                  textColor,
                  _buildTextField(
                    controller: _birthDateCtrl,
                    hint: 'Insert Birth Date',
                    readOnly: true,
                    isDark: isDark,
                    onTap: () => _selectDate(context, _birthDateCtrl),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? 'Birth Date is required'
                        : null,
                  ),
                ),
                _buildFormRow(
                  'Expired Date',
                  textColor,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _expiredDateCtrl,
                        hint: 'Insert Expired Date',
                        readOnly: true,
                        enabled: !_neverExpired,
                        isDark: isDark,
                        onTap: () {
                          if (!_neverExpired) {
                            _selectDate(context, _expiredDateCtrl);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildCheckboxRow(
                        'Never Expired',
                        _neverExpired,
                        textColor,
                        (val) {
                          setState(() {
                            _neverExpired = val!;
                            if (_neverExpired) _expiredDateCtrl.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                _buildFormRow(
                  'Permissions',
                  textColor,
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildCheckboxRow(
                              'View Only',
                              _viewOnly,
                              textColor,
                              (val) => setState(() => _viewOnly = val!),
                            ),
                          ),
                          Expanded(
                            child: _buildCheckboxRow(
                              'Syariah',
                              _syariah,
                              textColor,
                              (val) => setState(() => _syariah = val!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCheckboxRow(
                              'Delayed',
                              _delayed,
                              textColor,
                              (val) => setState(() => _delayed = val!),
                            ),
                          ),
                          Expanded(
                            child: _buildCheckboxRow(
                              'VIP',
                              _vip,
                              textColor,
                              (val) => setState(() => _vip = val!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCheckboxRow(
                              'Research',
                              _research,
                              textColor,
                              (val) => setState(() => _research = val!),
                            ),
                          ),
                          Expanded(
                            child: _buildCheckboxRow(
                              'Announcement',
                              _announcement,
                              textColor,
                              (val) => setState(() => _announcement = val!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_loginType == 1) ...[
                  const SizedBox(height: 4),
                  _buildNewLinkedAccount(isDark, textColor),
                ],
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        side: BorderSide(
                          color: isDark
                              ? AppColors.separatorDark
                              : AppColors.lighterGrey,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          int permissions = 0;
                          if (_viewOnly) permissions += 1;
                          if (_syariah) permissions += 2;
                          if (_delayed) permissions += 4;
                          if (_vip) permissions += 8;
                          if (_research) permissions += 16;
                          if (_announcement) permissions += 32;

                          final Map<String, dynamic> payload = {
                            "LoginId": _loginIdCtrl.text,
                            "Email": _emailCtrl.text.trim(),
                            "LoginType": _loginType,
                            "HandphoneNo": _handphoneCtrl.text.trim(),
                            "Permissions": permissions,
                            "LoginStatus": widget.isEdit
                                ? (widget.initialData?['status'] ?? 1)
                                : 1,
                            "SalesId":
                                widget.initialData?['salesId']?.toString() ??
                                '',
                            "CreatedBy": locator<SessionService>().read(
                              SessionKey.loginId,
                            ),
                            "ActionType": widget.isEdit
                                ? 2
                                : 1, // 👈 2 = Edit, 1 = Add
                            "ArrayAccountLink": _selectedAccountLinks
                                .map((account) => account.custId)
                                .toList(),
                            "ArrayAccountUnLink": _unlinkedAccountLinks
                                .map((account) => account.custId)
                                .toList(),
                          };

                          if (_birthDateCtrl.text.isNotEmpty) {
                            payload["BirthDate"] = _birthDateCtrl.text;
                          }

                          if (_neverExpired || _expiredDateCtrl.text.isEmpty) {
                            payload["AccountExpired"] = "";
                          } else {
                            payload["AccountExpired"] = _expiredDateCtrl.text;
                          }

                          widget.onSave(payload);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Submit',
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
        ),
      ),
    );
  }

  Widget _buildNewLinkedAccount(bool isDark, Color textColor) {
    final borderColor = isDark
        ? AppColors.separatorDark
        : AppColors.lighterGrey;
    final panelColor = isDark
        ? AppColors.systemBackgroundDark
        : AppColors.backgroundLight;

    return Container(
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: ExpansionTile(
        onExpansionChanged: (expanded) {
          if (expanded) _loadAccountLinks();
        },
        iconColor: AppColors.primaryColor,
        collapsedIconColor: textColor,
        title: Text(
          'New Linked Account',
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          if (_accountLinksLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: LinearProgressIndicator(minHeight: 2),
            )
          else if (_accountLinksError != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    _accountLinksError!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.destructiveRedDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _loadAccountLinks,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            )
          else ...[
            TextField(
              controller: _accountSearchCtrl,
              onChanged: (value) => setState(() => _accountSearch = value),
              style: TextStyle(color: textColor, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Cari Account ID atau nama',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            if (_accountSearch.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxHeight: 180),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: _filteredAccountLinks.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Account tidak ditemukan',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: _filteredAccountLinks.length,
                        separatorBuilder: (_, _) =>
                            Divider(height: 1, color: borderColor),
                        itemBuilder: (context, index) {
                          final account = _filteredAccountLinks[index];
                          return ListTile(
                            dense: true,
                            title: Text(
                              account.custId,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Text(
                              account.name,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.add_circle_outline,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            onTap: () => _selectAccount(account),
                          );
                        },
                      ),
              ),
            ],
            if (widget.isEdit &&
                _existingAccountLinks.any(
                  (account) => !_unlinkedAccountLinks.any(
                    (item) => item.custId == account.custId,
                  ),
                )) ...[
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Linked Account saat ini',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ..._existingAccountLinks
                  .where(
                    (account) => !_unlinkedAccountLinks.any(
                      (item) => item.custId == account.custId,
                    ),
                  )
                  .map(
                    (account) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        account.custId,
                        style: TextStyle(color: textColor, fontSize: 12),
                      ),
                      subtitle: Text(
                        account.name,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      trailing: TextButton.icon(
                        onPressed: () =>
                            setState(() => _unlinkedAccountLinks.add(account)),
                        icon: const Icon(Icons.link_off, size: 17),
                        label: const Text('Unlink'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.destructiveRedDark,
                        ),
                      ),
                    ),
                  ),
            ],
            if (_unlinkedAccountLinks.isNotEmpty) ...[
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Akan dilepas (${_unlinkedAccountLinks.length})',
                  style: const TextStyle(
                    color: AppColors.destructiveRedDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ..._unlinkedAccountLinks.map(
                (account) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    account.custId,
                    style: TextStyle(color: textColor, fontSize: 12),
                  ),
                  subtitle: Text(
                    account.name,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () =>
                        setState(() => _unlinkedAccountLinks.remove(account)),
                    icon: const Icon(Icons.undo, size: 17),
                    label: const Text('Batalkan'),
                  ),
                ),
              ),
            ],
            if (_selectedAccountLinks.isNotEmpty) ...[
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.isEdit
                      ? 'Account baru (${_selectedAccountLinks.length})'
                      : 'Account dipilih (${_selectedAccountLinks.length})',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              ..._selectedAccountLinks.map(
                (account) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    account.custId,
                    style: TextStyle(color: textColor, fontSize: 12),
                  ),
                  subtitle: Text(
                    account.name,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: IconButton(
                    tooltip: 'Hapus account',
                    onPressed: () =>
                        setState(() => _selectedAccountLinks.remove(account)),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.destructiveRedDark,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildFormRow(String label, Color textColor, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 140,
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool isDark,
    bool enabled = true,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    final bgColor = isDark
        ? AppColors.systemBackgroundDark
        : AppColors.backgroundLight;
    final disabledBgColor = isDark
        ? AppColors.separatorDark.withValues(alpha: 0.3)
        : AppColors.lighterGrey.withValues(alpha: 0.5);
    final borderColor = isDark
        ? AppColors.separatorDark
        : AppColors.lighterGrey;
    final textColor = isDark ? Colors.white : AppColors.black;

    return Container(
      decoration: BoxDecoration(
        color: enabled ? bgColor : disabledBgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: TextStyle(color: textColor, fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          counterText: '',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          errorStyle: const TextStyle(
            color: AppColors.destructiveRedDark,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(bool isDark) {
    final bgColor = isDark
        ? AppColors.systemBackgroundDark
        : AppColors.backgroundLight;
    final borderColor = isDark
        ? AppColors.separatorDark
        : AppColors.lighterGrey;
    final textColor = isDark ? Colors.white : AppColors.black;
    final dropdownBgColor = isDark
        ? AppColors.systemGroupedBackgroundDark
        : AppColors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _loginType,
          isExpanded: true,
          dropdownColor: dropdownBgColor,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          style: TextStyle(color: textColor, fontSize: 13),
          onChanged: (int? newValue) {
            setState(() {
              _loginType = newValue ?? 0;
              if (_loginType != 1) {
                _selectedAccountLinks.clear();
                _unlinkedAccountLinks.clear();
                _accountSearchCtrl.clear();
                _accountSearch = '';
              }
            });
          },
          items: const [
            DropdownMenuItem(value: 0, child: Text("Demo Account")),
            DropdownMenuItem(value: 1, child: Text("Client")),
            DropdownMenuItem(value: 2, child: Text("Sales")),
            DropdownMenuItem(value: 3, child: Text("Branch")),
            DropdownMenuItem(value: 4, child: Text("CS View All Account")),
            DropdownMenuItem(value: 5, child: Text("CS Branch")),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(
    String label,
    bool value,
    Color textColor,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
            checkColor: Colors.white,
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: textColor, fontSize: 13)),
      ],
    );
  }
}

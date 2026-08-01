import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _loginIdCtrl = TextEditingController(
      text: widget.initialData?['loginId']?.toString() ?? '',
    );
    _emailCtrl = TextEditingController(
      text: widget.initialData?['email']?.toString() ?? '',
    );
    // Retype Email sengaja selalu kosong, termasuk saat Edit. Pengguna harus
    // mengonfirmasi ulang alamat email seperti pada aplikasi CS Admin lama.
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
  }

  @override
  void dispose() {
    _loginIdCtrl.dispose();
    _emailCtrl.dispose();
    _retypeEmailCtrl.dispose();
    _handphoneCtrl.dispose();
    _birthDateCtrl.dispose();
    _expiredDateCtrl.dispose();
    super.dispose();
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
                    validator: (val) => val!.isEmpty ? 'Required' : null,
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
                    hint: 'Handphone No',
                    isDark: isDark,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? 'Handphone No is required'
                        : null,
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

                          // 👇 PERBAIKAN: Payload Dibuat Secara Dinamis
                          final Map<String, dynamic> payload = {
                            "LoginId": _loginIdCtrl.text,
                            "Email": _emailCtrl.text.trim(),
                            "LoginType": _loginType,
                            "PhoneNumber": _handphoneCtrl.text.trim(),
                            "Permissions": permissions,
                            "Status": 1,
                            "CreatedBy": "admin",
                            "ActionType": widget.isEdit
                                ? 2
                                : 1, // 👈 2 = Edit, 1 = Add
                            "ArrayAccountLink": [], // 👈 Array Wajib
                            "ArrayAccountUnLink": [], // 👈 Array Wajib
                          };

                          // 👇 Hanya kirim BirthDate jika tidak kosong (mencegah null crash)
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
        style: TextStyle(color: textColor, fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
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

import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';
import 'package:intl/intl.dart';

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
    _retypeEmailCtrl = TextEditingController(
      text: widget.initialData?['email']?.toString() ?? '',
    );
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

    // Parsing tipe login dengan aman (mendukung angka maupun teks)
    if (widget.initialData?['loginType'] != null) {
      final val = widget.initialData!['loginType'].toString();
      if (val == 'Client')
        _loginType = 1;
      else if (val == 'Sales')
        _loginType = 2;
      else if (val == 'Branch')
        _loginType = 3;
      else if (val == 'Demo Account')
        _loginType = 0;
      else
        _loginType = int.tryParse(val) ?? 0;
    }

    // Parsing bitmask permissions saat edit
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8B5CF6),
              onPrimary: Colors.white,
              surface: AppColors.systemGroupedBackgroundDark,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.systemGroupedBackgroundDark,
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
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isEdit ? 'Edit Online User' : 'Create Online User',
                      style: const TextStyle(
                        color: Colors.white,
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

                // FORM FIELDS
                _buildFormRow(
                  'Login Id',
                  _buildTextField(
                    controller: _loginIdCtrl,
                    hint: 'Insert Login Id',
                    enabled: !widget.isEdit,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                ),
                _buildFormRow('Login Type', _buildDropdown()),
                _buildFormRow(
                  'Email',
                  _buildTextField(
                    controller: _emailCtrl,
                    hint: 'Insert Email',
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Required';
                      if (!val.contains('@')) return 'Invalid email format';
                      return null;
                    },
                  ),
                ),
                _buildFormRow(
                  'Retype Email',
                  _buildTextField(
                    controller: _retypeEmailCtrl,
                    hint: 'Retype Email',
                    validator: (val) =>
                        val != _emailCtrl.text ? 'Emails do not match' : null,
                  ),
                ),
                _buildFormRow(
                  'Handphone No',
                  _buildTextField(
                    controller: _handphoneCtrl,
                    hint: 'Handphone No',
                  ),
                ),
                _buildFormRow(
                  'Birth Date',
                  _buildTextField(
                    controller: _birthDateCtrl,
                    hint: 'Insert Birth Date',
                    readOnly: true,
                    onTap: () => _selectDate(context, _birthDateCtrl),
                  ),
                ),
                _buildFormRow(
                  'Expired Date',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _expiredDateCtrl,
                        hint: 'Insert Expired Date',
                        readOnly: true,
                        enabled: !_neverExpired,
                        onTap: () {
                          if (!_neverExpired)
                            _selectDate(context, _expiredDateCtrl);
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildCheckboxRow('Never Expired', _neverExpired, (val) {
                        setState(() {
                          _neverExpired = val!;
                          if (_neverExpired) _expiredDateCtrl.clear();
                        });
                      }),
                    ],
                  ),
                ),

                // PERMISSIONS
                _buildFormRow(
                  'Permissions',
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildCheckboxRow(
                              'View Only',
                              _viewOnly,
                              (val) => setState(() => _viewOnly = val!),
                            ),
                          ),
                          Expanded(
                            child: _buildCheckboxRow(
                              'Syariah',
                              _syariah,
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
                              (val) => setState(() => _delayed = val!),
                            ),
                          ),
                          Expanded(
                            child: _buildCheckboxRow(
                              'VIP',
                              _vip,
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
                              (val) => setState(() => _research = val!),
                            ),
                          ),
                          Expanded(
                            child: _buildCheckboxRow(
                              'Announcement',
                              _announcement,
                              (val) => setState(() => _announcement = val!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ACTION BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textColorDark,
                        side: const BorderSide(color: AppColors.separatorDark),
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

                          final payload = {
                            "LoginId": _loginIdCtrl.text,
                            "Email": _emailCtrl.text,
                            "LoginType": _loginType,
                            "PhoneNumber": _handphoneCtrl.text,
                            "BirthDate": _birthDateCtrl.text.isEmpty
                                ? null
                                : _birthDateCtrl.text,
                            "AccountExpired": _neverExpired
                                ? ""
                                : _expiredDateCtrl.text,
                            "Permissions": permissions,
                            "Status": 1,
                            "CreatedBy": "admin",
                          };
                          widget.onSave(payload);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
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

  Widget _buildFormRow(String label, Widget content) {
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
                style: const TextStyle(
                  color: Colors.white,
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
    bool enabled = true,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled
            ? AppColors.systemBackgroundDark
            : AppColors.separatorDark.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.separatorDark),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.separatorDark),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.separatorDark),
          ),
          errorStyle: const TextStyle(
            color: AppColors.destructiveRedDark,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  // 💡 PERBAIKAN 1: Menambahkan tipe <int> secara eksplisit ke DropdownMenuItem
  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.systemBackgroundDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _loginType,
          isExpanded: true,
          dropdownColor: AppColors.systemGroupedBackgroundDark,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          style: const TextStyle(color: Colors.white, fontSize: 13),
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

  // 💡 PERBAIKAN 2: Menggunakan ValueChanged<bool?> agar tipe functionnya akurat
  Widget _buildCheckboxRow(
    String label,
    bool value,
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
            activeColor: const Color(0xFF8B5CF6),
            checkColor: Colors.white,
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }
}

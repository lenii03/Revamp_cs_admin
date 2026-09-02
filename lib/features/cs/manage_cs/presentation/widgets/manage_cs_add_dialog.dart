import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCsUserDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final BuildContext blocContext;

  const AddCsUserDialog({
    super.key,
    required this.onSubmit,
    required this.blocContext,
  });

  @override
  State<AddCsUserDialog> createState() => _AddCsUserDialogState();
}

class _AddCsUserDialogState extends State<AddCsUserDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final cLoginId = TextEditingController();
  final cEmployeeId = TextEditingController();
  final cEmail = TextEditingController();
  final cRetypeEmail = TextEditingController();

  // State untuk Permissions
  List<bool> checksPermission = List.filled(9, false);
  final List<String> permissionLabels = [
    'Create CS Login',
    'Create Online User',
    'Approve Online User',
    'Create Only Demo Account',
    'View CSLogs',
    'Approval Opening Account',
    'View Report',
    'Send OLUser Disclaimer',
    'View Customer Ratio',
  ];

  // State Status
  bool isSuspended = false;

  int _calculatePermissionsValue() {
    int value = 0;
    for (int i = 0; i < checksPermission.length; i++) {
      if (checksPermission[i]) {
        value += (1 << i);
      }
    }
    return value;
  }

  @override
  void dispose() {
    cLoginId.dispose();
    cEmployeeId.dispose();
    cEmail.dispose();
    cRetypeEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 👇 Menangkap status tema saat ini (Dark atau Light)
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.black;
    final dialogBgColor = isDark
        ? AppColors.systemBackgroundDark
        : AppColors.white;

    return Dialog(
      // 👇 Gunakan warna dinamis
      backgroundColor: dialogBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Text(
                  "Add new user",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor, // 👇 Teks dinamis
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.redAccent),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFormRow(
                        "Login Id",
                        _buildTextField(
                          cLoginId,
                          "Insert Login Id",
                          isDark,
                          maxLength: 32,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9._]'),
                            ),
                          ],
                          validator: _validateLoginId,
                        ),
                        textColor,
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Employee Id",
                        _buildTextField(
                          cEmployeeId,
                          "Insert Employee Id",
                          isDark,
                          maxLength: 32,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9._-]'),
                            ),
                          ],
                          validator: (value) => _validateRequired(
                            value,
                            fieldName: 'Employee Id',
                            maxLength: 32,
                          ),
                        ),
                        textColor,
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Email",
                        _buildTextField(
                          cEmail,
                          "Insert Email",
                          isDark,
                          maxLength: 100,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,

                          
                        ),
                        textColor,
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Retype Email",
                        _buildTextField(
                          cRetypeEmail,
                          "Retype Email",
                          isDark,
                          maxLength: 100,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final error = _validateEmail(value);
                            if (error != null) return error;
                            if (value!.trim() != cEmail.text.trim()) {
                              return 'Emails do not match';
                            }
                            return null;
                          },
                        ),
                        textColor,
                      ),
                      const SizedBox(height: 16),

                      // --- PERMISSIONS GRID ---
                      _buildFormRow(
                        "Permissions",
                        Wrap(
                          spacing: 16,
                          runSpacing: 4,
                          children: List.generate(
                            permissionLabels.length,
                            (index) => SizedBox(
                              width: 220,
                              child: _buildCompactCheckbox(
                                label: permissionLabels[index],
                                value: checksPermission[index],
                                textColor: textColor,
                                onChanged: (val) {
                                  setState(() {
                                    checksPermission[index] = val ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        textColor,
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Status",
                        _buildCompactCheckbox(
                          label: 'Suspended',
                          value: isSuspended,
                          textColor: textColor,
                          onChanged: (val) {
                            setState(() {
                              isSuspended = val ?? false;
                            });
                          },
                        ),
                        textColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textColor, // 👇 Teks tombol dinamis
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Close"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (cEmail.text != cRetypeEmail.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email and Retype Email must match!'),
                          ),
                        );
                        return;
                      }
                      final sessionService = locator<SessionService>();
                      final tempPass = sessionService.read(SessionKey.password);
                      final currentUser = sessionService.read(
                        SessionKey.loginId,
                      );

                      final requestPayload = {
                        "LoginId": cLoginId.text.trim(),
                        "Password": tempPass,
                        "EmployeeId": cEmployeeId.text.trim(),
                        "Email": cEmail.text.trim(),
                        "Permissions": _calculatePermissionsValue(),
                        "Status": isSuspended ? 1 : 0,
                        "CreatedBy": currentUser,
                      };
                      widget.onSubmit(requestPayload);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06B6D4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ), // Save button tetap putih (karena background cyan)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormRow(String label, Widget child, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              label,
              style: TextStyle(
                color: textColor, // 👇 Dinamis
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildCompactCheckbox({
    required String label,
    required bool value,
    required Color textColor,
    required Function(bool?) onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF06B6D4),
            side: const BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: textColor, fontSize: 12), // 👇 Dinamis
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool isDark, {
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final textColor = isDark ? Colors.white : AppColors.black;
    final fillColor = isDark
        ? AppColors.systemBackgroundDark
        : AppColors.backgroundLight;
    final borderColor = isDark
        ? AppColors.separatorDark
        : AppColors.lighterGrey;

    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(color: textColor, fontSize: 13), // 👇 Dinamis
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        counterText: '',
        filled: true,
        fillColor: fillColor, // 👇 Dinamis
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor), // 👇 Dinamis
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor), // 👇 Dinamis
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF06B6D4)),
        ),
      ),
      validator: validator ?? (value) => _validateRequired(value),
    );
  }

  String? _validateLoginId(String? value) {
    final loginId = value?.trim() ?? '';
    if (loginId.isEmpty) return 'Login Id cannot be empty';
    if (loginId.length < 3) return 'Login Id must be at least 3 characters';
    if (loginId.length > 32) return 'Login Id must be at most 32 characters';
    final validPattern = RegExp(
      r'^(?!.*[._]{2,})(?![._])[a-zA-Z0-9._]{3,32}(?<![._])$',
    );
    if (!validPattern.hasMatch(loginId)) {
      return 'Only letters, numbers, underscores, and dots are allowed';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    if (email.length > 100) return 'Email must be at most 100 characters';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validateRequired(
    String? value, {
    String fieldName = 'Field',
    int? maxLength,
  }) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty) return '$fieldName is required';
    if (maxLength != null && normalized.length > maxLength) {
      return '$fieldName must be at most $maxLength characters';
    }
    return null;
  }
}

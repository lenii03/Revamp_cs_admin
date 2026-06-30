import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';

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
    return Dialog(
      backgroundColor: AppColors.systemBackgroundDark,
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
                const Text(
                  "Add new user",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                        _buildTextField(cLoginId, "Insert Login Id"),
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Employee Id",
                        _buildTextField(cEmployeeId, "Insert Employee Id"),
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Email",
                        _buildTextField(cEmail, "Insert Email"),
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Retype Email",
                        _buildTextField(cRetypeEmail, "Retype Email"),
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
                                onChanged: (val) {
                                  setState(() {
                                    checksPermission[index] = val ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildFormRow(
                        "Status",
                        _buildCompactCheckbox(
                          label: 'Suspended',
                          value: isSuspended,
                          onChanged: (val) {
                            setState(() {
                              isSuspended = val ?? false;
                            });
                          },
                        ),
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
                    foregroundColor: Colors.white,
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
                        "LoginId": cLoginId.text,
                        "Password": tempPass,
                        "EmployeeId": cEmployeeId.text,
                        "Email": cEmail.text,
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
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormRow(String label, Widget child) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
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
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: AppColors.systemBackgroundDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.separatorDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.separatorDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF06B6D4)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

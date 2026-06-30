import 'package:el_csadmin/features/cs/manage_cs/presentation/bloc/manage_cs_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../../data/models/cs_user_model.dart';
import '../bloc/manage_cs_bloc.dart';
import '../bloc/manage_cs_state.dart';

class ManageCsTableWidget extends StatelessWidget {
  const ManageCsTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: BlocBuilder<ManageCsBloc, ManageCsState>(
        builder: (context, state) {
          if (state is ManageCsLoading || state is ManageCsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryDark),
            );
          } else if (state is ManageCsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.destructiveRedDark),
              ),
            );
          } else if (state is ManageCsLoaded) {
            if (state.csUsers.isEmpty) {
              return const Center(
                child: Text(
                  "Data Kosong",
                  style: TextStyle(color: AppColors.secondaryTextColorDark),
                ),
              );
            }
            return _buildDataTable(context, state.csUsers);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDataTable(
    BuildContext context,
    List<ManageCsUsersModel> dataList,
  ) {
    final List<TrinaColumn> columns = [
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'LoginId',
        field: 'loginId',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 120,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Employee Id',
        field: 'employeeId',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 120,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 220,
      ),
      TrinaColumn(
        title: 'Active',
        field: 'isActive',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 100,
      ),
      TrinaColumn(
        title: 'CS',
        field: 'isCs',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 100,
      ),
      TrinaColumn(
        title: 'Online',
        field: 'isOnline',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 100,
      ),
      TrinaColumn(
        title: 'Approve',
        field: 'approve',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 100,
      ),
      TrinaColumn(
        title: 'Demo',
        field: 'demo',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 100,
      ),
      TrinaColumn(
        title: 'CS Logs',
        field: 'csLogs',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 110,
      ),
      TrinaColumn(
        title: 'Opening Account',
        field: 'openingAccount',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 150,
      ),
      TrinaColumn(
        title: 'Reports',
        field: 'reports',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 110,
      ),
      TrinaColumn(
        title: 'Send OLUser Disclaimer',
        field: 'sendDisclaimer',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 200,
      ),
      TrinaColumn(
        title: 'Customer Ratio',
        field: 'customerRatio',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 140,
      ),
      TrinaColumn(
        title: 'Created',
        field: 'created',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 180,
      ),
      TrinaColumn(
        title: 'Last Modified',
        field: 'lastModified',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 180,
      ),
      TrinaColumn(
        title: 'Last Login',
        field: 'lastLogin',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 180,
      ),
      TrinaColumn(
        title: 'Created By',
        field: 'createdBy',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 130,
      ),
      TrinaColumn(
        title: 'Modified By',
        field: 'modifiedBy',
        type: TrinaColumnType.text(),
        readOnly: true,
        width: 130,
      ),
      TrinaColumn(
        title: '',
        field: 'action',
        type: TrinaColumnType.text(),
        width: 60,
        frozen: TrinaColumnFrozen.end,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        renderer: (rendererContext) {
          final loginIdStr =
              rendererContext.row.cells['loginId']?.value.toString() ?? '';
          return PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: AppColors.systemGroupedBackgroundDark,
            onSelected: (String result) {
              if (result == 'Edit') {
                final userObject = dataList.firstWhere(
                  (user) => user.loginId == loginIdStr,
                  orElse: () => dataList.first,
                );
                _showEditUserDialog(context, userObject);
              } else if (result == 'Delete') {
                _showDeleteDialog(context, loginIdStr);
              } else if (result == 'Reset') {
                final userObject = dataList.firstWhere(
                  (user) => user.loginId == loginIdStr,
                  orElse: () => dataList.first,
                );
                _showResetPasswordDialog(context, userObject);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Edit',
                child: Text(
                  'Edit',
                  style: TextStyle(color: AppColors.textColorDark),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Delete',
                child: Text(
                  'Delete',
                  style: TextStyle(color: AppColors.textColorDark),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Reset',
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: AppColors.textColorDark),
                ),
              ),
            ],
          );
        },
      ),
    ];

    final List<TrinaRow> rows = dataList.map((csUser) {
      return TrinaRow(
        cells: {
          'loginId': TrinaCell(value: csUser.loginId),
          'employeeId': TrinaCell(value: csUser.employeeId),
          'email': TrinaCell(value: csUser.email),
          'isActive': TrinaCell(value: csUser.isActive ? 'Yes' : 'No'),
          'isCs': TrinaCell(value: csUser.isCs ? 'Yes' : 'No'),
          'isOnline': TrinaCell(value: csUser.isOnline ? 'Yes' : 'No'),
          'approve': TrinaCell(value: csUser.hasApprove ? '✔️' : '❌'),
          'demo': TrinaCell(value: csUser.hasDemo ? '✔️' : '❌'),
          'csLogs': TrinaCell(value: csUser.hasCsLogs ? '✔️' : '❌'),
          'openingAccount': TrinaCell(
            value: csUser.hasOpeningAccount ? '✔️' : '❌',
          ),
          'reports': TrinaCell(value: csUser.hasReports ? '✔️' : '❌'),
          'sendDisclaimer': TrinaCell(
            value: csUser.hasSendDisclaimer ? '✔️' : '❌',
          ),
          'customerRatio': TrinaCell(
            value: csUser.hasCustomerRatio ? '✔️' : '❌',
          ),
          'created': TrinaCell(value: csUser.created),
          'lastModified': TrinaCell(value: csUser.lastModified),
          'lastLogin': TrinaCell(value: csUser.lastLogin),
          'createdBy': TrinaCell(value: csUser.createdBy),
          'modifiedBy': TrinaCell(value: csUser.modifiedBy),
          'action': TrinaCell(value: ''),
        },
      );
    }).toList();

    return AppDataGrid(key: ValueKey(dataList), columns: columns, rows: rows);
  }

  void _showDeleteDialog(BuildContext context, String loginId) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.systemGroupedBackgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.amber,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Customer Service Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure want to delete customer service account $loginId?',
                style: const TextStyle(color: AppColors.secondaryTextColorDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
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
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ManageCsBloc>().add(DeleteCsUser(loginId));
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06B6D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, ManageCsUsersModel user) {
    final cEmployeeId = TextEditingController(text: user.employeeId);
    final cEmail = TextEditingController(text: user.email);
    final formKey = GlobalKey<FormState>();
    final manageCsBloc = context.read<ManageCsBloc>();

    showDialog(
      context: context,
      builder: (ctx) {
        bool createCsLogin = user.hasApprove;
        bool suspended = !user.isActive;

        return StatefulBuilder(
          builder: (stateContext, setState) {
            return Dialog(
              backgroundColor: AppColors.systemGroupedBackgroundDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 650,
                padding: const EdgeInsets.all(28.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Edit user',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => Navigator.pop(ctx),
                              child: const Icon(
                                Icons.close,
                                color: AppColors.destructiveRedDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      _buildFormRow(
                        'Login Id',
                        Text(
                          user.loginId,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // 👇 2. Pasang controller ke text field 👇
                      _buildFormRow(
                        'Employee Id',
                        _buildTextField('', controller: cEmployeeId),
                      ),
                      _buildFormRow(
                        'Email',
                        _buildTextField('', controller: cEmail),
                      ),
                      _buildFormRow(
                        'Retype Email',
                        _buildTextField(
                          '',
                          hint: 'Retype Email',
                          validator: (val) => val != cEmail.text
                              ? 'Re-enter email is required'
                              : null,
                        ),
                      ),

                      _buildFormRow(
                        'Permissions',
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildCheckboxRow(
                                    'Create CS Login',
                                    createCsLogin,
                                    (val) =>
                                        setState(() => createCsLogin = val!),
                                  ),
                                ),
                                Expanded(
                                  child: _buildCheckboxRow(
                                    'Create Online User',
                                    true,
                                    (val) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildCheckboxRow(
                                    'View CSLogs',
                                    false,
                                    (val) {},
                                  ),
                                ),
                                Expanded(
                                  child: _buildCheckboxRow(
                                    'Send OLUser Disclaimer',
                                    true,
                                    (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _buildFormRow(
                        'Status',
                        _buildCheckboxRow(
                          'Suspended',
                          suspended,
                          (val) => setState(() => suspended = val!),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textColorDark,
                              side: const BorderSide(
                                color: AppColors.separatorDark,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Close'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                int newPermissions = 0;
                                if (createCsLogin)
                                  newPermissions +=
                                      1; 
                                final payload = {
                                  "LoginId": user.loginId,
                                  "EmployeeId": cEmployeeId
                                      .text, 
                                  "Email": cEmail.text,
                                  "Permissions": newPermissions,
                                  "Status": suspended ? 1 : 0,
                                  "ModifiedBy": "admin",
                                };

                                context.read<ManageCsBloc>().add(
                                  EditCsUser(payload),
                                );
                                manageCsBloc.add(EditCsUser(payload));
                                Navigator.pop(ctx);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF06B6D4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Save',
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
            );
          },
        );
      },
    );
  }

  Widget _buildFormRow(String label, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 140,
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String initialValue, {
    TextEditingController? controller,
    String? hint,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.systemBackgroundDark,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        obscureText: isPassword,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        textAlignVertical: TextAlignVertical.center,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          errorStyle: const TextStyle(
            color: AppColors.destructiveRedDark,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(
    String label,
    bool value,
    Function(bool?) onChanged,
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
            activeColor: const Color(0xFF06B6D4),
            checkColor: Colors.white,
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }

  void _showResetPasswordDialog(BuildContext context, ManageCsUsersModel user) {
    final formKey = GlobalKey<FormState>();
    final cRetypeEmail = TextEditingController();
    final cNewPassword = TextEditingController();
    final cRetypePassword = TextEditingController();
    final bloc = context.read<ManageCsBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: bloc,
          child: Dialog(
            backgroundColor: AppColors.systemGroupedBackgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(28.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Resset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Navigator.pop(dialogContext),
                            child: const Icon(
                              Icons.close,
                              color: AppColors.destructiveRedDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Fields
                    _buildFormRow(
                      'Login Id',
                      Text(
                        user.loginId,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildFormRow(
                      'Email',
                      Text(
                        user.email,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    _buildFormRow(
                      'Retype Email',
                      _buildTextField(
                        '',
                        controller: cRetypeEmail,
                        hint: 'Retype Email',
                        validator: (val) =>
                            val != user.email ? 'Email does not match' : null,
                      ),
                    ),

                    _buildFormRow(
                      'New Password',
                      _buildTextField(
                        '',
                        controller: cNewPassword,
                        hint: 'Insert Password',
                        isPassword: true,
                        validator: (val) {
                          if (val == null || val.length < 6)
                            return 'Password must be at least 6 characters';
                          if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
                          ).hasMatch(val)) {
                            return 'Must combine upper, lower case, and numbers';
                          }
                          return null;
                        },
                      ),
                    ),

                    _buildFormRow(
                      'Retype Password',
                      _buildTextField(
                        '',
                        controller: cRetypePassword,
                        hint: 'Insert Password',
                        isPassword: true,
                        validator: (val) => val != cNewPassword.text
                            ? 'Password does not match'
                            : null,
                      ),
                    ),

                    _buildFormRow(
                      '',
                      const Text(
                        '*note\nPassword must be at least 6 characters.\nPassword must be combination upper and lower case.\nPassword must be at least have a number.',
                        style: TextStyle(
                          color: AppColors.secondaryTextColorDark,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textColorDark,
                            side: const BorderSide(
                              color: AppColors.separatorDark,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Close'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final payload = {
                                'LoginId': user.loginId,
                                'Password': cRetypePassword.text,
                                'ModifiedBy': 'admin',
                              };
                              context.read<ManageCsBloc>().add(
                                ResetPasswordCsUser(payload),
                              );
                              bloc.add(ResetPasswordCsUser(payload));
                              Navigator.pop(dialogContext);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF06B6D4,
                            ), // Cyan seragam
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Save',
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
      },
    );
  }
}

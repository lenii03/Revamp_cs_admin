import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_bloc.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_event.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_state.dart';
import 'package:el_csadmin/features/online/online_id/presentation/widgets/add_edit_online_id_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApprovalActionButtonsWidget extends StatelessWidget {
  const ApprovalActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineIdBloc, OnlineIdState>(
      builder: (context, state) {
        final OnlineIdModel? selectedUser = state.maybeWhen(
          loaded: (data, user) => user,
          orElse: () => null,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  _buildActionButton(
                    context,
                    "Add",
                    Icons.add,
                    isPrimary: true,
                    selectedUser: selectedUser,
                  ),
                  _buildActionButton(
                    context,
                    "Edit",
                    Icons.edit,
                    selectedUser: selectedUser,
                  ),
                  _buildActionButton(
                    context,
                    "Delete",
                    Icons.delete,
                    isDestructive: true,
                    selectedUser: selectedUser,
                  ),
                  _buildActionButton(
                    context,
                    "Reset Password",
                    Icons.lock_reset,
                    selectedUser: selectedUser,
                  ),
                  _buildActionButton(
                    context,
                    "Reset PIN",
                    Icons.pin,
                    selectedUser: selectedUser,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _buildActionButton(
              context,
              "Link Account",
              Icons.link,
              isPrimary: true,
              selectedUser: selectedUser,
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon, {
    bool isPrimary = false,
    bool isDestructive = false,
    OnlineIdModel? selectedUser,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor = isDark ? const Color(0xFF2A2A36) : AppColors.separatorLight;
    Color textColor = isDark ? AppColors.textColorDark : AppColors.black;

    if (isPrimary) {
      bgColor = AppColors.primaryColor;
      textColor = Colors.white;
    } else if (isDestructive) {
      bgColor = AppColors.destructiveRedDark.withValues(alpha: 0.15);
      textColor = AppColors.destructiveRedDark;
    }

    return ElevatedButton.icon(
      onPressed: () {
        if (title != "Add" && selectedUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Silakan pilih user di tabel terlebih dahulu!"),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        final String loginId = selectedUser?.loginId ?? "";
        final String email = selectedUser?.email ?? "";

        if (title == "Add") {
          showDialog(
            context: context,
            builder: (ctx) => AddEditOnlineIdDialog(
              isEdit: false,
              onSave: (data) => context.read<OnlineIdBloc>().add(
                OnlineIdEvent.addOnlineId(data),
              ),
            ),
          );
        } else if (title == "Edit") {
          showDialog(
            context: context,
            builder: (ctx) => AddEditOnlineIdDialog(
              isEdit: true,
              initialData: {"loginId": loginId, "email": email},
              onSave: (data) => context.read<OnlineIdBloc>().add(
                OnlineIdEvent.editOnlineId(data),
              ),
            ),
          );
        } else if (title == "Delete") {
          _showDeleteDialog(context, loginId);
        } else if (title == "Reset Password" || title == "Reset PIN") {
          _showResetDialog(context, title, loginId);
        }
      },
      icon: Icon(icon, color: textColor, size: 18),
      label: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String loginId) {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final dialogBgColor = isDark
            ? AppColors.systemGroupedBackgroundDark
            : AppColors.white;
        final textColor = isDark ? Colors.white : AppColors.black;
        final subTextColor = isDark
            ? AppColors.secondaryTextColorDark
            : AppColors.secondaryTextColorLight;
        final borderColor = isDark
            ? AppColors.separatorDark
            : AppColors.lighterGrey;

        return Dialog(
          backgroundColor: dialogBgColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 400,
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
                Text(
                  'Delete User',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Are you sure want delete\n[LoginId : $loginId]?',
                  style: TextStyle(color: subTextColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        side: BorderSide(color: borderColor),
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
                        context.read<OnlineIdBloc>().add(
                          OnlineIdEvent.deleteOnlineId(loginId),
                        );
                        Navigator.pop(ctx);
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
                        'Confirm',
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
      },
    );
  }

  void _showResetDialog(
    BuildContext context,
    String actionTitle,
    String loginId,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final dialogBgColor = isDark
            ? AppColors.systemGroupedBackgroundDark
            : AppColors.white;
        final textColor = isDark ? Colors.white : AppColors.black;
        final inputBgColor = isDark
            ? AppColors.systemBackgroundDark
            : AppColors.backgroundLight;
        final borderColor = isDark
            ? AppColors.separatorDark
            : AppColors.lighterGrey;

        return Dialog(
          backgroundColor: dialogBgColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      actionTitle,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(ctx),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.destructiveRedDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Login Id',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: inputBgColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: borderColor),
                        ),
                        child: Text(
                          loginId,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        side: BorderSide(color: borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        String type = actionTitle == "Reset Password"
                            ? "password"
                            : "pin";

                        context.read<OnlineIdBloc>().add(
                          OnlineIdEvent.resetOnlineId(
                            loginId: loginId,
                            resetType: type,
                          ),
                        );
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
        );
      },
    );
  }
}

import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_bloc.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_event.dart';
import 'package:el_csadmin/features/online/online_id/presentation/widgets/add_edit_online_id_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApprovalActionButtonsWidget extends StatelessWidget {
  const ApprovalActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              _buildActionButton(context, "Add", Icons.add, isPrimary: true),
              _buildActionButton(context, "Edit", Icons.edit),
              _buildActionButton(
                context,
                "Delete",
                Icons.delete,
                isDestructive: true,
              ),
              _buildActionButton(context, "Reset Password", Icons.lock_reset),
              _buildActionButton(context, "Reset PIN", Icons.pin),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _buildActionButton(
          context,
          "Link Account",
          Icons.link,
          isPrimary: true,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon, {
    bool isPrimary = false,
    bool isDestructive = false,
  }) {
    Color bgColor = const Color(0xFF2A2A36);
    Color textColor = AppColors.textColorDark;

    if (isPrimary) {
      bgColor = AppColors.primaryDark;
      textColor = Colors.white;
    } else if (isDestructive) {
      bgColor = AppColors.destructiveRedDark.withValues(alpha: 0.2);
      textColor = AppColors.destructiveRedDark;
    }

    return ElevatedButton.icon(
      onPressed: () {
        String selectedUserId = "a003";

        if (title == "Add") {
          showDialog(
            context: context,
            builder: (ctx) => AddEditOnlineIdDialog(
              isEdit: false,
              onSave: (data) =>
                  context.read<OnlineIdBloc>().add(AddOnlineIdEvent(data)),
            ),
          );
        } else if (title == "Edit") {
          showDialog(
            context: context,
            builder: (ctx) => AddEditOnlineIdDialog(
              isEdit: true,
              initialData: {
                "loginId": selectedUserId,
                "email": "dimas@contoh.com",
              },
              onSave: (data) =>
                  context.read<OnlineIdBloc>().add(EditOnlineIdEvent(data)),
            ),
          );
        } else if (title == "Delete") {
          _showDeleteDialog(context, selectedUserId);
        } else if (title == "Reset Password" || title == "Reset PIN") {
          _showResetDialog(context, title, selectedUserId);
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
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.systemGroupedBackgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              const Text(
                'Delete User',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure want delete\n[LoginId : $loginId & Email: contoh@email.com]?',
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
                      context.read<OnlineIdBloc>().add(
                        DeleteOnlineIdEvent(loginId),
                      );
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF8B5CF6,
                      ), // Warna ungu seperti di gambar
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
      ),
    );
  }

  void _showResetDialog(
    BuildContext context,
    String actionTitle,
    String loginId,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.systemGroupedBackgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    style: const TextStyle(
                      color: Colors.white,
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
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Login Id',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.systemBackgroundDark,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.separatorDark),
                      ),
                      child: Text(
                        loginId,
                        style: const TextStyle(color: Colors.white),
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
                      foregroundColor: AppColors.textColorDark,
                      side: const BorderSide(color: AppColors.separatorDark),
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
                        ResetOnlineIdEvent(loginId: loginId, resetType: type),
                      );
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
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
      ),
    );
  }
}

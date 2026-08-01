import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_bloc.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_event.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/widgets/approve_opening_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApproveOpeningActionWidget extends StatelessWidget {
  const ApproveOpeningActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          spacing: 12.0,
          children: [
            _buildActionButton(context, "Add", Icons.add),
            _buildActionButton(context, "Remove", Icons.remove),
            _buildActionButton(context, "Clear", Icons.clear_all),
          ],
        ),
        Wrap(
          spacing: 12.0,
          children: [
            _buildActionButton(
              context,
              "Send Email",
              Icons.email_outlined,
              isPrimary: true,
            ),
            _buildActionButton(
              context,
              "Send Email To All",
              Icons.mark_email_read_outlined,
              isPrimary: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon, {
    bool isPrimary = false,
  }) {
    // 👇 Deteksi tema untuk warna dinamis
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Warna default (Add, Remove, Clear)
    Color bgColor = isDark ? const Color(0xFF2A2A36) : AppColors.separatorLight;
    Color textColor = isDark ? AppColors.textColorDark : AppColors.black;

    // Warna utama (Send Email)
    if (isPrimary) {
      bgColor = AppColors.primaryColor; // 👈 Seragam Cyan
      textColor = Colors.white;
    }

    return ElevatedButton.icon(
      onPressed: () {
        if (title == "Add") {
          showDialog(
            context: context,
            builder: (_) => AddOpeningAccountDialog(
              parentBloc: context.read<ApproveOpeningBloc>(),
            ),
          );
        } else if (title == "Clear") {
          context.read<ApproveOpeningBloc>().add(ClearStaging());
        }
      },
      icon: Icon(icon, color: textColor, size: 18),
      label: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor, // 👈 Memakai warna dinamis
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }
}
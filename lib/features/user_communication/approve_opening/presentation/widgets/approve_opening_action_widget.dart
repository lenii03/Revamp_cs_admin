import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_bloc.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_event.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/widgets/approve_opening_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../bloc/approve_opening_state.dart';

class ApproveOpeningActionWidget extends StatelessWidget {
  const ApproveOpeningActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApproveOpeningBloc, ApproveOpeningState>(
      listenWhen: (previous, current) =>
          current is ApproveOpeningLoaded && current.notification != null,
      listener: (context, state) {
        final loaded = state as ApproveOpeningLoaded;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loaded.notification!),
            backgroundColor: loaded.notificationIsError
                ? AppColors.destructiveRedDark
                : Colors.green,
          ),
        );
      },
      builder: (context, state) {
        final isSending = state is ApproveOpeningLoaded && state.isSending;
        return Column(
          children: [
            Row(
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
                      disabled: isSending,
                    ),
                    _buildActionButton(
                      context,
                      "Send Email To All",
                      Icons.mark_email_read_outlined,
                      isPrimary: true,
                      disabled: isSending,
                    ),
                  ],
                ),
              ],
            ),
            if (isSending) ...[
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: AppColors.primaryColor),
              const SizedBox(height: 4),
              const Text('Sending email...'),
            ],
          ],
        );
      },
    );
  }

  Future<bool> _confirm(BuildContext context, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Confirmation'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Continue'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showValidationPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF161B22),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 64,
              ),
              const SizedBox(height: 24),
              const Text(
                'Loading',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAction(BuildContext context, String title) async {
    final bloc = context.read<ApproveOpeningBloc>();
    if (title == "Add") {
      await showDialog<void>(
        context: context,
        builder: (_) => AddOpeningAccountDialog(parentBloc: bloc),
      );
      return;
    }

    final state = bloc.state;
    final data = state is ApproveOpeningLoaded ? state.data : const [];

    if (title == "Remove") {
      final selected = bloc.selectedAccount;
      if (selected == null) {
        _showValidationPopup(context, 'Please select a Login Id first!');
      } else {
        bloc.add(RemoveFromStaging(selected));
      }
      return;
    }

    if (title == "Clear") {
      if (data.isEmpty) {
        _showValidationPopup(context, 'Data sudah kosong');
      } else if (await _confirm(context, 'Hapus semua data yang dipilih?')) {
        bloc.add(ClearStaging());
      }
      return;
    }

    if (title == "Send Email") {
      final selected = bloc.selectedAccount;
      if (selected == null) {
        _showValidationPopup(context, 'Please select a Login Id first!');
      } else if (await _confirm(
        context,
        'Kirim email untuk Account ID ${selected.custId} ke ${selected.email}?',
      )) {
        bloc.add(
          SendEmailOpeningAccount(
            loginId: selected.loginId,
            custId: selected.custId,
          ),
        );
      }
      return;
    }

    if (title == "Send Email To All") {
      if (data.isEmpty) {
        _showValidationPopup(context, 'Tidak ada data untuk dikirim');
      } else if (await _confirm(
        context,
        'Kirim email untuk ${data.length > 10 ? 10 : data.length} data? Maksimal 10 data per proses.',
      )) {
        bloc.add(SendEmailOpeningAccountToAll());
      }
    }
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon, {
    bool isPrimary = false,
    bool disabled = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor = isDark ? const Color(0xFF2A2A36) : AppColors.separatorLight;
    Color textColor = isDark ? AppColors.textColorDark : AppColors.black;

    if (isPrimary) {
      bgColor = AppColors.primaryColor;
      textColor = Colors.white;
    }

    return ElevatedButton.icon(
      onPressed: disabled ? null : () => _handleAction(context, title),
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
}

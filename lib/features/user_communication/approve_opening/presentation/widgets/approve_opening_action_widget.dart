import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_bloc.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_event.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/widgets/approve_opening_account_dialog.dart';
import 'package:el_csadmin/shared/widgets/app_notice_dialog.dart';
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
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 780;
                final managementActions = Wrap(
                  spacing: 12.0,
                  runSpacing: 8,
                  children: [
                    _buildActionButton(
                      context,
                      "Add",
                      Icons.add,
                      disabled: isSending,
                    ),
                    _buildActionButton(
                      context,
                      "Remove",
                      Icons.remove,
                      disabled: isSending,
                    ),
                    _buildActionButton(
                      context,
                      "Clear",
                      Icons.clear_all,
                      disabled: isSending,
                    ),
                  ],
                );
                final emailActions = Wrap(
                  spacing: 12.0,
                  runSpacing: 8,
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
                );

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      managementActions,
                      const SizedBox(height: 10),
                      emailActions,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [managementActions, emailActions],
                );
              },
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
          builder: (dialogContext) => AppConfirmationDialog(
            title: 'Confirmation',
            message: message,
          ),
        ) ??
        false;
  }

  void _showValidationPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AppNoticeDialog(
        title: 'Attention',
        message: message,
        type: AppNoticeType.warning,
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
        _showValidationPopup(context, 'There is no data to remove');
      } else if (await _confirm(context, 'Remove all selected data?')) {
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
        'Send an email for Account ID ${selected.custId} to ${selected.email}?',
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
        _showValidationPopup(context, 'No data available to send');
      } else if (await _confirm(
        context,
        'Send emails for ${data.length > 10 ? 10 : data.length} records? A maximum of 10 records is allowed per process.',
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

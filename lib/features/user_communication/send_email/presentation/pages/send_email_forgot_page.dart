import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_bloc.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_event.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_state.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/send_email_forgot_table_widget.dart';

class SendEmailForgotPage extends StatelessWidget {
  const SendEmailForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<SendEmailForgotBloc>()..add(FetchSendEmailData()),
      child: BlocConsumer<SendEmailForgotBloc, SendEmailForgotState>(
        listener: (context, state) {
          if (state.status == SendEmailForgotStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == SendEmailForgotStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final titleColor = Theme.of(context).textTheme.bodyLarge?.color ??
              AppColors.textColorDark;
          final pendingCount = state.dataList
              .where((item) => item.status == 1)
              .length;
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Send Email Forgot PIN & Password (${state.dataList.length})",
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (pendingCount > 0) ...[
                      OutlinedButton.icon(
                        onPressed: state.status == SendEmailForgotStatus.loading
                            ? null
                            : () => _confirmClearPending(
                                context,
                                pendingCount,
                              ),
                        icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                        label: Text('Clear Pending ($pendingCount)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.destructiveRedDark,
                          side: const BorderSide(
                            color: AppColors.destructiveRedDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    IconButton(
                      tooltip: 'Refresh',
                      onPressed: () => context.read<SendEmailForgotBloc>().add(
                        FetchSendEmailData(),
                      ),
                      icon: const Icon(
                        Icons.refresh,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: switch (state.status) {
                    SendEmailForgotStatus.loading when state.dataList.isEmpty =>
                      const Center(child: CircularProgressIndicator()),
                    SendEmailForgotStatus.failure => Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.destructiveRedDark,
                        ),
                      ),
                    ),
                    _ => SendEmailForgotTableWidget(
                      key: ValueKey(
                        state.dataList
                            .map(
                              (item) =>
                                  '${item.loginId}:${item.actionType}:${item.status}',
                            )
                            .join('|'),
                      ),
                      dataList: state.dataList,
                    ),
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmClearPending(
    BuildContext context,
    int pendingCount,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Pending Requests?'),
        content: Text(
          'This will permanently remove $pendingCount pending request${pendingCount == 1 ? '' : 's'} from local CS Admin history. It will not affect the server.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.destructiveRedDark,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear Pending'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<SendEmailForgotBloc>().add(const ClearPendingRequests());
    }
  }
}

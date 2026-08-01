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
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE HEADER
                Row(
                  children: [
                    Text(
                      "Send Email Forgot PIN & Password (${state.dataList.length})",
                      style: const TextStyle(
                        color: AppColors.textColorDark,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
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
}

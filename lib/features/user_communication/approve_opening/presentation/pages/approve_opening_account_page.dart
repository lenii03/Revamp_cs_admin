import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../injector.dart';
import '../bloc/approve_opening_bloc.dart';
import '../bloc/approve_opening_event.dart';
import '../widgets/approve_opening_table_widget.dart';
import '../widgets/approve_opening_action_widget.dart';

class ApproveOpeningAccountPage extends StatelessWidget {
  const ApproveOpeningAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Ambil warna teks dinamis berdasarkan tema
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return BlocProvider(
      create: (context) => locator<ApproveOpeningBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Approval Opening Accounts',
              style: TextStyle(
                color: textColor, // 👈 Berubah jadi dinamis
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // TODO: Tambahkan TopBar (Search Box) di sini nanti
            const Expanded(child: ApproveOpeningTableWidget()),
            const SizedBox(height: 24),
            const ApproveOpeningActionWidget(),
          ],
        ),
      ),
    );
  }
}

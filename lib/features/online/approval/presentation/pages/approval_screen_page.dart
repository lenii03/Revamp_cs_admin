import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_event.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/widgets/aproval_table_widgets.dart';
import 'package:el_csadmin/features/online/approval/presentation/widgets/aproval_top_bar_widgets.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalScreenPage extends StatelessWidget {
  final bool showBackButton;

  const ApprovalScreenPage({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              locator<ApprovalScreenBloc>()
                ..add(const ApprovalScreenEvent.fetchApprovals()),
        ),
        BlocProvider(create: (context) => locator<OnlineIdBloc>()),
      ],
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact =
                constraints.maxHeight < 850 || constraints.maxWidth < 1100;
            final padding = compact ? 16.0 : 32.0;
            final spacing = compact ? 16.0 : 24.0;

            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ApprovalTopBarWidget(showBackButton: showBackButton),
                  SizedBox(height: spacing),
                  const Expanded(child: ApprovalTableWidget()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

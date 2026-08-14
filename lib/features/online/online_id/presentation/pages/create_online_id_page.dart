import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_event.dart';
import 'package:el_csadmin/features/online/online_id/presentation/widgets/online_id_action_buttons_widget.dart';
import 'package:el_csadmin/features/online/online_id/presentation/widgets/online_id_table_widget.dart';
import 'package:el_csadmin/features/online/online_id/presentation/widgets/online_id_top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injector.dart';
import '../bloc/online_id_bloc.dart';

class CreateOnlineIdPage extends StatelessWidget {
  const CreateOnlineIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<OnlineIdBloc>()..add(const OnlineIdEvent.fetchOnlineIds()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 700;
          final padding = compact ? 12.0 : 32.0;
          final spacing = compact ? 12.0 : 24.0;
          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnlineIdTopBarWidget(),
                SizedBox(height: spacing),
                const Expanded(child: OnlineIdTableWidget()),
                SizedBox(height: spacing),
                const OnlineIdActionButtonsWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

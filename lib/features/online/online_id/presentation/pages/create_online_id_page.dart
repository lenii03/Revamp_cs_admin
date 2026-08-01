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
      child: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnlineIdTopBarWidget(),
            SizedBox(height: 24),
            Expanded(child: OnlineIdTableWidget()),
            SizedBox(height: 24),
            OnlineIdActionButtonsWidget(),
          ],
        ),
      ),
    );
  }
}

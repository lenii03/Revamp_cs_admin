import 'package:el_csadmin/features/cs/cs_logs/presentation/bloc/cs_logs_bloc.dart';
import 'package:el_csadmin/features/cs/cs_logs/presentation/bloc/cs_logs_event.dart';
import 'package:el_csadmin/features/cs/cs_logs/presentation/widgets/cs_logs.pagination.dart';
import 'package:el_csadmin/features/cs/cs_logs/presentation/widgets/cs_logs_table_widget.dart';
import 'package:el_csadmin/features/cs/cs_logs/presentation/widgets/cs_logs_top_bar.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowCsLogsPage extends StatelessWidget {
  const ShowCsLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CsLogsBloc>()..add(const FetchCsLogsEvent()),
      child: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CsLogsTopBar(),
            SizedBox(height: 24),
            Expanded(child: CsLogsTableWidget()),
            SizedBox(height: 12),
            CsLogsPaginationWidget(),
          ],
        ),
      ),
    );
  }
}

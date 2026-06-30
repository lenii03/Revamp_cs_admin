import 'package:el_csadmin/features/cs/manage_cs/presentation/widgets/manage_cs_pagination.dart';
import 'package:el_csadmin/features/cs/manage_cs/presentation/widgets/manage_cs_table_widget.dart';
import 'package:el_csadmin/features/cs/manage_cs/presentation/widgets/manage_cs_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injector.dart';
import '../bloc/manage_cs_bloc.dart';
import '../bloc/manage_cs_event.dart';

class ManageCsPage extends StatelessWidget {
  const ManageCsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ManageCsBloc>()..add(FetchCsList()),
      child: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ManageCsTopBar(),
            SizedBox(height: 24),
            Expanded(
              child: ManageCsTableWidget()
            ),
            SizedBox(height: 12),
            ManageCsPaginationWidget(),
          ],
        ),
      ),
    );
  }
}
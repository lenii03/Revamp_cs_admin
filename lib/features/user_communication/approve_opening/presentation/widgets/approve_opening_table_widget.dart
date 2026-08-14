import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../shared/widgets/app_data_grid.dart';
import '../bloc/approve_opening_bloc.dart';
import '../bloc/approve_opening_event.dart';
import '../bloc/approve_opening_state.dart';
import '../../data/models/approve_opening_account_model.dart';

class ApproveOpeningTableWidget extends StatelessWidget {
  const ApproveOpeningTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final labelColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: separatorColor),
      ),
      child: BlocBuilder<ApproveOpeningBloc, ApproveOpeningState>(
        builder: (context, state) {
          if (state is ApproveOpeningLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is ApproveOpeningError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${state.message}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.destructiveRedDark),
              ),
            );
          } else if (state is ApproveOpeningLoaded) {
            return _buildTable(context, state.data);
          }
          return Center(
            child: Text(
              "Memuat data tabel...",
              style: TextStyle(color: labelColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTable(
    BuildContext context,
    List<ApproveOpeningAccountModel> dataList,
  ) {
    final List<TrinaColumn> columns = [
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Login Id',
        field: 'loginId',
        type: TrinaColumnType.text(),
        width: 100,
        readOnly: true,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Account Id',
        field: 'custId',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        frozen: TrinaColumnFrozen.start,
        title: 'Name',
        field: 'name',
        type: TrinaColumnType.text(),
        width: 200,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'RDN Account',
        field: 'rdnAccount',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'RDN Bank',
        field: 'rdnBank',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Investor No',
        field: 'investorNo',
        type: TrinaColumnType.text(),
        width: 150,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'KSEI Id',
        field: 'kseiId',
        type: TrinaColumnType.text(),
        width: 120,
        readOnly: true,
      ),
      TrinaColumn(
        title: 'Email',
        field: 'email',
        type: TrinaColumnType.text(),
        width: 200,
        readOnly: true,
      ),
    ];

    final List<TrinaRow> rows = dataList.map((data) {
      return TrinaRow(
        cells: {
          'loginId': TrinaCell(value: data.loginId),
          'custId': TrinaCell(value: data.custId),
          'name': TrinaCell(value: data.name),
          'rdnAccount': TrinaCell(value: data.rdnAccount),
          'rdnBank': TrinaCell(value: data.rdnBank),
          'investorNo': TrinaCell(value: data.investorNo),
          'kseiId': TrinaCell(value: data.kseiId),
          'email': TrinaCell(value: data.email),
        },
      );
    }).toList();

    return AppDataGrid(
      key: ValueKey(dataList.length),
      mode: TrinaGridMode.selectWithOneTap,
      columns: columns,
      rows: rows,
      onSelected: (event) {
        final loginId = event.row.cells['loginId']?.value.toString() ?? '';
        final custId = event.row.cells['custId']?.value.toString() ?? '';
        final account = dataList.firstWhere(
          (item) => item.loginId == loginId && item.custId == custId,
        );
        context.read<ApproveOpeningBloc>().add(SelectStagedAccount(account));
      },
    );
  }
}

import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../../../../injector.dart';
import '../../../cs/cs_logs/presentation/bloc/cs_logs_bloc.dart';
import '../../../cs/cs_logs/presentation/bloc/cs_logs_event.dart';
import '../../../cs/cs_logs/presentation/bloc/cs_logs_state.dart';

class DashboardRecentActivityWidget extends StatelessWidget {
  const DashboardRecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final subTextColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return BlocProvider(
      create: (context) => locator<CsLogsBloc>()
        ..add(
          const FetchCsLogsEvent(page: 1, perPage: 5),
        ), // Cukup minta 5 data
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).extension<ThemeColors>()?.appContainerBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: separatorColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Log Aktivitas CS Terbaru",
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: separatorColor, height: 1),

            Expanded(
              child: BlocBuilder<CsLogsBloc, CsLogsState>(
                builder: (context, state) {
                  if (state is CsLogsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryDark,
                      ),
                    );
                  } else if (state is CsLogsError) {
                    return Center(
                      child: Text(
                        "Gagal memuat log:\n${state.message}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.destructiveRedDark,
                        ),
                      ),
                    );
                  } else if (state is CsLogsLoaded) {
                    final logs = state.logs.take(5).toList();

                    if (logs.isEmpty) {
                      return Center(
                        child: Text(
                          "Belum ada aktivitas CS",
                          style: TextStyle(color: subTextColor),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: logs.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: separatorColor, height: 1),
                      itemBuilder: (context, index) {
                        final logData = logs[index];

                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryDark.withValues(
                              alpha: 0.1,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          title: Text(
                            logData.csLoginId,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            logData
                                .descriptions, 
                            style: TextStyle(color: subTextColor),
                          ),
                          trailing: Text(
                            logData.logTime.isNotEmpty
                                ? logData.logTime.substring(
                                    0,
                                    10,
                                  ) 
                                : "Baru saja",
                            style: TextStyle(color: subTextColor, fontSize: 12),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart'; // Wajib ada untuk memanggil ThemeColors
import '../bloc/cs_logs_bloc.dart';
import '../bloc/cs_logs_event.dart';

class CsLogsPaginationWidget extends StatefulWidget {
  const CsLogsPaginationWidget({super.key});

  @override
  State<CsLogsPaginationWidget> createState() => _CsLogsPaginationWidgetState();
}

class _CsLogsPaginationWidgetState extends State<CsLogsPaginationWidget> {
  final List<int> _perPageOptions = [10, 20, 30, 50];

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CsLogsBloc>();

    // Variabel warna dinamis
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final subTextColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Show", style: TextStyle(color: subTextColor, fontSize: 13)),
              const SizedBox(width: 8),
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: separatorColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: bloc.perPage,
                    dropdownColor: containerColor,
                    icon: Icon(Icons.arrow_drop_down, color: textColor),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    items: _perPageOptions.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value"),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          bloc.perPage = newValue;
                          bloc.currentPage = 1;
                        });
                        bloc.add(const FetchCsLogsEvent());
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Data entries",
                style: TextStyle(color: subTextColor, fontSize: 13),
              ),
            ],
          ),
          Row(
            children: [
              _buildNavButton(
                icon: Icons.first_page_rounded,
                isEnabled: bloc.currentPage > 1,
                onTap: () {
                  setState(() => bloc.currentPage = 1);
                  bloc.add(const FetchCsLogsEvent());
                },
              ),
              const SizedBox(width: 4),
              _buildNavButton(
                icon: Icons.keyboard_arrow_left_rounded,
                isEnabled: bloc.currentPage > 1,
                onTap: () {
                  setState(() => bloc.currentPage--);
                  bloc.add(const FetchCsLogsEvent());
                },
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor, // Warna cyan
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${bloc.currentPage}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildNavButton(
                icon: Icons.keyboard_arrow_right_rounded,
                isEnabled: true,
                onTap: () {
                  setState(() => bloc.currentPage++);
                  bloc.add(const FetchCsLogsEvent());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final enabledBgColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final disabledBgColor = isDark
        ? AppColors.systemBackgroundDark.withValues(alpha: 0.3)
        : AppColors.lighterGrey.withValues(alpha: 0.5);
    final borderColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final iconColor = isEnabled
        ? Theme.of(context).iconTheme.color
        : (isDark ? Colors.grey.withValues(alpha: 0.5) : Colors.grey);

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled ? enabledBgColor : disabledBgColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isEnabled ? borderColor : Colors.transparent,
          ),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
    );
  }
}

import 'dart:async'; // 👈 Tambahan import untuk Timer debouncer
import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../bloc/online_id_bloc.dart';
import '../bloc/online_id_event.dart';
import 'online_id_print_dialog.dart';

class OnlineIdTopBarWidget extends StatefulWidget {
  const OnlineIdTopBarWidget({super.key});

  @override
  State<OnlineIdTopBarWidget> createState() => _OnlineIdTopBarWidgetState();
}

class _OnlineIdTopBarWidgetState extends State<OnlineIdTopBarWidget> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final hintColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;
    final iconColor = Theme.of(context).iconTheme.color;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).extension<ThemeColors>()?.appContainerBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? AppColors.separatorDark
                    : AppColors.separatorLight,
              ),
            ),
            child: TextField(
              style: TextStyle(color: textColor, fontSize: 14),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) {
                  _debounce!.cancel();
                }
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  context.read<OnlineIdBloc>().add(
                    OnlineIdEvent.searchOnlineIds(value),
                  );
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Login ID / Email...',
                hintStyle: TextStyle(color: hintColor),
                suffixIcon: Icon(Icons.search, color: hintColor, size: 20),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => OnlineIdPrintDialog(
              repository: context.read<OnlineIdBloc>().repository,
            ),
          ),
          icon: Icon(Icons.print, color: iconColor),
          tooltip: 'Print Data',
        ),
      ],
    );
  }
}

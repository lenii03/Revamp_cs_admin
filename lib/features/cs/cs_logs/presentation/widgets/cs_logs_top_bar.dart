import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart'; // Wajib ada untuk memanggil ThemeColors
import '../bloc/cs_logs_bloc.dart';
import '../bloc/cs_logs_event.dart';

class CsLogsTopBar extends StatefulWidget {
  const CsLogsTopBar({super.key});

  @override
  State<CsLogsTopBar> createState() => _CsLogsTopBarState();
}

class _CsLogsTopBarState extends State<CsLogsTopBar> {
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _targetIdController = TextEditingController();
  String _selectedOption = 'Show All';

  final List<String> _logTypeOptions = [
    'Show All',
    'CS Login Failed',
    'CS Succeeded Login',
    'CS Logout',
    'Create New CS Id',
    'Edit CS Id',
    'Delete CS Id',
    'Create New Online Id',
    'Edit Online Id',
    'Delete Online Id',
    'Approve Online Id',
    'Reject Online Id',
    'Reset PIN',
    'Reset Password',
    'Reset PIN dan Password',
    'Sent Email Persetujuan Pembukaan Rekening',
    'Link Account',
    'Approve Link Account',
    'Send Online User Disclaimer',
    'Send Email Customer Ratio',
    'Approve Unlink Account',
    'Unlink Account',
    'Send Email Opening Account',
    'Send Email Forget PIN and Password',
  ];

  @override
  Widget build(BuildContext context) {
    // Variabel warna dinamis
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final hintColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return Row(
      children: [
        // 1. Kotak Pencarian CS Login ID
        Expanded(
          flex: 2,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: separatorColor),
            ),
            child: TextField(
              controller: _loginIdController,
              style: TextStyle(color: textColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'CS Login ID',
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
        const SizedBox(width: 16),

        // 2. Kotak Pencarian Target ID
        Expanded(
          flex: 2,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: separatorColor),
            ),
            child: TextField(
              controller: _targetIdController,
              style: TextStyle(color: textColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Target ID',
                hintStyle: TextStyle(color: hintColor),
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
        const SizedBox(width: 16),

        // 3. Dropdown Option
        Expanded(
          flex: 2,
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: separatorColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedOption,
                isExpanded: true,
                menuMaxHeight: 400,
                dropdownColor: containerColor,
                icon: Icon(Icons.arrow_drop_down, color: textColor),
                style: TextStyle(color: textColor, fontSize: 14),
                items: _logTypeOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() => _selectedOption = newValue!);
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // 4. Tombol Search
        ElevatedButton(
          onPressed: () {
            int selectedIndex = _logTypeOptions.indexOf(_selectedOption);
            int apiLogType = selectedIndex - 1;
            context.read<CsLogsBloc>().add(
              FetchCsLogsEvent(
                loginId: _loginIdController.text,
                targetId: _targetIdController.text,
                logType: apiLogType,
                page: 1,
                perPage: context.read<CsLogsBloc>().perPage,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor, // Warna cyan
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Search",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Teks putih
            ),
          ),
        ),
      ],
    );
  }
}

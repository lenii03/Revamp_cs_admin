import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../bloc/manage_cs_bloc.dart';
import '../bloc/manage_cs_event.dart';
import 'manage_cs_add_dialog.dart';

class ManageCsTopBar extends StatelessWidget {
  const ManageCsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 300,
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).extension<ThemeColors>()?.appContainerBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.separatorDark
                  : AppColors.separatorLight,
            ),
          ),
          child: TextField(
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 14,
            ),
            onChanged: (value) =>
                context.read<ManageCsBloc>().add(SearchCsUser(value)),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Theme.of(
                  context,
                ).extension<ThemeColors>()?.unselectedLabel,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(
                  context,
                ).extension<ThemeColors>()?.unselectedLabel,
                size: 20,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return AddCsUserDialog(
                  blocContext: context,
                  onSubmit: (Map<String, dynamic> formData) {
                    context.read<ManageCsBloc>().add(AddCsUser(formData));
                    Navigator.of(dialogContext).pop();
                  },
                );
              },
            );
          },
          icon: const Icon(Icons.add, color: Colors.white, size: 20),
          label: const Text(
            "Add New User",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

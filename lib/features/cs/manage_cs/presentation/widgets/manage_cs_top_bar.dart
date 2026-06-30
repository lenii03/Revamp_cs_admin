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
        // --- SEARCH BAR ---
        Container(
          width: 300,
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.systemGroupedBackgroundDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.separatorDark),
          ),
          child: TextField(
            style: const TextStyle(
              color: AppColors.textColorDark,
              fontSize: 14,
            ),
            onChanged: (value) =>
                context.read<ManageCsBloc>().add(SearchCsUser(value)),
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: AppColors.secondaryTextColorDark),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.secondaryTextColorDark,
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
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
          icon: const Icon(Icons.add, color: AppColors.textColorDark, size: 20),
          label: const Text(
            "Add New User",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textColorDark,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
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

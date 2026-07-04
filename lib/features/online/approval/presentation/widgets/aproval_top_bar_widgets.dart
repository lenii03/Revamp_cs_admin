import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApprovalTopBarWidget extends StatelessWidget {
  const ApprovalTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Kotak Search
        Expanded(
          flex: 4,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.systemGroupedBackgroundDark,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.separatorDark),
            ),
            child: const TextField(
              style: TextStyle(color: AppColors.textColorDark, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: AppColors.secondaryTextColorDark),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.textColorDark,
                  size: 18,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // 2. Dropdown Action
        const Text(
          'Action',
          style: TextStyle(
            color: AppColors.secondaryTextColorDark,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _buildFilterDropdown(['Show All', 'Add', 'Edit', 'Delete']),
        ),
        const SizedBox(width: 16),

        // 3. Dropdown Status
        const Text(
          'Status',
          style: TextStyle(
            color: AppColors.secondaryTextColorDark,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _buildFilterDropdown([
            'Show All',
            'Pending',
            'Approved',
            'Rejected',
          ]),
        ),

        const Spacer(flex: 1), // Sisa ruang kosong
        // 4. Tombol Print
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.print, color: AppColors.textColorDark),
          tooltip: 'Print Data',
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(List<String> items) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.first,
          isExpanded: true,
          dropdownColor: AppColors.systemGroupedBackgroundDark,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          style: const TextStyle(color: Colors.white, fontSize: 13),
          onChanged: (String? newValue) {}, // Nanti dihubungkan dengan BLoC
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}

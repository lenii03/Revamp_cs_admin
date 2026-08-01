import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApprovalTopBarWidget extends StatelessWidget {
  const ApprovalTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: textColor),
          tooltip: 'Kembali',
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: separatorColor),
            ),
            child: TextField(
              style: TextStyle(color: textColor, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: hintColor),
                prefixIcon: Icon(Icons.search, color: hintColor, size: 18),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // 2. Dropdown Action
        Text('Action', style: TextStyle(color: hintColor, fontSize: 13)),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _buildFilterDropdown(
            context,
            ['Show All', 'Add', 'Edit', 'Delete'],
            containerColor,
            separatorColor,
            textColor,
          ),
        ),
        const SizedBox(width: 16),

        // 3. Dropdown Status
        Text('Status', style: TextStyle(color: hintColor, fontSize: 13)),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _buildFilterDropdown(
            context,
            ['Show All', 'Pending', 'Approved', 'Rejected'],
            containerColor,
            separatorColor,
            textColor,
          ),
        ),

        const Spacer(flex: 1),

        // 4. Tombol Print
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.print, color: Theme.of(context).iconTheme.color),
          tooltip: 'Print Data',
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(
    BuildContext context,
    List<String> items,
    Color? bgColor,
    Color borderColor,
    Color? textColor,
  ) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.first,
          isExpanded: true,
          dropdownColor: bgColor,
          icon: Icon(Icons.arrow_drop_down, color: textColor),
          style: TextStyle(color: textColor, fontSize: 13),
          onChanged: (String? newValue) {}, // Nanti dihubungkan dengan BLoC
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}

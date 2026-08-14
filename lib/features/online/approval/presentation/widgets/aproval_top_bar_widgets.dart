import 'dart:async';

import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApprovalTopBarWidget extends StatefulWidget {
  final bool showBackButton;

  const ApprovalTopBarWidget({super.key, this.showBackButton = false});

  @override
  State<ApprovalTopBarWidget> createState() => _ApprovalTopBarWidgetState();
}

class _ApprovalTopBarWidgetState extends State<ApprovalTopBarWidget> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _action = 'Show All';
  String _status = 'Show All';

  int? get _actionType => switch (_action) {
    'Add' => 1,
    'Edit' => 2,
    'Delete' => 3,
    _ => null,
  };

  int? get _statusType => switch (_status) {
    'Rejected' => 0,
    'Pending' => 1,
    'Approved' => 2,
    _ => null,
  };

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    context.read<ApprovalScreenBloc>().applyFilters(
      search: _searchController.text,
      actionType: _actionType,
      status: _statusType,
    );
  }

  void _onSearchChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), _applyFilters);
  }

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
        if (widget.showBackButton) ...[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: textColor),
            tooltip: 'Back to Dashboard',
          ),
          const SizedBox(width: 8),
        ],
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
              controller: _searchController,
              onChanged: _onSearchChanged,
              onSubmitted: (_) => _applyFilters(),
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
            _action,
            (value) {
              setState(() => _action = value);
              _applyFilters();
            },
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
            _status,
            (value) {
              setState(() => _status = value);
              _applyFilters();
            },
          ),
        ),

        const Spacer(flex: 1),
      ],
    );
  }

  Widget _buildFilterDropdown(
    BuildContext context,
    List<String> items,
    Color? bgColor,
    Color borderColor,
    Color? textColor,
    String value,
    ValueChanged<String> onChanged,
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
          value: value,
          isExpanded: true,
          dropdownColor: bgColor,
          icon: Icon(Icons.arrow_drop_down, color: textColor),
          style: TextStyle(color: textColor, fontSize: 13),
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}

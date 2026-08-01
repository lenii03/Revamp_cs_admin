import 'dart:io';

import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/src/app_colors.dart';

class AppSidebar extends StatelessWidget {
  final bool isOpen;
  final String selectedRoute;
  final Function(String) onItemSelected;

  const AppSidebar({
    super.key,
    required this.selectedRoute,
    required this.onItemSelected,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).extension<ThemeColors>()?.appContainerBackground,
        border: Border(
          right: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _buildSingleMenu(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: "Dashboard",
                  route: 'dashboard',
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.support_agent,
                  title: "CS",
                  children: [
                    _buildSubMenu(
                      context,
                      title: "Manage CS Users",
                      route: 'manage_cs',
                    ),
                    _buildSubMenu(
                      context,
                      title: "Show CS Logs",
                      route: 'show_cs_logs',
                    ),
                  ],
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.public,
                  title: "Online",
                  children: [
                    _buildSubMenu(
                      context,
                      title: "Create Online Id",
                      route: 'create_online_id',
                    ),
                    _buildSubMenu(
                      context,
                      title: "Approval Screen",
                      route: 'approval_screen',
                    ),
                  ],
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.mail_outline,
                  title: "User Communication",
                  children: [
                    _buildSubMenu(
                      context,
                      title: "Send Email Forgot PIN",
                      route: 'send_email_forgot',
                    ),
                    _buildSubMenu(
                      context,
                      title: "Approve Opening Accounts",
                      route: 'approve_opening',
                    ),
                    // _buildSubMenu(
                    //   context,
                    //   title: "Notification Management",
                    //   route: 'notification',
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    bool isDestructive = false,
  }) {
    final isSelected = selectedRoute == route;
    final defaultColor = AppColors.textGrey;
    final color = isDestructive
        ? AppColors.errorRed
        : (isSelected ? AppColors.primaryColor : defaultColor);

    return ListTile(
      splashColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(icon, color: color, size: 20),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      selected: isSelected,
      selectedTileColor: isOpen
          ? AppColors.primaryColor.withValues(alpha: 0.1)
          : Colors.transparent,
      onTap: () => onItemSelected(route),
    );
  }

  Widget _buildExpandableMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    final defaultColor = AppColors.textWhite;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: ExpansionTile(
        splashColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20.0),
        leading: Icon(icon, color: defaultColor, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: defaultColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: defaultColor,
        collapsedIconColor: defaultColor,
        children: children,
      ),
    );
  }

  Widget _buildSubMenu(
    BuildContext context, {
    required String title,
    required String route,
  }) {
    final isSelected = selectedRoute == route;
    final defaultColor = AppColors.textGrey;

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 52.0, right: 16.0),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryColor : defaultColor,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.transparent,
      onTap: () => onItemSelected(route),
    );
  }
}

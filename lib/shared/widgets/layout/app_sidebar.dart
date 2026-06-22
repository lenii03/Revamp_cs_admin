import 'package:flutter/material.dart';
import 'package:el_csadmin/core/theme/src/app_colors.dart';

class AppSidebar extends StatelessWidget {
  final String selectedRoute;
  final Function(String) onItemSelected;

  const AppSidebar({
    super.key,
    required this.selectedRoute,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      color: AppColors.systemGroupedBackgroundDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  color: AppColors.primaryDark,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  "CS Admin",
                  style: TextStyle(
                    color: AppColors.textColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.separatorDark, height: 1),

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
                    _buildSubMenu(title: "Manage CS Users", route: 'manage_cs'),
                    _buildSubMenu(title: "Show CS Logs", route: 'show_cs_logs'),
                  ],
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.public,
                  title: "Online",
                  children: [
                    _buildSubMenu(
                      title: "Create Online Id",
                      route: 'create_online_id',
                    ),
                    _buildSubMenu(
                      title: "Approval Screen",
                      route: 'approval_screen',
                    ),
                  ],
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.analytics_outlined,
                  title: "Report",
                  children: [
                    _buildSubMenu(
                      title: "Reset Password Report",
                      route: 'report_reset_pw',
                    ),
                    _buildSubMenu(
                      title: "Report Reset PIN Code",
                      route: 'report_reset_pin',
                    ),
                    _buildSubMenu(
                      title: "Report Send Password and Pin Code",
                      route: 'report_send_pwd_pin',
                    ),
                    _buildSubMenu(
                      title: "Report Send Demo Account",
                      route: 'report_send_demo',
                    ),
                    _buildSubMenu(
                      title: "Report Linked Account",
                      route: 'report_linked_account',
                    ),
                    _buildSubMenu(
                      title: "Report Client Login Activity",
                      route: 'report_client_login',
                    ),
                  ],
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.mail_outline,
                  title: "User Communication",
                  children: [
                    _buildSubMenu(
                      title: "Send Email Forgot PIN",
                      route: 'send_email_forgot',
                    ),
                    _buildSubMenu(
                      title: "Approve Opening Accounts",
                      route: 'approve_opening',
                    ),
                    _buildSubMenu(title: "Notification", route: 'notification'),
                  ],
                ),
                _buildExpandableMenu(
                  context,
                  icon: Icons.settings_outlined,
                  title: "Configurations",
                  children: [
                    _buildSubMenu(
                      title: "Push Notification",
                      route: 'push_notif',
                    ),
                    _buildSubMenu(
                      title: "Scheduler Notification",
                      route: 'scheduler_notif',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.separatorDark, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildSingleMenu(
              context,
              icon: Icons.logout,
              title: "Keluar",
              route: 'logout',
              isDestructive: true,
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
    final color = isDestructive
        ? AppColors.destructiveRedDark
        : (isSelected
              ? AppColors.primaryDark
              : AppColors.secondaryTextColorDark);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ), // Padding dirapatkan
      leading: Icon(icon, color: color, size: 20),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected || isDestructive
              ? AppColors.textColorDark
              : AppColors.secondaryTextColorDark,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primaryDark.withOpacity(0.1),
      onTap: () => onItemSelected(route),
    );
  }

  Widget _buildExpandableMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ), // Padding dirapatkan
        leading: Icon(icon, color: AppColors.secondaryTextColorDark, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryTextColorDark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: AppColors.secondaryTextColorDark,
        collapsedIconColor: AppColors.secondaryTextColorDark,
        children: children,
      ),
    );
  }

  Widget _buildSubMenu({required String title, required String route}) {
    final isSelected = selectedRoute == route;
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 52.0,
        right: 16.0,
      ), // Jarak indentasi disesuaikan
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? AppColors.primaryDark
              : AppColors.secondaryTextColorDark,
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

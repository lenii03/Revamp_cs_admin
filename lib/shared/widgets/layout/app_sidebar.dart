import 'package:el_csadmin/core/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/src/app_colors.dart';

class AppSidebar extends StatefulWidget {
  const AppSidebar({
    super.key,
    required this.isOpen,
    required this.selectedRoute,
    required this.onItemSelected,
    this.onExpandRequested,
    this.onToggleRequested,
    this.expandedWidth = 260,
  });

  final bool isOpen;
  final String selectedRoute;
  final ValueChanged<String> onItemSelected;
  final VoidCallback? onExpandRequested;
  final VoidCallback? onToggleRequested;
  final double expandedWidth;

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  final Set<String> _expandedGroups = <String>{};
  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Container(
      // The parent supplies its live animated width. Keeping this container
      // aligned with that value prevents the menu from overflowing while the
      // desktop sidebar is opening or closing.
      width: widget.expandedWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<ThemeColors>()?.appContainerBackground,
        border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: Column(children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              _menu(icon: Icons.dashboard_outlined, activeIcon: Icons.dashboard_rounded, title: 'Dashboard', selected: widget.selectedRoute == 'dashboard', onTap: () => widget.onItemSelected('dashboard')),
              _group(id: 'cs', icon: Icons.support_agent_outlined, title: 'CS', routes: const [_Route('Manage CS Users', 'manage_cs'), _Route('Show CS Logs', 'show_cs_logs')]),
              _group(id: 'online', icon: Icons.public_outlined, title: 'Online', routes: const [_Route('Create Online Id', 'create_online_id'), _Route('Approval Screen', 'approval_screen')]),
              _group(id: 'communication', icon: Icons.mail_outline_rounded, title: 'User Communication', routes: const [_Route('Send Email Forgot PIN', 'send_email_forgot'), _Route('Approve Opening Accounts', 'approve_opening')]),
            ],
          ),
        ),
        _toggleButton(),
      ]),
    );
  }

  Widget _group({required String id, required IconData icon, required String title, required List<_Route> routes}) {
    final containsSelectedRoute = routes.any((item) => item.route == widget.selectedRoute);
    final expanded = widget.isOpen && (_expandedGroups.contains(id) || containsSelectedRoute);
    return Column(children: [
      _menu(
        icon: icon,
        activeIcon: icon,
        title: title,
        selected: containsSelectedRoute,
        decorateSelection: !widget.isOpen,
        trailing: widget.isOpen ? Icon(expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 20) : null,
        onTap: () {
          if (!widget.isOpen) {
            widget.onExpandRequested?.call();
            return;
          }
          setState(() => _expandedGroups.contains(id) ? _expandedGroups.remove(id) : _expandedGroups.add(id));
        },
      ),
      AnimatedSize(
        duration: _duration,
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: expanded ? Column(children: routes.map((item) => _subMenu(title: item.title, route: item.route)).toList()) : const SizedBox.shrink(),
      ),
    ]);
  }

  Widget _subMenu({required String title, required String route}) {
    final selected = widget.selectedRoute == route;
    final color = selected ? AppColors.primaryColor : Theme.of(context).extension<ThemeColors>()!.unselectedLabel;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 12, bottom: 4),
      child: _SidebarInkItem(
        selected: selected,
        borderRadius: BorderRadius.circular(8),
        onTap: () => widget.onItemSelected(route),
        child: SizedBox(
          height: 38,
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: color, fontSize: 13, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menu({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
    bool decorateSelection = true,
    Widget? trailing,
  }) {
    final color = selected ? AppColors.primaryColor : Theme.of(context).extension<ThemeColors>()!.unselectedLabel;
    final item = Padding(
      padding: EdgeInsets.fromLTRB(widget.isOpen ? 12 : 10, 0, widget.isOpen ? 12 : 10, 8),
      child: _SidebarInkItem(
        selected: selected && decorateSelection,
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: AnimatedContainer(
          duration: _duration,
          curve: Curves.easeOutCubic,
          height: widget.isOpen ? 45 : 40,
          padding: EdgeInsets.symmetric(horizontal: widget.isOpen ? 12 : 8),
          child: Row(
            mainAxisAlignment: widget.isOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(selected ? activeIcon : icon, color: color, size: 21),
              if (widget.isOpen)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              color: color,
                              fontSize: 14,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (trailing != null)
                          IconTheme(
                            data: IconThemeData(color: color),
                            child: trailing,
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    return widget.isOpen ? item : Tooltip(message: title, child: item);
  }

  Widget _toggleButton() {
    final iconColor = Theme.of(context).extension<ThemeColors>()!.unselectedLabel;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 8, 5, 16),
      child: Tooltip(
        message: widget.isOpen ? 'Collapse sidebar' : 'Expand sidebar',
        child: _SidebarInkItem(
          borderRadius: BorderRadius.circular(25),
          onTap: widget.onToggleRequested,
          child: Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Theme.of(context).colorScheme.outlineVariant)),
            child: Icon(widget.isOpen ? Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded, size: 22, color: iconColor),
          ),
        ),
      ),
    );
  }
}

class _SidebarInkItem extends StatelessWidget {
  const _SidebarInkItem({required this.child, required this.onTap, required this.borderRadius, this.selected = false});

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryColor;
    return Material(
      color: selected ? primary.withValues(alpha: 0.12) : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: borderRadius, side: selected ? BorderSide(color: primary) : BorderSide.none),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: primary.withValues(alpha: 0.12),
        highlightColor: primary.withValues(alpha: 0.06),
        child: child,
      ),
    );
  }
}

class _Route {
  const _Route(this.title, this.route);
  final String title;
  final String route;
}

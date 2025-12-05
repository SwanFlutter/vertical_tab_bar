import 'package:flutter/widgets.dart';

/// Model for navigation items in the sidebar.
class SidebarItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  SidebarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });
}

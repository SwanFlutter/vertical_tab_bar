import 'package:flutter/material.dart';

/// Model for navigation items in the sidebar.
class SidebarItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  /// Per-item override: background color when this item is selected.
  /// If null, falls back to Sidebar.selectedItemColor, then primaryColor.
  final Color? selectedColor;

  /// Per-item override: icon color when this item is selected.
  /// If null, falls back to Sidebar.selectedIconColor, then primaryColor.
  final Color? selectedIconColor;

  /// Per-item override: icon color when this item is unselected.
  /// If null, falls back to Sidebar.unselectedIconColor, then textSecondary.
  final Color? unselectedIconColor;

  /// Per-item override: text color when this item is selected.
  /// If null, falls back to Sidebar.selectedTextColor, then primaryColor.
  final Color? selectedTextColor;

  /// Per-item override: text color when this item is unselected.
  /// If null, falls back to Sidebar.unselectedTextColor, then textPrimary.
  final Color? unselectedTextColor;

  /// Optional static badge widget shown on the tab icon.
  ///
  /// For live/reactive badges (e.g. notification count from a stream),
  /// prefer [badgeBuilder] instead.
  ///
  /// Example:
  /// ```dart
  /// badge: TabBadge(count: 3)
  /// badge: TabBadge.dot()
  /// ```
  final Widget? badge;

  /// Builder for a dynamic badge widget shown on the tab icon.
  ///
  /// Called every time the tab is rebuilt, so it reflects the latest state.
  /// Takes priority over [badge] when both are provided.
  /// Return `null` to hide the badge.
  ///
  /// Example:
  /// ```dart
  /// badgeBuilder: (context) => unreadCount > 0
  ///     ? TabBadge(count: unreadCount)
  ///     : null,
  /// ```
  final Widget? Function(BuildContext context)? badgeBuilder;

  SidebarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.selectedColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.badge,
    this.badgeBuilder,
  });
}

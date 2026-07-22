import 'package:flutter/material.dart';

/// Model class for tab items
class DrawerListTile {
  /// Title text for the tab
  final String title;

  /// Icon for the tab
  final Icon icon;

  /// Optional custom text style (deprecated, use theme instead)
  final TextStyle? textStyle;

  /// Optional trailing widget (e.g. chevron, switch, badge)
  final Widget? trailing;

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

  /// Optional callback called after selection
  final VoidCallback? onTap;

  /// Whether this tab is an action button (triggers onTap but doesn't change selection)
  final bool isAction;

  const DrawerListTile({
    required this.title,
    required this.icon,
    this.textStyle,
    this.trailing,
    this.badge,
    this.badgeBuilder,
    this.onTap,
    this.isAction = false,
  });
}

import 'package:flutter/material.dart';

/// A flexible badge widget for displaying notifications, counts, or custom content
/// on tab bar items.
///
/// Examples:
/// ```dart
/// // Simple count badge
/// TabBadge(count: 5)
///
/// // Dot badge (no number)
/// TabBadge.dot()
///
/// // Custom widget badge
/// TabBadge.custom(child: Icon(Icons.star, size: 10))
///
/// // Using badgeBuilder for live updates
/// DrawerListTile(
///   badgeBuilder: (context) => TabBadge(count: messageCount),
/// )
/// ```
class TabBadge extends StatelessWidget {
  /// Number to display. If null, shows a dot (when [showDot] is true).
  final int? count;

  /// Maximum count to display before showing "99+" style text.
  final int maxCount;

  /// Background color of the badge.
  final Color? color;

  /// Text color for the count label.
  final Color? textColor;

  /// Size of the badge circle.
  final double size;

  /// Font size for the count text.
  final double? fontSize;

  /// Show as a plain dot with no number (overrides count display).
  final bool showDot;

  /// Completely custom child widget inside the badge.
  final Widget? child;

  /// Border around the badge (useful for contrast against icon).
  final Border? border;

  /// Border color shortcut — creates a solid white border by default.
  final Color? borderColor;

  /// Border width.
  final double borderWidth;

  const TabBadge({
    super.key,
    this.count,
    this.maxCount = 99,
    this.color,
    this.textColor,
    this.size = 18,
    this.fontSize,
    this.showDot = false,
    this.child,
    this.border,
    this.borderColor,
    this.borderWidth = 1.5,
  });

  /// Creates a dot-style badge (no number).
  const TabBadge.dot({
    super.key,
    this.color,
    this.size = 10,
    this.borderColor,
    this.borderWidth = 1.5,
  })  : count = null,
        maxCount = 99,
        textColor = null,
        fontSize = null,
        showDot = true,
        child = null,
        border = null;

  /// Creates a badge with a fully custom child widget.
  const TabBadge.custom({
    super.key,
    required this.child,
    this.color,
    this.size = 18,
    this.borderColor,
    this.borderWidth = 1.5,
  })  : count = null,
        maxCount = 99,
        textColor = null,
        fontSize = null,
        showDot = false,
        border = null;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? Colors.red;

    // Resolve border
    final resolvedBorder = border ??
        (borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : Border.all(color: Colors.white, width: borderWidth));

    // Dot badge
    if (showDot || (count == null && child == null)) {
      final dotSize = showDot ? size : 8.0;
      return Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
          border: resolvedBorder,
        ),
      );
    }

    // Custom child badge
    if (child != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
          border: resolvedBorder,
        ),
        child: Center(child: child),
      );
    }

    // Count badge
    final displayCount = count!;
    final label =
        displayCount > maxCount ? '$maxCount+' : '$displayCount';
    final resolvedFontSize = fontSize ?? (size * 0.55);
    // Widen badge for multi-digit counts
    final badgeWidth = label.length > 2 ? size * 1.6 : size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutBack,
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      width: badgeWidth,
      height: size,
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(size / 2),
        border: resolvedBorder,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: resolvedFontSize,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}

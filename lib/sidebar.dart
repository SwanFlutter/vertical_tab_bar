import 'package:flutter/material.dart';

import 'src/sidebar_item.dart';

/// A reusable and dynamic sidebar widget for Flutter applications.
class Sidebar extends StatefulWidget {
  /// Application title displayed in the sidebar header.
  final String appTitle;

  /// Icon for the application logo.
  final IconData logoIcon;

  /// List of navigation items to display in the sidebar.
  final List<SidebarItem> items;

  /// Primary color used for the logo gradient and selected item highlight.
  final Color primaryColor;

  /// Secondary color for the logo gradient (optional).
  final Color? secondaryColor;

  /// Initial state of the sidebar (expanded or collapsed).
  final bool initiallyExpanded;

  /// Callback for when the sidebar's expanded state changes.
  final ValueChanged<bool>? onExpandedChanged;

  /// Background color for the sidebar in light mode (optional).
  final Color? backgroundColorLight;

  /// Background color for the sidebar in dark mode (optional).
  final Color? backgroundColorDark;

  const Sidebar({
    super.key,
    required this.appTitle,
    required this.items,
    this.logoIcon = Icons.play_arrow_rounded,
    this.primaryColor = const Color(0xFF0078D4),
    this.secondaryColor,
    this.initiallyExpanded = true,
    this.onExpandedChanged,
    this.backgroundColorLight,
    this.backgroundColorDark,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpandedChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    // Default colors
    final bgColor = isDark
        ? (widget.backgroundColorDark ?? const Color(0xFF202020))
        : (widget.backgroundColorLight ?? const Color(0xFFF3F3F3));

    final borderColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E5E5);

    final textPrimary = isDark ? Colors.white : Colors.black87;
    final textSecondary = isDark ? Colors.white70 : Colors.black54;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: _isExpanded ? 220 : 72,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(context, isDark, textPrimary, theme),

          const SizedBox(height: 8),

          // Navigation Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return _buildNavItem(
                  context,
                  widget.items[index],
                  isDark,
                  textPrimary,
                  textSecondary,
                  theme,
                );
              },
            ),
          ),

          // Toggle Button
          _buildToggleButton(
            context,
            isDark,
            textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, bool isDark, Color textColor, ThemeData theme) {
    final borderColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E5E5);

    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showText = constraints.maxWidth > 100;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: showText ? 16 : 0),
            child: Row(
              mainAxisAlignment:
                  showText ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.primaryColor,
                        widget.secondaryColor ?? widget.primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.logoIcon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // App Name
                if (showText) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.appTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    SidebarItem item,
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    ThemeData theme,
  ) {
    final hoverColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : widget.primaryColor.withValues(alpha: 0.08);

    final selectedBgColor = isDark
        ? widget.primaryColor.withValues(alpha: 0.15)
        : widget.primaryColor.withValues(alpha: 0.12);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: hoverColor,
          splashColor: widget.primaryColor.withValues(alpha: 0.12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
              horizontal: _isExpanded ? 12 : 0,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: item.isSelected ? selectedBgColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final showText = constraints.maxWidth > 60;
                return Row(
                  mainAxisAlignment: showText
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.isSelected ? item.selectedIcon : item.icon,
                      size: 22,
                      color:
                          item.isSelected ? widget.primaryColor : textSecondary,
                    ),
                    if (showText) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: item.isSelected
                                ? widget.primaryColor
                                : textPrimary,
                            fontWeight: item.isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      BuildContext context, bool isDark, Color iconColor) {
    final hoverColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : widget.primaryColor.withValues(alpha: 0.08);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: _toggleSidebar,
          borderRadius: BorderRadius.circular(8),
          hoverColor: hoverColor,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              _isExpanded
                  ? Icons.chevron_left_rounded
                  : Icons.chevron_right_rounded,
              color: iconColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'src/sidebar_item.dart';

/// A reusable and dynamic sidebar widget for Flutter applications.
class Sidebar extends StatefulWidget {
  /// Application title displayed in the sidebar header.
  final String? appTitle;

  /// Icon for the application logo.
  final IconData? logoIcon;

  /// Show header section (logo and title)
  final bool showHeader;

  /// Custom header widget (overrides appTitle and logoIcon)
  final Widget? customHeader;

  /// Show brand logo in background
  final bool showBrandBackground;

  /// Brand logo path for light mode
  final String? brandLogoLight;

  /// Brand logo path for dark mode
  final String? brandLogoDark;

  /// Brand logo opacity (0.0 to 1.0)
  final double brandLogoOpacity;

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

  /// Optional footer widget to display at the bottom of the sidebar.
  final Widget? footer;

  /// User profile name for footer section
  final String? userName;

  /// User profile subtitle (e.g., role, department)
  final String? userSubtitle;

  /// User profile image URL
  final String? userImageUrl;

  /// Custom avatar widget for user profile
  final Widget? userAvatar;

  /// Show logout button in footer
  final bool showLogoutButton;

  /// Callback when logout button is pressed
  final VoidCallback? onLogout;

  /// Logout button text
  final String logoutText;

  /// Pages to display next to the sidebar
  final List<Widget>? pages;

  const Sidebar({
    super.key,
    this.appTitle,
    required this.items,
    this.logoIcon,
    this.showHeader = true,
    this.customHeader,
    this.primaryColor = const Color(0xFF0078D4),
    this.secondaryColor,
    this.initiallyExpanded = true,
    this.onExpandedChanged,
    this.backgroundColorLight,
    this.backgroundColorDark,
    this.footer,
    this.userName,
    this.userSubtitle,
    this.userImageUrl,
    this.userAvatar,
    this.showLogoutButton = false,
    this.onLogout,
    this.logoutText = 'خروج از سیستم',
    this.showBrandBackground = false,
    this.brandLogoLight,
    this.brandLogoDark,
    this.brandLogoOpacity = 0.15,
    this.pages,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late bool _isExpanded;
  late int _internalIndex;

  int get _maxIndex {
    final len =
        (widget.items.length < (widget.pages?.length ?? widget.items.length))
            ? widget.items.length
            : (widget.pages?.length ?? widget.items.length);
    return len - 1;
  }

  int get _effectiveSelectedIndex {
    final max = _maxIndex;
    if (max < 0) return 0;
    final selectedFromItems =
        widget.items.indexWhere((e) => e.isSelected == true);
    final raw = selectedFromItems >= 0 ? selectedFromItems : _internalIndex;
    if (raw < 0) return 0;
    if (raw > max) return max;
    return raw;
  }

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    final selectedFromItems =
        widget.items.indexWhere((e) => e.isSelected == true);
    _internalIndex = selectedFromItems >= 0 ? selectedFromItems : 0;
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

    final panel = AnimatedContainer(
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
          if (widget.showHeader)
            widget.customHeader ??
                _buildHeader(context, isDark, textPrimary, theme),

          const SizedBox(height: 8),

          // Navigation Items with Brand Background
          Expanded(
            child: Stack(
              children: [
                // Brand Background (Fixed near footer)
                if (widget.showBrandBackground)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20, // Near footer
                    child: Center(
                      child: Opacity(
                        opacity: widget.brandLogoOpacity,
                        child: SizedBox(
                          width: _isExpanded ? 140 : 50,
                          height: _isExpanded ? 140 : 50,
                          child: Image.asset(
                            isDark
                                ? (widget.brandLogoDark ??
                                    'assets/brand/creator_logo_dark.png')
                                : (widget.brandLogoLight ??
                                    'assets/brand/creator_logo.png'),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              if (const bool.fromEnvironment(
                                      'dart.vm.product') ==
                                  false) {
                                debugPrint('Brand logo error: $error');
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                // Scrollable Items
                ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return _buildNavItem(
                      context,
                      widget.items[index],
                      isDark,
                      textPrimary,
                      textSecondary,
                      theme,
                      index,
                    );
                  },
                ),
              ],
            ),
          ),

          // Footer Section
          if (widget.footer != null)
            widget.footer!
          else if (widget.userName != null || widget.showLogoutButton)
            _buildFooter(context, isDark, textPrimary, borderColor),

          // Toggle Button
          _buildToggleButton(
            context,
            isDark,
            textSecondary,
          ),
        ],
      ),
    );
    if (widget.pages == null || widget.pages!.isEmpty) {
      return panel;
    }
    return Row(
      children: [
        panel,
        Expanded(
          child: widget.pages![_effectiveSelectedIndex],
        ),
      ],
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
                if (widget.logoIcon != null)
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
                if (showText && widget.appTitle != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.appTitle!,
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
    int index,
  ) {
    final hoverColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : widget.primaryColor.withValues(alpha: 0.08);

    final selectedBgColor = isDark
        ? widget.primaryColor.withValues(alpha: 0.15)
        : widget.primaryColor.withValues(alpha: 0.12);
    final isSelected = (widget.pages != null && (widget.pages!.isNotEmpty))
        ? index == _effectiveSelectedIndex
        : item.isSelected;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            item.onTap();
            if (widget.pages != null && (widget.pages!.isNotEmpty)) {
              setState(() {
                _internalIndex = index;
              });
            }
          },
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
              color: isSelected ? selectedBgColor : Colors.transparent,
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
                      isSelected ? item.selectedIcon : item.icon,
                      size: 22,
                      color: isSelected ? widget.primaryColor : textSecondary,
                    ),
                    if (showText) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color:
                                isSelected ? widget.primaryColor : textPrimary,
                            fontWeight: isSelected
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

  Widget _buildFooter(
      BuildContext context, bool isDark, Color textColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // User Profile Section
          if (widget.userName != null)
            LayoutBuilder(
              builder: (context, constraints) {
                final showText = constraints.maxWidth > 100;
                final maxAvatarSize =
                    constraints.maxWidth.clamp(0.0, 40.0).toDouble();
                return ClipRect(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: widget.showLogoutButton ? 16 : 0,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox.square(
                              dimension: maxAvatarSize,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: _buildUserAvatar(),
                              ),
                            ),
                            if (showText) ...[
                              const SizedBox(width: 12),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.userName!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (widget.userSubtitle != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        widget.userSubtitle!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF617589),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          // Logout Button
          if (widget.showLogoutButton)
            LayoutBuilder(
              builder: (context, constraints) {
                final showText = constraints.maxWidth > 100;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: widget.onLogout,
                      borderRadius: BorderRadius.circular(8),
                      hoverColor: Colors.red[100],
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: showText ? 12 : 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: showText
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.red[500],
                                size: 20,
                              ),
                              if (showText) ...[
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.logoutText,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[500],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    if (widget.userAvatar != null) return widget.userAvatar!;

    if (widget.userImageUrl != null && widget.userImageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(widget.userImageUrl!),
        backgroundColor: Colors.grey[300],
      );
    }

    // Default avatar with first letter
    final firstLetter = widget.userName != null && widget.userName!.isNotEmpty
        ? widget.userName![0].toUpperCase()
        : '?';
    return CircleAvatar(
      radius: 20,
      backgroundColor: widget.primaryColor.withValues(alpha: 0.2),
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: widget.primaryColor,
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

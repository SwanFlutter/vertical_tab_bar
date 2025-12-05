// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'sidebar.dart';
import 'src/sidebar_item.dart';
import 'vertical_tab_bar_theme.dart';

export 'sidebar.dart';
export 'src/sidebar_item.dart';
export 'vertical_tab_bar_theme.dart';

/// Enhanced VerticalTabBar with responsive design and advanced theming
///
/// Features:
/// - Responsive: Drawer mode for mobile/tablet, sidebar for desktop
/// - Advanced theming: Supports gradients (linear, radial) and solid colors
/// - Smooth animations: All tab transitions are animated
/// - Customizable: Highly configurable spacing, colors, and behavior
class VerticalTabBar extends StatefulWidget {
  /// List of tabs to display
  final List<DrawerListTile> drawerListTiles;

  /// Pages corresponding to each tab
  final List<Widget> pages;

  /// Theme configuration (optional)
  final VerticalTabBarTheme? theme;

  /// Background color of the tab bar (deprecated, use theme instead)
  final Color? backgroundColor;

  /// Width of the tab bar in sidebar mode
  final double? widthTabBar;

  /// Height of the animated indicator
  final double? heightAnimatedBox;

  /// Width of the animated indicator
  final double? widthAnimatedBox;

  /// Height of each tab item
  final double? height;

  /// Horizontal padding for tabs (deprecated, use theme instead)
  final double horizontalPadding;

  /// Vertical padding for tabs (deprecated, use theme instead)
  final double verticalPadding;

  /// Selected tab color (deprecated, use theme instead)
  final Color tabColor;

  /// Unselected tab color (deprecated, use theme instead)
  final Color colorMenu;

  /// Selected menu text/icon color (deprecated, use theme instead)
  final Color? colorSelectedMenu;

  /// Divider color for sidebar right border
  final Color? dividerColor;

  /// Show divider on the right side of sidebar
  final bool showDivider;

  /// Show divider between tabs
  final bool showTabDivider;

  /// Color of divider between tabs
  final Color? tabDividerColor;

  /// Mobile breakpoint in pixels (below this = drawer mode)
  final double mobileBreakpoint;

  /// Tablet breakpoint in pixels
  final double tabletBreakpoint;

  /// Enable drawer mode for mobile/tablet
  final bool enableDrawerMode;

  /// Width of the drawer
  final double drawerWidth;

  /// Show menu button in AppBar for mobile
  final bool showMenuButton;

  /// AppBar title for mobile/tablet mode
  final Widget? appBarTitle;

  /// Custom app bar for mobile mode
  final PreferredSizeWidget? customAppBar;

  /// Actions to display in the AppBar (e.g., language switcher, theme toggle)
  final List<Widget>? appBarActions;

  const VerticalTabBar({
    super.key,
    required this.drawerListTiles,
    required this.pages,
    this.theme,
    this.backgroundColor = Colors.white,
    this.widthTabBar = 200,
    this.heightAnimatedBox = 50,
    this.widthAnimatedBox = 5,
    this.height = 60,
    this.horizontalPadding = 12,
    this.verticalPadding = 8,
    this.tabColor = const Color.fromARGB(255, 156, 202, 224),
    this.colorMenu = Colors.white,
    this.colorSelectedMenu,
    this.dividerColor,
    this.showDivider = true,
    this.showTabDivider = false,
    this.tabDividerColor,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 900,
    this.enableDrawerMode = true,
    this.drawerWidth = 280,
    this.showMenuButton = true,
    this.appBarTitle,
    this.customAppBar,
    this.appBarActions,
  });

  @override
  VerticalTabBarState createState() => VerticalTabBarState();

  static Widget sidebar({
    required String appTitle,
    required List<SidebarItem> items,
    IconData logoIcon = Icons.play_arrow_rounded,
    Color primaryColor = const Color(0xFF0078D4),
    Color? secondaryColor,
    bool initiallyExpanded = true,
    ValueChanged<bool>? onExpandedChanged,
    Color? backgroundColorLight,
    Color? backgroundColorDark,
    Key? key,
  }) {
    return Sidebar(
      key: key,
      appTitle: appTitle,
      items: items,
      logoIcon: logoIcon,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      initiallyExpanded: initiallyExpanded,
      onExpandedChanged: onExpandedChanged,
      backgroundColorLight: backgroundColorLight,
      backgroundColorDark: backgroundColorDark,
    );
  }
}

class VerticalTabBarState extends State<VerticalTabBar>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    if (widget.drawerListTiles.isNotEmpty) {
      selectedIndex = 0;
    }

    // Initialize scale animation controller for subtle bounce effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool _useDrawerMode(double width) =>
      widget.enableDrawerMode && (width < widget.tabletBreakpoint);

  void _onTabSelected(int index, {bool closeDrawer = false}) {
    if (selectedIndex == index) return;

    setState(() {
      selectedIndex = index;
    });

    // Trigger scale animation for visual feedback
    _scaleController.forward().then((_) => _scaleController.reverse());

    if (closeDrawer && _scaffoldKey.currentState?.isDrawerOpen == true) {
      Navigator.of(context).pop();
    }
  }

  /// Get icon color based on selection state
  /// When selected: always use selectedIconColor (colorSelectedMenu)
  /// When unselected: use custom icon color with reduced opacity
  Color _getIconColor({
    required bool isSelected,
    required Color? selectedIconColor,
    required Color? unselectedIconColor,
    required Color? iconColor,
  }) {
    if (isSelected) {
      // When selected, always use selectedIconColor (colorSelectedMenu)
      return selectedIconColor ?? Colors.black;
    } else {
      // When unselected, use unselectedIconColor if set
      if (unselectedIconColor != null) {
        return unselectedIconColor;
      }
      // If icon has custom color, reduce opacity
      if (iconColor != null) {
        return iconColor.withValues(alpha: 0.6);
      }
      // Default unselected color
      return Colors.black54;
    }
  }

  /// Merge custom text style with base style
  /// When selected: always use baseStyle's color (colorSelectedMenu)
  /// When unselected: use customStyle's color with reduced opacity
  TextStyle _mergeTextStyle({
    required TextStyle baseStyle,
    TextStyle? customStyle,
    required bool isSelected,
  }) {
    if (customStyle == null) return baseStyle;

    // When selected, always use baseStyle's color (colorSelectedMenu)
    if (isSelected) {
      return customStyle.copyWith(color: baseStyle.color);
    }

    // When unselected, use custom color with reduced opacity
    if (customStyle.color != null) {
      return customStyle.copyWith(
        color: customStyle.color!.withValues(alpha: 0.6),
      );
    }

    // If no custom color, use base style's color
    return customStyle.copyWith(color: baseStyle.color);
  }

  Widget _buildTabContent(
    bool isSelected,
    DrawerListTile tabItem,
    Duration animationDuration,
    Curve animationCurve,
    BoxDecoration selectedDecoration,
    BoxDecoration unselectedDecoration,
    EdgeInsets tabPadding,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    double iconSize,
    double iconTextSpacing,
    TextStyle selectedTextStyle,
    TextStyle unselectedTextStyle,
    VerticalTabBarTheme? effectiveTheme,
  ) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      height: widget.height,
      decoration: isSelected ? selectedDecoration : unselectedDecoration,
      child: Padding(
        padding: tabPadding,
        child: Row(
          children: [
            // Icon with animated color
            AnimatedOpacity(
              opacity: 1.0,
              duration: animationDuration,
              child: IconTheme(
                data: IconThemeData(
                  color: _getIconColor(
                    isSelected: isSelected,
                    selectedIconColor: selectedIconColor,
                    unselectedIconColor: unselectedIconColor,
                    iconColor: tabItem.icon.color,
                  ),
                  size: iconSize,
                ),
                child: Icon(
                  tabItem.icon.icon,
                  // Force the icon to use the color from IconTheme
                  color: null,
                ),
              ),
            ),
            SizedBox(width: iconTextSpacing),
            // Title with animated style
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: animationDuration,
                curve: animationCurve,
                style: _mergeTextStyle(
                  baseStyle:
                      isSelected ? selectedTextStyle : unselectedTextStyle,
                  customStyle: tabItem.textStyle,
                  isSelected: isSelected,
                ),
                child: Text(tabItem.title, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, {bool isInDrawer = false}) {
    final isSelected = selectedIndex == index;
    final tabItem = widget.drawerListTiles[index];

    // Get theme values or fall back to widget properties
    final effectiveTheme = widget.theme;
    final animationDuration =
        effectiveTheme?.animationDuration ?? const Duration(milliseconds: 300);
    final animationCurve = effectiveTheme?.animationCurve ?? Curves.easeInOut;

    final selectedDecoration = effectiveTheme?.selectedTabDecoration ??
        BoxDecoration(color: widget.tabColor);
    final unselectedDecoration = effectiveTheme?.unselectedTabDecoration ??
        BoxDecoration(color: widget.colorMenu);

    final indicatorColor = effectiveTheme?.indicatorColor ?? Colors.blueAccent;
    final indicatorWidth =
        effectiveTheme?.indicatorWidth ?? widget.widthAnimatedBox ?? 5;
    final indicatorHeight =
        effectiveTheme?.indicatorHeight ?? widget.heightAnimatedBox ?? 50;

    final iconTextSpacing = effectiveTheme?.iconTextSpacing ?? 12.0;
    final tabPadding = effectiveTheme?.tabPadding ??
        EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        );

    final selectedIconColor =
        effectiveTheme?.selectedIconColor ?? widget.colorSelectedMenu;
    final unselectedIconColor = effectiveTheme?.unselectedIconColor;
    final iconSize = effectiveTheme?.iconSize ?? 24.0;

    final selectedTextStyle = effectiveTheme?.selectedTextStyle ??
        TextStyle(
          color: widget.colorSelectedMenu ?? Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );
    final unselectedTextStyle = effectiveTheme?.unselectedTextStyle ??
        const TextStyle(
          color: Colors.black54,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        );

    return InkWell(
      onTap: () => _onTabSelected(index, closeDrawer: isInDrawer),
      splashColor: indicatorColor.withValues(alpha: 0.2),
      highlightColor: indicatorColor.withValues(alpha: 0.1),
      child: Row(
        children: [
          // Animated indicator bar with smooth transitions
          AnimatedContainer(
            duration: animationDuration,
            curve: animationCurve,
            height: isSelected ? indicatorHeight : 0,
            width: indicatorWidth,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(indicatorWidth / 2),
                bottomRight: Radius.circular(indicatorWidth / 2),
              ),
              boxShadow:
                  isSelected && (effectiveTheme?.enableIndicatorShadow ?? true)
                      ? [
                          BoxShadow(
                            color: indicatorColor.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(2, 0),
                          ),
                        ]
                      : null,
            ),
          ),
          // Tab content with optional scale animation
          Expanded(
            child: (effectiveTheme?.enableScaleAnimation ?? true)
                ? AnimatedScale(
                    scale: isSelected ? 1.0 : 0.98,
                    duration: animationDuration,
                    curve: animationCurve,
                    child: _buildTabContent(
                      isSelected,
                      tabItem,
                      animationDuration,
                      animationCurve,
                      selectedDecoration,
                      unselectedDecoration,
                      tabPadding,
                      selectedIconColor,
                      unselectedIconColor,
                      iconSize,
                      iconTextSpacing,
                      selectedTextStyle,
                      unselectedTextStyle,
                      effectiveTheme,
                    ),
                  )
                : _buildTabContent(
                    isSelected,
                    tabItem,
                    animationDuration,
                    animationCurve,
                    selectedDecoration,
                    unselectedDecoration,
                    tabPadding,
                    selectedIconColor,
                    unselectedIconColor,
                    iconSize,
                    iconTextSpacing,
                    selectedTextStyle,
                    unselectedTextStyle,
                    effectiveTheme,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabList({bool isInDrawer = false}) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: widget.drawerListTiles.length,
      separatorBuilder: (context, index) {
        if (!widget.showTabDivider) {
          return const SizedBox.shrink();
        }
        return Divider(
          height: 1,
          thickness: 1,
          color: widget.tabDividerColor ??
              widget.theme?.tabDividerColor ??
              Colors.grey.shade300,
        );
      },
      itemBuilder: (context, index) {
        return _buildTabItem(index, isInDrawer: isInDrawer);
      },
    );
  }

  Widget _buildSidebar() {
    return Container(
      key: const ValueKey('sidebar'),
      width: widget.widthTabBar,
      decoration: BoxDecoration(
        color: widget.theme?.backgroundColor ?? widget.backgroundColor,
        border: widget.showDivider
            ? Border(
                right: BorderSide(
                  color: widget.dividerColor ??
                      widget.theme?.dividerColor ??
                      Colors.grey.shade300,
                  width: 1,
                ),
              )
            : null,
      ),
      child: _buildTabList(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: widget.drawerWidth,
      backgroundColor: widget.theme?.backgroundColor ?? widget.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            if (widget.appBarTitle != null) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  child: widget.appBarTitle!,
                ),
              ),
              const Divider(),
            ],
            Expanded(child: _buildTabList(isInDrawer: true)),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (widget.customAppBar != null) {
      return widget.customAppBar!;
    }

    return AppBar(
      title: widget.appBarTitle ??
          Text(widget.drawerListTiles[selectedIndex].title),
      leading: widget.showMenuButton
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            )
          : null,
      actions: widget.appBarActions,
      elevation: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final useDrawer = _useDrawerMode(width);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: widget.theme?.backgroundColor ?? widget.backgroundColor,
      appBar: useDrawer ? _buildAppBar() : null,
      drawer: useDrawer ? _buildDrawer() : null,
      body: SafeArea(
        child: Row(
          children: [
            // Animated sidebar with smooth transition
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeInOutCubic,
              switchOutCurve: Curves.easeInOutCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: !useDrawer
                  ? _buildSidebar()
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
            // Main content area with animated transitions
            Expanded(
              child: AnimatedSwitcher(
                duration: widget.theme?.animationDuration ??
                    const Duration(milliseconds: 400),
                switchInCurve:
                    widget.theme?.animationCurve ?? Curves.easeInOutCubic,
                switchOutCurve:
                    widget.theme?.animationCurve ?? Curves.easeInOutCubic,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final enableFade = widget.theme?.enableFadeAnimation ?? true;
                  final enableSlide =
                      widget.theme?.enableSlideAnimation ?? true;

                  Widget result = child;

                  if (enableSlide) {
                    result = SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.03, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                      child: result,
                    );
                  }

                  if (enableFade) {
                    result = FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: result,
                    );
                  }

                  return result;
                },
                child: KeyedSubtree(
                  key: ValueKey<int>(selectedIndex),
                  child: widget.pages[selectedIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Model class for tab items
class DrawerListTile {
  /// Title text for the tab
  final String title;

  /// Icon for the tab
  final Icon icon;

  /// Optional custom text style (deprecated, use theme instead)
  final TextStyle? textStyle;

  const DrawerListTile({
    required this.title,
    required this.icon,
    this.textStyle,
  });
}

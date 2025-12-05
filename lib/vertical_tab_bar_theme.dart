import 'package:flutter/material.dart';

/// Theme configuration for VerticalTabBar widget
/// Supports solid colors, linear gradients, and radial gradients
class VerticalTabBarTheme {
  /// Decoration for selected tab (supports gradients)
  final BoxDecoration? selectedTabDecoration;

  /// Decoration for unselected tabs
  final BoxDecoration? unselectedTabDecoration;

  /// Background color of the entire tab bar
  final Color? backgroundColor;

  /// Background color for the indicator bar
  final Color? indicatorColor;

  /// Width of the animated indicator bar
  final double? indicatorWidth;

  /// Height of the animated indicator bar
  final double? indicatorHeight;

  /// Text style for selected tab
  final TextStyle? selectedTextStyle;

  /// Text style for unselected tabs
  final TextStyle? unselectedTextStyle;

  /// Icon color for selected tab
  final Color? selectedIconColor;

  /// Icon color for unselected tabs
  final Color? unselectedIconColor;

  /// Size of icons
  final double? iconSize;

  /// Spacing between icon and text
  final double iconTextSpacing;

  /// Padding inside each tab
  final EdgeInsets tabPadding;

  /// Padding inside the ListTile
  final EdgeInsets listTilePadding;

  /// Animation duration for tab transitions
  final Duration animationDuration;

  /// Animation curve for transitions
  final Curve animationCurve;

  /// Border radius for tabs
  final BorderRadius? tabBorderRadius;

  /// Elevation for selected tab
  final double? selectedTabElevation;

  /// Enable scale animation on tab selection
  final bool enableScaleAnimation;

  /// Enable fade animation on page transitions
  final bool enableFadeAnimation;

  /// Enable slide animation on page transitions
  final bool enableSlideAnimation;

  /// Enable shadow effect on indicator
  final bool enableIndicatorShadow;

  /// Divider color for sidebar right border
  final Color? dividerColor;

  /// Divider color between tabs
  final Color? tabDividerColor;

  const VerticalTabBarTheme({
    this.selectedTabDecoration,
    this.unselectedTabDecoration,
    this.backgroundColor,
    this.indicatorColor,
    this.indicatorWidth,
    this.indicatorHeight,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.iconSize,
    this.iconTextSpacing = 8.0,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.listTilePadding = const EdgeInsets.all(0),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.tabBorderRadius,
    this.selectedTabElevation,
    this.enableScaleAnimation = true,
    this.enableFadeAnimation = true,
    this.enableSlideAnimation = true,
    this.enableIndicatorShadow = true,
    this.dividerColor,
    this.tabDividerColor,
  });

  /// Create a theme with linear gradient
  factory VerticalTabBarTheme.linearGradient({
    required List<Color> gradientColors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    Color? unselectedColor,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? dividerColor,
    Color? tabDividerColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    double iconTextSpacing = 12.0,
    EdgeInsets? tabPadding,
    Duration? animationDuration,
    Curve? animationCurve,
    bool enableScaleAnimation = true,
    bool enableFadeAnimation = true,
    bool enableSlideAnimation = true,
  }) {
    return VerticalTabBarTheme(
      selectedTabDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: begin,
          end: end,
        ),
      ),
      unselectedTabDecoration: BoxDecoration(
        color: unselectedColor ?? Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      selectedTextStyle: selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle,
      selectedIconColor: selectedIconColor,
      unselectedIconColor: unselectedIconColor,
      iconTextSpacing: iconTextSpacing,
      tabPadding: tabPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      animationDuration: animationDuration ?? const Duration(milliseconds: 400),
      animationCurve: animationCurve ?? Curves.easeInOutCubic,
      enableScaleAnimation: enableScaleAnimation,
      enableFadeAnimation: enableFadeAnimation,
      enableSlideAnimation: enableSlideAnimation,
      dividerColor: dividerColor,
      tabDividerColor: tabDividerColor,
    );
  }

  /// Create a theme with radial gradient
  factory VerticalTabBarTheme.radialGradient({
    required List<Color> gradientColors,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    Color? unselectedColor,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? dividerColor,
    Color? tabDividerColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    double iconTextSpacing = 12.0,
    EdgeInsets? tabPadding,
    Duration? animationDuration,
    Curve? animationCurve,
    bool enableScaleAnimation = true,
    bool enableFadeAnimation = true,
    bool enableSlideAnimation = true,
  }) {
    return VerticalTabBarTheme(
      selectedTabDecoration: BoxDecoration(
        gradient: RadialGradient(
          colors: gradientColors,
          center: center,
          radius: radius,
        ),
      ),
      unselectedTabDecoration: BoxDecoration(
        color: unselectedColor ?? Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      selectedTextStyle: selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle,
      selectedIconColor: selectedIconColor,
      unselectedIconColor: unselectedIconColor,
      iconTextSpacing: iconTextSpacing,
      tabPadding: tabPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      animationDuration: animationDuration ?? const Duration(milliseconds: 400),
      animationCurve: animationCurve ?? Curves.easeInOutCubic,
      enableScaleAnimation: enableScaleAnimation,
      enableFadeAnimation: enableFadeAnimation,
      enableSlideAnimation: enableSlideAnimation,
      dividerColor: dividerColor,
      tabDividerColor: tabDividerColor,
    );
  }

  /// Create a theme with solid colors
  factory VerticalTabBarTheme.solid({
    required Color selectedColor,
    Color? unselectedColor,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? dividerColor,
    Color? tabDividerColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    double iconTextSpacing = 12.0,
    EdgeInsets? tabPadding,
    Duration? animationDuration,
    Curve? animationCurve,
    bool enableScaleAnimation = true,
    bool enableFadeAnimation = true,
    bool enableSlideAnimation = true,
  }) {
    return VerticalTabBarTheme(
      selectedTabDecoration: BoxDecoration(color: selectedColor),
      unselectedTabDecoration: BoxDecoration(
        color: unselectedColor ?? Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      selectedTextStyle: selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle,
      selectedIconColor: selectedIconColor,
      unselectedIconColor: unselectedIconColor,
      iconTextSpacing: iconTextSpacing,
      tabPadding: tabPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      animationDuration: animationDuration ?? const Duration(milliseconds: 400),
      animationCurve: animationCurve ?? Curves.easeInOutCubic,
      enableScaleAnimation: enableScaleAnimation,
      enableFadeAnimation: enableFadeAnimation,
      enableSlideAnimation: enableSlideAnimation,
      dividerColor: dividerColor,
      tabDividerColor: tabDividerColor,
    );
  }
}

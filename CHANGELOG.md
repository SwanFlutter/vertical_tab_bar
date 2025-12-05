## 1.0.0

### 🎉 Initial Release

### New Features
* ✨ Added `colorSelectedMenu` parameter to customize selected tab icon and text color
* ✨ Added `dividerColor` parameter to customize the vertical divider color on the right side of sidebar
* ✨ Added `showDivider` parameter to show/hide the vertical divider (default: true)
* ✨ Fixed `textStyle` parameter in `DrawerListTile` - now properly applies custom text styles
* 🎨 Removed horizontal dividers between tabs for cleaner UI
* 🎨 Added vertical divider on the right side of sidebar to separate it from content
* 🔧 Custom text styles now merge with theme styles for better flexibility

* ✨ Vertical tab bar with smooth animations
* 📱 Responsive design (drawer for mobile, sidebar for desktop)
* 🎨 Multiple theme options (solid, linear gradient, radial gradient)
* ⚡ Customizable animations with full control
* 🎯 Highly configurable appearance and behavior
* 🌐 RTL support
* 📚 Complete documentation and examples

### Features

#### Animations
- Smooth tab transitions with scale, fade, and slide effects
- Animated indicator with shadow support
- Configurable animation duration and curves
- Individual animation toggles (scale, fade, slide, shadow)

#### Themes
- `VerticalTabBarTheme.solid()` - Solid color themes
- `VerticalTabBarTheme.linearGradient()` - Linear gradient themes
- `VerticalTabBarTheme.radialGradient()` - Radial gradient themes
- Full customization of colors, text styles, and spacing

#### Responsive Design
- Automatic drawer mode for mobile devices
- Sidebar mode for desktop/tablet
- Configurable breakpoints
- Custom AppBar support

#### Customization
- Tab appearance (colors, decorations, padding)
- Indicator style (width, height, color, shadow)
- Icon and text styling
- Animation settings
- Responsive behavior

### Example

```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(title: 'Home', icon: Icon(Icons.home)),
    DrawerListTile(title: 'Profile', icon: Icon(Icons.person)),
  ],
  pages: [
    HomePage(),
    ProfilePage(),
  ],
  theme: VerticalTabBarTheme.linearGradient(
    gradientColors: [Colors.purple.shade300, Colors.blue.shade300],
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOutCubic,
  ),
)
```

### Documentation

- Complete README in English and Persian (فارسی)
- Full API documentation
- Working example app
- Usage guide with multiple examples

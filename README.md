# Vertical Tab Bar

A professional Flutter package for creating vertical tab bars with smooth animations and responsive design.

[فارسی](README_FA.md) | English

## Features ✨

- 🎨 **Smooth Professional Animations** - Beautiful transitions between tabs
- 📱 **Responsive Design** - Drawer mode for mobile, Sidebar for desktop
- 🎭 **Powerful Themes** - Support for solid colors, linear and radial gradients
- ⚙️ **Highly Customizable** - Full control over appearance and behavior
- 🧠 **State Preservation** - Optional keep-alive pages to preserve state
- 🎛️ **Controlled / Uncontrolled** - Use `selectedIndex` + `onTabChanged`
- 🧩 **Tab Extensions** - Badge, trailing widget, and per-tab `onTap`
- 🧱 **Slots** - Header/Footer for Sidebar and Drawer
- 🚀 **Optimized Performance** - Fast and smooth operation
- 🌐 **RTL Support** - Full support for right-to-left languages

## Installation 📦

Add to your `pubspec.yaml`:

```yaml
dependencies:
  vertical_tab_bar: ^latest_version
```

Then run:

```bash
flutter pub get
```

## Installation from GitHub 🔧

To use the latest development version directly from GitHub, add this to your `pubspec.yaml`:

```yaml
dependencies:
  vertical_tab_bar:
    git:
      url: https://github.com/SwanFlutter/vertical_tab_bar.git
      ref: main
```

Then run:

```bash
flutter pub get
```

## Quick Start 🚀

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerticalTabBar(
      drawerListTiles: [
        DrawerListTile(
          title: 'Home',
          icon: Icon(Icons.home),
        ),
        DrawerListTile(
          title: 'Profile',
          icon: Icon(Icons.person),
        ),
        DrawerListTile(
          title: 'Settings',
          icon: Icon(Icons.settings),
        ),
      ],
      pages: [
        Center(child: Text('Home Page')),
        Center(child: Text('Profile Page')),
        Center(child: Text('Settings Page')),
      ],
    );
  }
}
```

### Controlled + Keep Alive Example

```dart
class ControlledTabsExample extends StatefulWidget {
  const ControlledTabsExample({super.key});

  @override
  State<ControlledTabsExample> createState() => _ControlledTabsExampleState();
}

class _ControlledTabsExampleState extends State<ControlledTabsExample> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return VerticalTabBar(
      drawerListTiles: const [
        DrawerListTile(title: 'Home', icon: Icon(Icons.home)),
        DrawerListTile(title: 'Profile', icon: Icon(Icons.person)),
      ],
      pages: const [
        Center(child: Text('Home Page')),
        Center(child: Text('Profile Page')),
      ],
      selectedIndex: selectedIndex,
      onTabChanged: (i) => setState(() => selectedIndex = i),
      keepAlivePages: true,
    );
  }
}
```

### Badge / Trailing / onTap Example

```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(
      title: 'Messages',
      icon: const Icon(Icons.message),
      badge: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Text(
          '12',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  ],
  pages: const [Center(child: Text('Messages Page'))],
)
```

### Slots + Custom Tab Builder Example

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  sidebarHeader: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Sidebar Header'),
  ),
  sidebarFooter: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Sidebar Footer'),
  ),
  drawerHeader: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Drawer Header'),
  ),
  drawerFooter: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Drawer Footer'),
  ),
  emptyState: const Center(child: Text('No tabs to display')),
  tabBuilder: (context, index, isSelected, item, isInDrawer) {
    final color = isSelected ? Colors.white : Colors.black87;
    return Row(
      children: [
        Icon(item.icon.icon, color: color),
        const SizedBox(width: 12),
        Expanded(child: Text(item.title, style: TextStyle(color: color))),
        if (item.trailing != null) item.trailing!,
      ],
    );
  },
)
```

### Action Buttons (Navigation Only)

Use `isAction: true` to create a button that triggers `onTap` without changing the selected tab (e.g., a "Home" button that navigates to a different route).

```dart
VerticalTabBar(
  initialIndex: 1, // Start at Dashboard (since index 0 is an action)
  drawerListTiles: [
    // Index 0: Home Button (Navigation Only)
    DrawerListTile(
      title: 'Home',
      icon: Icon(Icons.home),
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      isAction: true, // <--- Prevents tab selection
    ),
    // Index 1: Dashboard
    DrawerListTile(
      title: 'Dashboard',
      icon: Icon(Icons.dashboard),
    ),
  ],
  pages: [
    SizedBox(), // Placeholder for Home button
    DashboardPage(),
  ],
)
```

### AppBar Actions Example

Add custom actions to the AppBar (language switcher, theme toggle, etc.):

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  appBarTitle: Text('My App'),
  appBarActions: [
    // Language switcher
    PopupMenuButton<String>(
      icon: Icon(Icons.language),
      tooltip: 'Language',
      onSelected: (String value) {
        // Handle language change
        if (value == 'en') {
          // Switch to English
        } else if (value == 'fa') {
          // Switch to Persian
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              Icon(Icons.language, size: 20),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'fa',
          child: Row(
            children: [
              Icon(Icons.language, size: 20),
              SizedBox(width: 8),
              Text('فارسی'),
            ],
          ),
        ),
      ],
    ),
    // Theme toggle
    IconButton(
      icon: Icon(Icons.dark_mode),
      tooltip: 'Toggle Theme',
      onPressed: () {
        // Toggle theme logic
      },
    ),
  ],
)
```

### Sidebar Widget Example

Use the `VerticalTabBar.sidebar()` method for a dedicated sidebar component:

Run:

```bash
cd example
flutter run -t lib/sidebar_widget_example.dart
```

```dart
import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          VerticalTabBar.sidebar(
            appTitle: 'My App',
            items: [
              SidebarItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
                isSelected: true,
                onTap: () {
                  // Handle selection
                },
              ),
              SidebarItem(
                icon: Icons.download_outlined,
                selectedIcon: Icons.download,
                label: 'Downloads',
                isSelected: false,
                onTap: () {
                  // Handle selection
                },
              ),
              SidebarItem(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings,
                label: 'Settings',
                isSelected: false,
                onTap: () {
                  // Handle selection
                },
              ),
            ],
            primaryColor: Colors.blue,
            secondaryColor: Colors.purple,
            initiallyExpanded: true,
            onExpandedChanged: (isExpanded) {
              // Handle expansion state change
            },
          ),
          Expanded(
            child: Center(
              child: Text('Main Content'),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Examples

Run the advanced example to try all new features:

```bash
cd example
flutter run -t lib/advanced_features_example.dart
```


### Sidebar with Profile and Logout

Use the enhanced sidebar with user profile and logout button:

```dart
VerticalTabBar.sidebar(
  appTitle: 'مدیک‌پلن',
  logoIcon: Icons.medical_services,
  showHeader: true, // Show/hide header section
  primaryColor: const Color(0xFF137FEC),
  items: [
    SidebarItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'داشبورد',
      onTap: () {},
      isSelected: true,
    ),
    SidebarItem(
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
      label: 'نوبت‌ها',
      onTap: () {},
    ),
  ],
  // User profile in footer
  userName: 'دکتر سارا احمدی',
  userSubtitle: 'متخصص داخلی',
  userImageUrl: 'https://example.com/avatar.jpg',
  showLogoutButton: true,
  logoutText: 'خروج از سیستم',
  onLogout: () {
    // Handle logout
  },
)
```

### Sidebar with Brand Background

Add your brand logo as a fixed background:

```dart
VerticalTabBar.sidebar(
  appTitle: 'My App',
  logoIcon: Icons.medical_services,
  showHeader: true,
  primaryColor: const Color(0xFF137FEC),
  // Brand background
  showBrandBackground: true,
  brandLogoLight: 'assets/brand/logo_light.png',
  brandLogoDark: 'assets/brand/logo_dark.png',
  brandLogoOpacity: 0.15, // 0.0 to 1.0 (default: 0.15)
  items: [...],
)
```

The brand logo will:
- Stay fixed near the footer (bottom of navigation items section)
- Automatically switch between light/dark versions based on theme
- Allow items to scroll over it
- Be displayed with customizable opacity (default 0.15 for better visibility)
- Adapt size based on sidebar state (140x140 when expanded, 50x50 when collapsed)

### Sidebar Header Options

```dart
// 1. With both logo and title
VerticalTabBar.sidebar(
  appTitle: 'My App',
  logoIcon: Icons.medical_services,
  showHeader: true,
  items: [...],
)

// 2. With only logo
VerticalTabBar.sidebar(
  logoIcon: Icons.medical_services,
  showHeader: true,
  items: [...],
)

// 3. With only title
VerticalTabBar.sidebar(
  appTitle: 'My App',
  showHeader: true,
  items: [...],
)

// 4. Without header
VerticalTabBar.sidebar(
  showHeader: false,
  items: [...],
)

// 5. With custom header widget
VerticalTabBar.sidebar(
  showHeader: true,
  customHeader: Container(
    height: 80,
    child: Center(
      child: Text('Custom Header'),
    ),
  ),
  items: [...],
)
```

## Sidebar Features 🎯

The enhanced `VerticalTabBar.sidebar()` provides a complete sidebar solution:

### Header Customization
- **Optional Header**: Show/hide with `showHeader` boolean
- **Flexible Content**: Use `appTitle`, `logoIcon`, or both
- **Custom Widget**: Replace with `customHeader` for full control
- **Gradient Logo**: Automatic gradient from `primaryColor` and `secondaryColor`

### Navigation Items
- **Smooth Animations**: Beautiful transitions between selected states
- **Icon States**: Different icons for selected/unselected states
- **Scrollable**: Items scroll smoothly over brand background
- **Responsive**: Adapts to collapsed/expanded states

### Brand Background
- **Fixed Position**: Logo stays near footer while items scroll
- **Theme Aware**: Automatically switches between light/dark logos
- **Customizable**: Control size, opacity, and position
- **Non-intrusive**: Items remain fully visible and interactive

### Footer Section
- **User Profile**: Display name, subtitle, and avatar
- **Auto Avatar**: Generates avatar from first letter if no image
- **Logout Button**: Always visible with red background
- **Responsive**: Adapts to sidebar width

### Responsive Behavior
- **Collapsible**: Toggle between expanded (220px) and collapsed (72px)
- **Smart Layout**: Content adapts to available width
- **No Overflow**: All elements properly constrained
- **Smooth Transitions**: 400ms animations with easeInOut curve

## Complete Dashboard Example

Check out the complete sidebar example:

```bash
cd example
flutter run -t lib/sidebar_example.dart
```

Test sidebar collapse behavior:

```bash
cd example
flutter run -t lib/sidebar_collapse_test.dart
```

Test different header configurations:

```bash
cd example
flutter run -t lib/sidebar_custom_header_example.dart
```

Test sidebar with brand background:

```bash
cd example
flutter run -t lib/sidebar_with_brand_example.dart
```

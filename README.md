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
- 🔴 **Tab Badges** - `TabBadge` widget with count, dot, and custom modes + live `badgeBuilder`
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

The old approach (raw Container) still works, but the new `TabBadge` widget is cleaner:

```dart
VerticalTabBar(
  drawerListTiles: [
    // Static count badge
    DrawerListTile(
      title: 'Messages',
      icon: const Icon(Icons.message),
      badge: TabBadge(count: 5),
    ),
    // Static dot badge (no number)
    DrawerListTile(
      title: 'Profile',
      icon: const Icon(Icons.person),
      badge: TabBadge.dot(color: Colors.green),
    ),
    // Custom widget inside badge
    DrawerListTile(
      title: 'Settings',
      icon: const Icon(Icons.settings),
      badge: TabBadge.custom(
        child: const Icon(Icons.star, size: 8, color: Colors.white),
        color: Colors.orange,
      ),
    ),
  ],
  pages: const [
    Center(child: Text('Messages')),
    Center(child: Text('Profile')),
    Center(child: Text('Settings')),
  ],
)
```

### Live Badge with `badgeBuilder`

Use `badgeBuilder` when the badge count comes from live state (streams, `setState`, etc.).
The builder is called on every rebuild, so it always reflects the latest value.
Return `null` to hide the badge.

```dart
class _MyPageState extends State<MyPage> {
  int _unread = 4;

  @override
  Widget build(BuildContext context) {
    return VerticalTabBar(
      drawerListTiles: [
        DrawerListTile(
          title: 'Messages',
          icon: const Icon(Icons.message),
          // badgeBuilder takes priority over badge
          badgeBuilder: (context) => _unread > 0
              ? TabBadge(count: _unread, color: Colors.red)
              : null,
        ),
      ],
      pages: [
        ElevatedButton(
          onPressed: () => setState(() => _unread = 0),
          child: const Text('Mark all read'),
        ),
      ],
    );
  }
}
```

### `TabBadge` Reference

| Constructor | Description |
|---|---|
| `TabBadge(count: n)` | Shows number. Displays `99+` when count exceeds `maxCount` |
| `TabBadge.dot()` | Small dot, no number — good for "has update" states |
| `TabBadge.custom(child: w)` | Any widget inside the badge circle |

| Parameter | Type | Default | Description |
|---|---|---|---|
| `count` | `int?` | — | Number to display |
| `maxCount` | `int` | `99` | Max before showing `99+` |
| `color` | `Color?` | `Colors.red` | Badge background color |
| `textColor` | `Color?` | `Colors.white` | Count text color |
| `size` | `double` | `18` | Badge diameter |
| `fontSize` | `double?` | `size * 0.55` | Count font size |
| `showDot` | `bool` | `false` | Force dot mode |
| `borderColor` | `Color?` | `Colors.white` | Border around badge |
| `borderWidth` | `double` | `1.5` | Border thickness |

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
      body: VerticalTabBar.sidebar(
        appTitle: 'My App',
        items: [
          SidebarItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Home',
            isSelected: true,
            onTap: () {},
          ),
          SidebarItem(
            icon: Icons.download_outlined,
            selectedIcon: Icons.download,
            label: 'Downloads',
            onTap: () {},
          ),
          SidebarItem(
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
            label: 'Settings',
            onTap: () {},
          ),
        ],
        pages: const [
          Center(child: Text('Home Page')),
          Center(child: Text('Downloads Page')),
          Center(child: Text('Settings Page')),
        ],
        primaryColor: Colors.blue,
        secondaryColor: Colors.purple,
        initiallyExpanded: true,
        onExpandedChanged: (isExpanded) {},
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
  showHeader: true,
  primaryColor: const Color(0xFF137FEC),
  // ── Global item colors ───────────────────────────────────
  selectedItemColor: const Color(0xFF137FEC).withOpacity(0.15), // selected bg
  selectedIconColor: const Color(0xFF137FEC),   // icon when selected
  unselectedIconColor: Colors.grey,             // icon when unselected
  selectedTextColor: const Color(0xFF137FEC),   // label when selected
  unselectedTextColor: Colors.black87,          // label when unselected
  // ────────────────────────────────────────────────────────
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
  pages: const [
    Center(child: Text('داشبورد')),
    Center(child: Text('نوبت‌ها')),
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
  items: [
    SidebarItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'Dashboard',
      onTap: () {},
      isSelected: true,
    ),
    SidebarItem(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      label: 'Reports',
      onTap: () {},
    ),
  ],
  pages: const [
    Center(child: Text('Dashboard Page')),
    Center(child: Text('Reports Page')),
  ],
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

## Tab Badge 🔴

### Overview

`TabBadge` is a dedicated badge widget designed for tab items. It supports three modes and is fully customizable.

```dart
// Count badge — auto-widens for multi-digit numbers
TabBadge(count: 5)
TabBadge(count: 120, maxCount: 99) // shows "99+"

// Dot badge — no number, just a colored circle
TabBadge.dot(color: Colors.green)

// Custom badge — any widget inside the badge circle
TabBadge.custom(
  child: Icon(Icons.star, size: 8, color: Colors.white),
  color: Colors.orange,
  size: 16,
)
```

### Static vs. Live Badges

Use `badge` for static values (always the same):

```dart
DrawerListTile(
  title: 'Online',
  icon: Icon(Icons.circle),
  badge: TabBadge.dot(color: Colors.green),
)
```

Use `badgeBuilder` when the value comes from state — it is called on every rebuild:

```dart
DrawerListTile(
  title: 'Messages',
  icon: Icon(Icons.message),
  badgeBuilder: (context) => unreadCount > 0
      ? TabBadge(count: unreadCount)
      : null, // null hides the badge
)
```

When both `badge` and `badgeBuilder` are set, `badgeBuilder` takes priority.

### `TabBadge` Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `count` | `int?` | — | Number to display |
| `maxCount` | `int` | `99` | Max before showing `99+` |
| `color` | `Color?` | `Colors.red` | Badge background color |
| `textColor` | `Color?` | `Colors.white` | Count text color |
| `size` | `double` | `18` | Badge diameter |
| `fontSize` | `double?` | `size * 0.55` | Count font size |
| `showDot` | `bool` | `false` | Force dot mode |
| `child` | `Widget?` | — | Custom child (custom mode only) |
| `borderColor` | `Color?` | `Colors.white` | Border color around badge |
| `borderWidth` | `double` | `1.5` | Border thickness |

### `DrawerListTile` Badge Parameters

| Parameter | Type | Description |
|---|---|---|
| `badge` | `Widget?` | Static badge widget (any widget, not just `TabBadge`) |
| `badgeBuilder` | `Widget? Function(BuildContext)?` | Dynamic builder — called on every rebuild, return `null` to hide |

---

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
- **Full Color Control**: Customize selected/unselected colors at both sidebar-level (global) and per-item level

#### Item Color Parameters

Colors can be set globally on the `Sidebar` widget, or overridden per item via `SidebarItem`. Per-item always wins.

**`Sidebar` — global (apply to all items):**

| Parameter | Description | Default |
|---|---|---|
| `selectedItemColor` | Background color of the selected item | `primaryColor` at 12–20% opacity |
| `selectedIconColor` | Icon color when item is selected | `primaryColor` |
| `unselectedIconColor` | Icon color when item is not selected | grey (textSecondary) |
| `selectedTextColor` | Label color when item is selected | `primaryColor` |
| `unselectedTextColor` | Label color when item is not selected | black87 / white (textPrimary) |

**`SidebarItem` — per-item override:**

| Parameter | Description |
|---|---|
| `selectedColor` | Background color override for this item only |
| `selectedIconColor` | Icon color override when this item is selected |
| `unselectedIconColor` | Icon color override when this item is unselected |
| `selectedTextColor` | Text color override when this item is selected |
| `unselectedTextColor` | Text color override when this item is unselected |

**Per-item example:**

```dart
SidebarItem(
  icon: Icons.warning_outlined,
  selectedIcon: Icons.warning,
  label: 'Alerts',
  onTap: () {},
  // Only this item uses orange when selected
  selectedColor: Colors.orange.withOpacity(0.15),
  selectedIconColor: Colors.orange,
  selectedTextColor: Colors.orange.shade800,
)
```

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

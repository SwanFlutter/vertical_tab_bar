# Vertical Tab Bar

A professional Flutter package for creating vertical tab bars with smooth animations and responsive design.

[فارسی](README_FA.md) | English

## Features ✨

- 🎨 **Smooth Professional Animations** - Beautiful transitions between tabs
- 📱 **Responsive Design** - Drawer mode for mobile, Sidebar for desktop
- 🎭 **Powerful Themes** - Support for solid colors, linear and radial gradients
- ⚙️ **Highly Customizable** - Full control over appearance and behavior
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

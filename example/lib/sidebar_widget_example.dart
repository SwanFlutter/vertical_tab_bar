import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  runApp(const SidebarWidgetExampleApp());
}

class SidebarWidgetExampleApp extends StatelessWidget {
  const SidebarWidgetExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidebar Widget Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SidebarWidgetExample(),
    );
  }
}

class SidebarWidgetExample extends StatefulWidget {
  const SidebarWidgetExample({super.key});

  @override
  State<SidebarWidgetExample> createState() => _SidebarWidgetExampleState();
}

class _SidebarWidgetExampleState extends State<SidebarWidgetExample> {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  static const _items = <_NavItem>[
    _NavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    _NavItem(
      label: 'Downloads',
      icon: Icons.download_outlined,
      selectedIcon: Icons.download,
    ),
    _NavItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
    _NavItem(
      label: 'Profile',
      icon: Icons.person_outlined,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          VerticalTabBar.sidebar(
            appTitle: 'My App',
            logoIcon: Icons.dashboard_customize_rounded,
            primaryColor: Colors.blue.shade600,
            secondaryColor: Colors.purple.shade400,
            initiallyExpanded: _isExpanded,
            onExpandedChanged: (v) => setState(() => _isExpanded = v),
            backgroundColorLight: Colors.grey.shade50,
            backgroundColorDark: Colors.grey.shade900,
            items: List.generate(_items.length, (index) {
              final item = _items[index];
              return SidebarItem(
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                label: item.label,
                isSelected: index == _selectedIndex,
                onTap: () => setState(() => _selectedIndex = index),
              );
            }),
          ),
          Expanded(
            child: _SidebarContent(
              title: _items[_selectedIndex].label,
              isExpanded: _isExpanded,
              selectedIndex: _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

class _SidebarContent extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final int selectedIndex;

  const _SidebarContent({
    required this.title,
    required this.isExpanded,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Center(
              child: Text(
                isExpanded ? 'Expanded' : 'Collapsed',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Index: $selectedIndex',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This is a dedicated Sidebar widget example.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < 20; i++)
            ListTile(
              title: Text('Item $i'),
              subtitle: const Text('Content stays independent from the sidebar'),
            ),
        ],
      ),
    );
  }
}


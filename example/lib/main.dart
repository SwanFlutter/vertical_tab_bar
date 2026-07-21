import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical Tab Bar Demo',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  // Live counters for badge demo
  int _messageCount = 4;
  int _notifCount = 12;

  void _addMessage() => setState(() => _messageCount++);
  void _clearMessages() => setState(() => _messageCount = 0);
  void _addNotif() => setState(() => _notifCount++);
  void _clearNotifs() => setState(() => _notifCount = 0);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const DrawerListTile(
        title: 'داشبورد',
        icon: Icon(Icons.home),
        // No badge on home tab
      ),
      const DrawerListTile(
        title: 'Profile',
        icon: Icon(Icons.person),
        // Static dot badge — always visible
        badge: TabBadge.dot(color: Colors.green),
      ),
      const DrawerListTile(
        title: 'Settings',
        icon: Icon(Icons.settings),
        // Static custom badge with an icon
        badge: TabBadge.custom(
          color: Colors.orange,
          size: 16,
          child: Icon(Icons.star, size: 8, color: Colors.white),
        ),
      ),
      DrawerListTile(
        title: 'Messages',
        icon: const Icon(Icons.message),
        // Dynamic badge — updates live when _messageCount changes
        badgeBuilder: (context) => _messageCount > 0
            ? TabBadge(count: _messageCount, color: Colors.red)
            : null,
      ),
      DrawerListTile(
        title: 'Notifications',
        icon: const Icon(Icons.notifications),
        // Dynamic badge — updates live when _notifCount changes
        badgeBuilder: (context) => _notifCount > 0
            ? TabBadge(count: _notifCount, color: Colors.deepPurple)
            : null,
      ),
    ];

    final pages = [
      const HomePage(),
      const ProfilePage(),
      const SettingsPage(),
      // Pass callbacks so the pages can manipulate badge counts
      MessagesPage(onAdd: _addMessage, onClear: _clearMessages),
      NotificationsPage(onAdd: _addNotif, onClear: _clearNotifs),
    ];

    final theme = VerticalTabBarTheme.linearGradient(
      gradientColors: [Colors.purple.shade300, Colors.blue.shade300],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      unselectedColor: Colors.transparent,
      backgroundColor: Colors.grey.shade50,
      indicatorColor: Colors.purple.shade700,
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      unselectedTextStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      selectedIconColor: Colors.white,
      unselectedIconColor: Colors.grey.shade600,
      iconTextSpacing: 16.0,
      tabPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      animationDuration: const Duration(milliseconds: 220),
      animationCurve: Curves.easeInOutCubic,
      enableScaleAnimation: true,
      enableFadeAnimation: true,
      enableSlideAnimation: true,
    );

    return VerticalTabBar(
      drawerListTiles: tabs,
      pages: pages,
      theme: theme,
      mobileBreakpoint: 600,
      tabletBreakpoint: 900,
      enableDrawerMode: true,
      widthTabBar: 250,
      heightAnimatedBox: 55,
      widthAnimatedBox: 6,
      height: 65,
      drawerWidth: 300,
      showMenuButton: true,
      appBarTitle: const Text('Vertical Tab Bar Demo'),
    );
  }
}

// ─── Pages ─────────────────────────────────────────────────────────────────

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome! 👋',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'This is a demo of Vertical Tab Bar usage',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildCard('Smooth Animation', Icons.animation, Colors.purple),
                _buildCard('Responsive', Icons.devices, Colors.blue),
                _buildCard('Customizable', Icons.tune, Colors.green),
                _buildCard(
                  'Badge Support',
                  Icons.notifications_active,
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.purple.shade200,
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 24),
          const Text(
            'Sample User',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'user@example.com',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),
          _buildInfoRow(Icons.phone, '+98 912 345 6789'),
          _buildInfoRow(Icons.location_on, 'Tehran, Iran'),
          _buildInfoRow(Icons.cake, 'March 21, 1991'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple.shade700),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildSettingTile(
          'Notifications',
          'Receive new notifications',
          Icons.notifications,
          true,
        ),
        _buildSettingTile(
          'Dark Mode',
          'Enable dark theme',
          Icons.dark_mode,
          false,
        ),
        _buildSettingTile('Sound', 'App sounds', Icons.volume_up, true),
        const Divider(height: 32),
        const ListTile(
          leading: Icon(Icons.info, color: Colors.blue),
          title: Text('About App'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        const ListTile(
          leading: Icon(Icons.help, color: Colors.green),
          title: Text('Help'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        secondary: Icon(icon, color: Colors.purple.shade700),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        value: value,
        onChanged: (bool newValue) {},
      ),
    );
  }
}

/// Messages page — demonstrates live badge manipulation
class MessagesPage extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onClear;

  const MessagesPage({super.key, required this.onAdd, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Badge control bar
        Container(
          color: Colors.red.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.info_outline, size: 18, color: Colors.red),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Badge demo — tap buttons to update the tab badge',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('+1 Message'),
              ),
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('Clear'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Colors.primaries[index % Colors.primaries.length],
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text('Message ${index + 1}'),
                  subtitle: const Text('This is a sample message...'),
                  trailing: Text(
                    '${index + 1}:00',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Notifications page — demonstrates live badge manipulation
class NotificationsPage extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onClear;

  const NotificationsPage({
    super.key,
    required this.onAdd,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Badge control bar
        Container(
          color: Colors.purple.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: Colors.purple.shade700),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Badge demo — tap buttons to update the tab badge',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('+1 Notif'),
              ),
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('Clear'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildNotification(
                'New Notification',
                'You have a new message',
                Icons.message,
                Colors.blue,
                '5 minutes ago',
              ),
              _buildNotification(
                'Update',
                'New version available',
                Icons.system_update,
                Colors.green,
                '1 hour ago',
              ),
              _buildNotification(
                'Warning',
                'Please change your password',
                Icons.warning,
                Colors.orange,
                '2 hours ago',
              ),
              _buildNotification(
                'Success',
                'Your profile has been updated',
                Icons.check_circle,
                Colors.purple,
                'Yesterday',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotification(
    String title,
    String message,
    IconData icon,
    Color color,
    String time,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}

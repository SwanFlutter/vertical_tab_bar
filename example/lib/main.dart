import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

import 'sidebar_with_brand_example.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SidebarWithBrandPage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define tabs
    final tabs = [
      const DrawerListTile(title: 'Home', icon: Icon(Icons.home)),
      const DrawerListTile(title: 'Profile', icon: Icon(Icons.person)),
      const DrawerListTile(title: 'Settings', icon: Icon(Icons.settings)),
      const DrawerListTile(title: 'Messages', icon: Icon(Icons.message)),
      const DrawerListTile(
          title: 'Notifications', icon: Icon(Icons.notifications)),
    ];

    // Define pages
    final pages = [
      const HomePage(),
      const ProfilePage(),
      const SettingsPage(),
      const MessagesPage(),
      const NotificationsPage(),
    ];

    // Custom theme with gradient and smooth animations
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
      // Animation settings
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeInOutCubic,
      enableScaleAnimation: true,
      enableFadeAnimation: true,
      enableSlideAnimation: true,
    );

    return VerticalTabBar(
      drawerListTiles: tabs,
      pages: pages,
      theme: theme,
      // Responsive settings
      mobileBreakpoint: 600,
      tabletBreakpoint: 900,
      enableDrawerMode: true,
      // Appearance settings
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

// Home Page
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
                _buildCard('Professional', Icons.star, Colors.orange),
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

// Profile Page
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

// Settings Page
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

// Messages Page
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Colors.primaries[index % Colors.primaries.length],
              child: Text('${index + 1}'),
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
    );
  }
}

// Notifications Page
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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

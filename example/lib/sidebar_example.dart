import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  runApp(const MaterialApp(home: SidebarExample()));
}

class SidebarExample extends StatefulWidget {
  const SidebarExample({super.key});

  @override
  State<SidebarExample> createState() => _SidebarExampleState();
}

class _SidebarExampleState extends State<SidebarExample> {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  static const List<Widget> _pages = [
    _HomePage(),
    _DownloadsPage(),
    _SettingsPage(),
    _ProfilePage(),
    _AnalyticsPage(),
  ];

  static const List<_SidebarItemData> _sidebarItemsData = [
    _SidebarItemData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    _SidebarItemData(
      icon: Icons.download_outlined,
      selectedIcon: Icons.download,
      label: 'Downloads',
    ),
    _SidebarItemData(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
    _SidebarItemData(
      icon: Icons.person_outlined,
      selectedIcon: Icons.person,
      label: 'Profile',
    ),
    _SidebarItemData(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      label: 'Analytics',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          VerticalTabBar.sidebar(
            appTitle: 'My Dashboard',
            logoIcon: Icons.dashboard_customize_rounded,
            items: _sidebarItemsData
                .map((item) => SidebarItem(
                      icon: item.icon,
                      selectedIcon: item.selectedIcon,
                      label: item.label,
                      isSelected:
                          _sidebarItemsData.indexOf(item) == _selectedIndex,
                      onTap: () => _onSidebarItemSelected(
                          _sidebarItemsData.indexOf(item)),
                    ))
                .toList(),
            primaryColor: Colors.blue.shade600,
            secondaryColor: Colors.purple.shade400,
            initiallyExpanded: _isExpanded,
            onExpandedChanged: (isExpanded) {
              setState(() => _isExpanded = isExpanded);
            },
            backgroundColorLight: Colors.grey.shade50,
            backgroundColorDark: Colors.grey.shade900,
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }

  void _onSidebarItemSelected(int index) {
    setState(() => _selectedIndex = index);
  }
}

class _SidebarItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _SidebarItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTransparentAppBar('Home'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.home, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Dashboard',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'This is the home page content',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatCard('Users', '1,234', Colors.blue),
                  const SizedBox(width: 20),
                  _buildStatCard('Revenue', '\$23,456', Colors.green),
                  const SizedBox(width: 20),
                  _buildStatCard('Orders', '567', Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _DownloadsPage extends StatelessWidget {
  const _DownloadsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTransparentAppBar('Downloads'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Downloads',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Manage your downloads here',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              _buildDownloadItem('Document.pdf', '1.2 MB', Icons.picture_as_pdf,
                  Colors.red, context),
              _buildDownloadItem(
                  'Image.jpg', '890 KB', Icons.image, Colors.blue, context),
              _buildDownloadItem('Video.mp4', '45.6 MB', Icons.video_file,
                  Colors.green, context),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDownloadItem(String name, String size, IconData icon,
      Color color, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        subtitle: Text(size, style: const TextStyle(color: Colors.grey)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () => _showSnackBar(context, 'Download started'),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showSnackBar(context, 'File deleted'),
            ),
          ],
        ),
      ),
    );
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTransparentAppBar('Settings'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.settings, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Configure your app settings',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          _buildSettingItem(
              Icons.dark_mode, 'Dark Mode', 'Toggle dark theme', true),
          _buildSettingItem(Icons.notifications, 'Notifications',
              'Enable push notifications', true),
          _buildSettingItem(
              Icons.language, 'Language', 'Change app language', false),
          _buildSettingItem(Icons.security, 'Security',
              'Update your security settings', false),
          _buildSettingItem(Icons.backup, 'Backup', 'Backup your data', false),
        ],
      ),
    );
  }

  static Widget _buildSettingItem(
      IconData icon, String title, String subtitle, bool hasSwitch) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 32),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: hasSwitch
            ? Switch(
                value: false,
                onChanged: (value) {},
                activeThumbColor: Colors.blue,
              )
            : const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTransparentAppBar('Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/120x120'),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.check, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'john.doe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              _buildProfileInfo('Member since', 'Jan 2024'),
              _buildProfileInfo('Location', 'New York, USA'),
              _buildProfileInfo('Status', 'Premium User'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () =>
                    _showSnackBar(context, 'Profile updated successfully'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40)),
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildProfileInfo(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(label,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(width: 20),
            Text(value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}

class _AnalyticsPage extends StatelessWidget {
  const _AnalyticsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTransparentAppBar('Analytics'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.analytics, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Analytics',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'View your analytics and reports',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            _buildAnalyticsCard('Total Visits', '12,345', Colors.blue),
            _buildAnalyticsCard('Bounce Rate', '45%', Colors.orange),
            _buildAnalyticsCard('Conversion Rate', '3.2%', Colors.green),
            _buildAnalyticsCard('Avg. Session', '4m 32s', Colors.purple),
          ],
        ),
      ),
    );
  }

  static Widget _buildAnalyticsCard(String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.bar_chart, size: 32, color: color),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(value,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

AppBar _buildTransparentAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

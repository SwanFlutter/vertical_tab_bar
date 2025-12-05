import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

class CustomStyleExamplePage extends StatelessWidget {
  const CustomStyleExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // تعریف استایل‌های سفارشی
    const customTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.deepPurple,
      letterSpacing: 0.5,
    );

    const customTextStyle2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.teal,
      fontStyle: FontStyle.italic,
    );

    return VerticalTabBar(
      drawerListTiles: const [
        DrawerListTile(
          title: 'Dashboard',
          icon: Icon(Icons.dashboard),
          textStyle:
              customTextStyle, // استایل سفارشی - آیکون از colorSelectedMenu استفاده می‌کنه
        ),
        DrawerListTile(
          title: 'Analytics',
          icon: Icon(Icons.analytics),
          textStyle:
              customTextStyle2, // استایل سفارشی - آیکون از colorSelectedMenu استفاده می‌کنه
        ),
        DrawerListTile(
          title: 'Settings',
          icon: Icon(Icons.settings),
          // بدون textStyle - متن و آیکون از colorSelectedMenu استفاده می‌کنن
        ),
        DrawerListTile(
          title: 'Profile',
          icon: Icon(Icons.person),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange, // رنگ سفارشی - آیکون هم همین رنگ می‌شه
          ),
        ),
      ],
      pages: [
        _buildPage('Dashboard', Icons.dashboard, Colors.deepPurple),
        _buildPage('Analytics', Icons.analytics, Colors.teal),
        _buildPage('Settings', Icons.settings, Colors.blue),
        _buildPage('Profile', Icons.person, Colors.orange),
      ],
      backgroundColor: Colors.grey.shade50,
      colorMenu: Colors.white,
      tabColor: Colors.grey.shade200,
      dividerColor: Colors.green,
      colorSelectedMenu: Colors.deepPurple,
      showTabDivider: true, // نمایش خط بین تب‌ها
      tabDividerColor: Colors.green, // رنگ خط بین تب‌ها
      widthTabBar: 250,
      appBarTitle: const Text('مثال استایل سفارشی'),
    );
  }

  static Widget _buildPage(String title, IconData icon, Color color) {
    return Container(
      color: color.withValues(alpha: 0.05),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: color),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'استفاده از textStyle سفارشی',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'هر تب می‌تواند textStyle مخصوص به خود را داشته باشد',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'مثال:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'DrawerListTile(\n'
                      '  title: "Dashboard",\n'
                      '  icon: Icon(Icons.dashboard),\n'
                      '  textStyle: TextStyle(\n'
                      '    fontSize: 16,\n'
                      '    fontWeight: FontWeight.w600,\n'
                      '    color: Colors.deepPurple,\n'
                      '  ),\n'
                      ')',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

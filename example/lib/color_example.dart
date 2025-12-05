import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  runApp(const ColorExampleApp());
}

class ColorExampleApp extends StatelessWidget {
  const ColorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ColorExamplePage(),
    );
  }
}

class ColorExamplePage extends StatelessWidget {
  const ColorExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6200EE);

    return VerticalTabBar(
      drawerListTiles: const [
        DrawerListTile(
          title: 'خانه',
          icon: Icon(Icons.home),
        ),
        DrawerListTile(
          title: 'پروفایل',
          icon: Icon(Icons.person),
        ),
        DrawerListTile(
          title: 'تنظیمات',
          icon: Icon(Icons.settings),
        ),
        DrawerListTile(
          title: 'درباره ما',
          icon: Icon(Icons.info),
        ),
      ],
      pages: [
        _buildPage('خانه', Icons.home, primaryColor),
        _buildPage('پروفایل', Icons.person, primaryColor),
        _buildPage('تنظیمات', Icons.settings, primaryColor),
        _buildPage('درباره ما', Icons.info, primaryColor),
      ],
      // استفاده از colorSelectedMenu برای تنظیم رنگ آیکون و متن انتخاب شده
      colorSelectedMenu: primaryColor,
      tabColor: primaryColor.withValues(alpha: 0.1),
      colorMenu: Colors.white,
      backgroundColor: Colors.grey.shade50,
      dividerColor: primaryColor.withValues(alpha: 0.3),
      showDivider: true,
      widthTabBar: 240,
      appBarTitle: const Text('مثال استفاده از colorSelectedMenu'),
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
            Text(
              'استفاده از colorSelectedMenu: primaryColor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
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
                    'پارامتر colorSelectedMenu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'این پارامتر رنگ آیکون و متن تب انتخاب شده را تنظیم می‌کند',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
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

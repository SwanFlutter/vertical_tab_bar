import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';
import 'package:vertical_tab_bar/vertical_tab_bar_theme.dart';

void main() {
  runApp(const SimpleExampleApp());
}

class SimpleExampleApp extends StatelessWidget {
  const SimpleExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Vertical Tab Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SimpleHomePage(),
    );
  }
}

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalTabBar(
      drawerListTiles: const [
        DrawerListTile(
          title: 'خانه',
          icon: Icon(Icons.home),
        ),
        DrawerListTile(
          title: 'جستجو',
          icon: Icon(Icons.search),
        ),
        DrawerListTile(
          title: 'پروفایل',
          icon: Icon(Icons.person),
        ),
        DrawerListTile(
          title: 'تنظیمات',
          icon: Icon(Icons.settings),
        ),
      ],
      pages: [
        _buildPage('خانه', Icons.home, Colors.blue),
        _buildPage('جستجو', Icons.search, Colors.green),
        _buildPage('پروفایل', Icons.person, Colors.orange),
        _buildPage('تنظیمات', Icons.settings, Colors.purple),
      ],
      theme: VerticalTabBarTheme.linearGradient(
        gradientColors: [
          Colors.blue.shade300,
          Colors.purple.shade300,
        ],
        unselectedColor: Colors.transparent,
        backgroundColor: Colors.grey.shade100,
        indicatorColor: Colors.blue.shade700,
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        unselectedTextStyle: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 15,
        ),
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.grey.shade600,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
      ),
      widthTabBar: 220,
      appBarTitle: const Text('مثال ساده'),
    );
  }

  static Widget _buildPage(String title, IconData icon, Color color) {
    return Container(
      color: color.withValues(alpha: 0.1),
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
              'سایز پنجره را تغییر دهید تا انیمیشن تبدیل\nسایدبار به دراور را ببینید',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

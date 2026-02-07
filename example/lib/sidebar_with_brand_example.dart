import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

class SidebarWithBrandPage extends StatefulWidget {
  const SidebarWithBrandPage({super.key});

  @override
  State<SidebarWithBrandPage> createState() => _SidebarWithBrandPageState();
}

class _SidebarWithBrandPageState extends State<SidebarWithBrandPage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  final List<String> _pages = [
    'داشبورد',
    'نوبت‌ها',
    'بیماران',
    'گزارش‌ها',
    'تنظیمات',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Row(
            children: [
              // Sidebar with brand background
              VerticalTabBar.sidebar(
                appTitle: 'مدیک‌پلن',
                logoIcon: Icons.medical_services,
                showHeader: true,
                primaryColor: const Color(0xFF137FEC),
                // Brand background settings
                showBrandBackground: true,
                brandLogoLight: 'assets/brand/creator_logo.png',
                brandLogoDark: 'assets/brand/creator_logo_dark.png',
                brandLogoOpacity: 0.40, // More visible
                items: [
                  SidebarItem(
                    icon: Icons.dashboard_outlined,
                    selectedIcon: Icons.dashboard,
                    label: 'داشبورد',
                    onTap: () => setState(() => _selectedIndex = 0),
                    isSelected: _selectedIndex == 0,
                  ),
                  SidebarItem(
                    icon: Icons.calendar_month_outlined,
                    selectedIcon: Icons.calendar_month,
                    label: 'نوبت‌ها',
                    onTap: () => setState(() => _selectedIndex = 1),
                    isSelected: _selectedIndex == 1,
                  ),
                  SidebarItem(
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    label: 'بیماران',
                    onTap: () => setState(() => _selectedIndex = 2),
                    isSelected: _selectedIndex == 2,
                  ),
                  SidebarItem(
                    icon: Icons.analytics_outlined,
                    selectedIcon: Icons.analytics,
                    label: 'گزارش‌ها',
                    onTap: () => setState(() => _selectedIndex = 3),
                    isSelected: _selectedIndex == 3,
                  ),
                  SidebarItem(
                    icon: Icons.settings_outlined,
                    selectedIcon: Icons.settings,
                    label: 'تنظیمات',
                    onTap: () => setState(() => _selectedIndex = 4),
                    isSelected: _selectedIndex == 4,
                  ),
                ],
                userName: 'دکتر سارا احمدی',
                userSubtitle: 'متخصص داخلی',
                userImageUrl:
                    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200&h=200&fit=crop',
                showLogoutButton: true,
                logoutText: 'خروج از سیستم',
                onLogout: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('خروج از سیستم...')),
                  );
                },
              ),
              // Main content
              Expanded(
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF101922)
                      : const Color(0xFFF6F7F8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          size: 80,
                          color: const Color(0xFF137FEC).withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _pages[_selectedIndex],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'محتوای صفحه ${_pages[_selectedIndex]}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isDarkMode = !_isDarkMode;
                            });
                          },
                          icon: Icon(
                              _isDarkMode ? Icons.light_mode : Icons.dark_mode),
                          label: Text(_isDarkMode ? 'حالت روشن' : 'حالت تاریک'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF137FEC),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'برند در پس‌زمینه sidebar نمایش داده می‌شود',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

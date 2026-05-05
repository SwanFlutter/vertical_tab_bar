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
    'داشبورد مدیریتی و کنترل مرکزی سیستم مدیک‌پلن',
    'لیست نوبت‌های رزرو شده امروز بیمارستان فوق تخصصی',
    'بیماران بخش مراقبت‌های ویژه و خدمات درمانی خاص',
    'گزارش‌های تحلیل آماری و نمودارهای پیشرفته دوره‌ای',
    'تنظیمات حساب کاربری و مدیریت سطوح دسترسی امنیتی',
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
          // نکته بسیار مهم: Row اضافی حذف شد. 
          // ویجت VerticalTabBar.sidebar وقتی دارای pages باشد، خودش یک Row برمی‌گرداند.
          body: VerticalTabBar.sidebar(
            appTitle: 'مدیک‌پلن هوشمند',
            logoIcon: Icons.medical_services,
            showHeader: true,
            primaryColor: const Color(0xFF137FEC),
            showBrandBackground: true,
            brandLogoLight: 'assets/brand/creator_logo.png',
            brandLogoDark: 'assets/brand/creator_logo_dark.png',
            brandLogoOpacity: 0.40,
            pages: _pages
                .map(
                  (title) => Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _isDarkMode = !_isDarkMode;
                              });
                            },
                            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
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
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            items: [
              SidebarItem(
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: 'داشبورد مدیریتی و کنترل مرکزی سیستم مدیک‌پلن',
                onTap: () => setState(() => _selectedIndex = 0),
                isSelected: _selectedIndex == 0,
              ),
              SidebarItem(
                icon: Icons.calendar_month_outlined,
                selectedIcon: Icons.calendar_month,
                label: 'لیست نوبت‌های رزرو شده امروز بیمارستان فوق تخصصی',
                onTap: () => setState(() => _selectedIndex = 1),
                isSelected: _selectedIndex == 1,
              ),
              SidebarItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'بیماران بخش مراقبت‌های ویژه و خدمات درمانی خاص',
                onTap: () => setState(() => _selectedIndex = 2),
                isSelected: _selectedIndex == 2,
              ),
              SidebarItem(
                icon: Icons.analytics_outlined,
                selectedIcon: Icons.analytics,
                label: 'گزارش‌های تحلیل آماری و نمودارهای پیشرفته دوره‌ای',
                onTap: () => setState(() => _selectedIndex = 3),
                isSelected: _selectedIndex == 3,
              ),
              SidebarItem(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings,
                label: 'تنظیمات حساب کاربری و مدیریت سطوح دسترسی امنیتی',
                onTap: () => setState(() => _selectedIndex = 4),
                isSelected: _selectedIndex == 4,
              ),
            ],
            userName: 'دکتر سارا احمدی',
            userSubtitle: 'متخصص داخلی',
            // آدرس تصویر جدید و پایدار
            userImageUrl: 'https://ui-avatars.com/api/?name=Sara+Ahmadi&background=137FEC&color=fff',
            showLogoutButton: true,
            logoutText: 'خروج از سیستم',
            onLogout: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('خروج از سیستم...')),
              );
            },
          ),
        ),
      ),
    );
  }
}

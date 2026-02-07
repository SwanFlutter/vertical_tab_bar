import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

class SidebarCustomHeaderPage extends StatefulWidget {
  const SidebarCustomHeaderPage({super.key});

  @override
  State<SidebarCustomHeaderPage> createState() =>
      _SidebarCustomHeaderPageState();
}

class _SidebarCustomHeaderPageState extends State<SidebarCustomHeaderPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            // Example 1: Sidebar without header
            VerticalTabBar.sidebar(
              showHeader: false,
              primaryColor: const Color(0xFF137FEC),
              items: [
                SidebarItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  label: 'داشبورد',
                  onTap: () => setState(() => _selectedIndex = 0),
                  isSelected: _selectedIndex == 0,
                ),
                SidebarItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  label: 'تنظیمات',
                  onTap: () => setState(() => _selectedIndex = 1),
                  isSelected: _selectedIndex == 1,
                ),
              ],
              userName: 'کاربر',
              showLogoutButton: true,
              onLogout: () {},
            ),

            const SizedBox(width: 20),

            // Example 2: Sidebar with custom header
            VerticalTabBar.sidebar(
              showHeader: true,
              customHeader: Container(
                height: 80,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF137FEC),
                      Color(0xFF1E88E5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'مدیک‌پلن',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              primaryColor: const Color(0xFF137FEC),
              items: [
                SidebarItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  label: 'داشبورد',
                  onTap: () => setState(() => _selectedIndex = 0),
                  isSelected: _selectedIndex == 0,
                ),
                SidebarItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: 'پروفایل',
                  onTap: () => setState(() => _selectedIndex = 1),
                  isSelected: _selectedIndex == 1,
                ),
              ],
              userName: 'دکتر احمدی',
              userSubtitle: 'متخصص',
              showLogoutButton: true,
              onLogout: () {},
            ),

            const SizedBox(width: 20),

            // Example 3: Sidebar with only logo
            VerticalTabBar.sidebar(
              logoIcon: Icons.medical_services,
              showHeader: true,
              primaryColor: const Color(0xFF137FEC),
              items: [
                SidebarItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'خانه',
                  onTap: () => setState(() => _selectedIndex = 0),
                  isSelected: _selectedIndex == 0,
                ),
                SidebarItem(
                  icon: Icons.info_outline,
                  selectedIcon: Icons.info,
                  label: 'درباره',
                  onTap: () => setState(() => _selectedIndex = 1),
                  isSelected: _selectedIndex == 1,
                ),
              ],
            ),

            const SizedBox(width: 20),

            // Example 4: Sidebar with only title
            VerticalTabBar.sidebar(
              appTitle: 'اپلیکیشن من',
              showHeader: true,
              primaryColor: const Color(0xFF137FEC),
              items: [
                SidebarItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  label: 'داشبورد',
                  onTap: () => setState(() => _selectedIndex = 0),
                  isSelected: _selectedIndex == 0,
                ),
              ],
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
                      const Text(
                        'مثال‌های مختلف Sidebar',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '۱. بدون header\n۲. با header سفارشی\n۳. فقط لوگو\n۴. فقط عنوان',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
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
    );
  }
}

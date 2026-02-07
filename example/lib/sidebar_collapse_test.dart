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
      title: 'Sidebar Collapse Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const SidebarCollapseTestPage(),
    );
  }
}

class SidebarCollapseTestPage extends StatefulWidget {
  const SidebarCollapseTestPage({super.key});

  @override
  State<SidebarCollapseTestPage> createState() =>
      _SidebarCollapseTestPageState();
}

class _SidebarCollapseTestPageState extends State<SidebarCollapseTestPage> {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            // Sidebar with profile and logout - test collapse
            VerticalTabBar.sidebar(
              appTitle: 'مدیک‌پلن',
              logoIcon: Icons.medical_services,
              showHeader: true,
              primaryColor: const Color(0xFF137FEC),
              initiallyExpanded: _isExpanded,
              onExpandedChanged: (expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
              },
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
              ],
              // User profile in footer
              userName: 'دکتر سارا احمدی',
              userSubtitle: 'متخصص داخلی',
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
                        _isExpanded ? Icons.menu_open : Icons.menu,
                        size: 80,
                        color: const Color(0xFF137FEC).withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _isExpanded ? 'Sidebar باز است' : 'Sidebar بسته است',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'دکمه toggle را در پایین sidebar کلیک کنید',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        icon: Icon(_isExpanded ? Icons.close : Icons.menu),
                        label: Text(
                            _isExpanded ? 'بستن Sidebar' : 'باز کردن Sidebar'),
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  testWidgets('VerticalTabBar.sidebar() renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VerticalTabBar.sidebar(
            appTitle: 'Test App',
            items: [
              SidebarItem(
                icon: Icons.home,
                selectedIcon: Icons.home_filled,
                label: 'Home',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Test App'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.byType(Sidebar), findsOneWidget);
  });
}

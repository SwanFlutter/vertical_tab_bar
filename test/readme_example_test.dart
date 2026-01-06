import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  testWidgets('README example test', (WidgetTester tester) async {
    // Set screen size to desktop width to ensure sidebar is visible
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VerticalTabBar(
            initialIndex: 1,
            drawerListTiles: [
              DrawerListTile(
                title: 'Home',
                icon: const Icon(Icons.home),
                onTap: () {
                  // Navigation mock
                },
                isAction: true,
              ),
              const DrawerListTile(
                title: 'Dashboard',
                icon: Icon(Icons.dashboard),
              ),
            ],
            pages: const [
              SizedBox(),
              Center(child: Text('Dashboard Page')),
            ],
          ),
        ),
      ),
    );

    // Initial state: Dashboard selected
    expect(find.text('Dashboard Page'), findsOneWidget);

    // Tap Home button
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    // Should still be on Dashboard page because Home is an action
    expect(find.text('Dashboard Page'), findsOneWidget);
  });
}

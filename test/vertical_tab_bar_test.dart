import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  testWidgets('VerticalTabBar renders with tabs and pages in mobile mode', (
    WidgetTester tester,
  ) async {
    // Set mobile screen size
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    final tabs = [
      const DrawerListTile(title: 'Home', icon: Icon(Icons.home)),
      const DrawerListTile(title: 'Profile', icon: Icon(Icons.person)),
    ];

    final pages = [
      const Center(child: Text('Home Page')),
      const Center(child: Text('Profile Page')),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: VerticalTabBar(drawerListTiles: tabs, pages: pages),
      ),
    );

    // In mobile mode, first page should be visible
    expect(find.text('Home Page'), findsOneWidget);

    // Open drawer to see tabs
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Check for tabs in drawer (may appear multiple times due to AppBar)
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Profile'), findsAtLeastNWidgets(1));

    addTearDown(tester.view.reset);
  });

  testWidgets('VerticalTabBar switches pages on tab tap in desktop mode', (
    WidgetTester tester,
  ) async {
    // Set desktop screen size
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    final tabs = [
      const DrawerListTile(title: 'Tab 1', icon: Icon(Icons.looks_one)),
      const DrawerListTile(title: 'Tab 2', icon: Icon(Icons.looks_two)),
    ];

    final pages = [
      const Center(child: Text('Page 1')),
      const Center(child: Text('Page 2')),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: VerticalTabBar(drawerListTiles: tabs, pages: pages),
      ),
    );

    // Initially shows first page
    expect(find.text('Page 1'), findsOneWidget);

    // Tap on Tab 2 in sidebar
    await tester.tap(find.text('Tab 2'));
    await tester.pumpAndSettle();

    // Should show second page
    expect(find.text('Page 2'), findsOneWidget);

    addTearDown(tester.view.reset);
  });

  testWidgets('VerticalTabBar applies custom theme', (
    WidgetTester tester,
  ) async {
    // Set desktop screen size
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    final theme = VerticalTabBarTheme.solid(
      selectedColor: Colors.blue,
      indicatorColor: Colors.red,
    );

    final tabs = [const DrawerListTile(title: 'Test', icon: Icon(Icons.star))];

    final pages = [const Center(child: Text('Test Page'))];

    await tester.pumpWidget(
      MaterialApp(
        home: VerticalTabBar(drawerListTiles: tabs, pages: pages, theme: theme),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Test Page'), findsOneWidget);

    addTearDown(tester.view.reset);
  });

  testWidgets('VerticalTabBar drawer mode works correctly', (
    WidgetTester tester,
  ) async {
    // Set mobile screen size
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    final tabs = [
      const DrawerListTile(title: 'Item 1', icon: Icon(Icons.home)),
      const DrawerListTile(title: 'Item 2', icon: Icon(Icons.settings)),
    ];

    final pages = [
      const Center(child: Text('Content 1')),
      const Center(child: Text('Content 2')),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: VerticalTabBar(drawerListTiles: tabs, pages: pages),
      ),
    );

    // Initially shows first page
    expect(find.text('Content 1'), findsOneWidget);

    // Open drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Tap second item in drawer
    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();

    // Should show second page
    expect(find.text('Content 2'), findsOneWidget);

    addTearDown(tester.view.reset);
  });
}

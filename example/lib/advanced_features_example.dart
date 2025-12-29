import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

void main() {
  runApp(const AdvancedFeaturesExampleApp());
}

class AdvancedFeaturesExampleApp extends StatelessWidget {
  const AdvancedFeaturesExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Vertical Tab Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AdvancedFeaturesExample(),
    );
  }
}

class AdvancedFeaturesExample extends StatefulWidget {
  const AdvancedFeaturesExample({super.key});

  @override
  State<AdvancedFeaturesExample> createState() =>
      _AdvancedFeaturesExampleState();
}

class _AdvancedFeaturesExampleState extends State<AdvancedFeaturesExample> {
  bool _rtl = false;
  bool _controlled = true;
  bool _keepAlive = true;
  bool _forceSidebar = false;
  bool _customTabs = false;
  bool _showEmpty = false;

  int _selectedIndex = 1;

  late final List<Widget> _pages = [
    const _CounterPage(title: 'Home', color: Colors.blue),
    const _CounterPage(title: 'Profile', color: Colors.purple),
    const _CounterPage(title: 'Messages', color: Colors.green),
    const _CounterPage(title: 'Settings', color: Colors.orange),
  ];

  void _showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(text), duration: const Duration(milliseconds: 800)),
    );
  }

  List<DrawerListTile> _buildTabs() {
    const badgeStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.0,
    );

    Widget badge(String text, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(text, style: badgeStyle),
      );
    }

    return [
      DrawerListTile(
        title: 'Home',
        icon: const Icon(Icons.home),
        badge: badge('3', Colors.red),
        onTap: () => _showSnack('Home onTap'),
      ),
      DrawerListTile(
        title: 'Profile',
        icon: const Icon(Icons.person),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showSnack('Profile onTap'),
      ),
      DrawerListTile(
        title: 'Messages',
        icon: const Icon(Icons.message),
        badge: badge('12', Colors.blue),
        trailing: const Icon(Icons.mark_email_read_outlined),
        onTap: () => _showSnack('Messages onTap'),
      ),
      DrawerListTile(
        title: 'Settings',
        icon: const Icon(Icons.settings),
        trailing: const Icon(Icons.tune),
        onTap: () => _showSnack('Settings onTap'),
      ),
    ];
  }

  Widget _buildTabBuilder(
    BuildContext context,
    int index,
    bool isSelected,
    DrawerListTile item,
    bool isInDrawer,
  ) {
    final color = isSelected
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    final titleStyle = TextStyle(
      fontSize: 15,
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      color: color,
    );

    final icon = IconTheme(
      data: IconThemeData(color: color),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(item.icon.icon),
          if (item.badge != null)
            PositionedDirectional(top: -4, end: -4, child: item.badge!),
        ],
      ),
    );

    return Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Expanded(child: Text(item.title, style: titleStyle)),
        if (item.trailing != null) ...[
          const SizedBox(width: 12),
          IconTheme(data: IconThemeData(color: color), child: item.trailing!),
        ],
        if (isInDrawer) ...[
          const SizedBox(width: 12),
          Icon(
            _rtl ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
            color: color.withValues(alpha: 0.8),
          ),
        ],
      ],
    );
  }

  Widget _controlsCard() {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Controls',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: [
                _boolChip(
                  label: 'RTL',
                  value: _rtl,
                  onChanged: (v) => setState(() => _rtl = v),
                ),
                _boolChip(
                  label: 'Controlled',
                  value: _controlled,
                  onChanged: (v) => setState(() => _controlled = v),
                ),
                _boolChip(
                  label: 'KeepAlive',
                  value: _keepAlive,
                  onChanged: (v) => setState(() => _keepAlive = v),
                ),
                _boolChip(
                  label: 'Force Sidebar',
                  value: _forceSidebar,
                  onChanged: (v) => setState(() => _forceSidebar = v),
                ),
                _boolChip(
                  label: 'Tab Builder',
                  value: _customTabs,
                  onChanged: (v) => setState(() => _customTabs = v),
                ),
                _boolChip(
                  label: 'EmptyState',
                  value: _showEmpty,
                  onChanged: (v) => setState(() => _showEmpty = v),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final segmented = SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('0')),
                      ButtonSegment(value: 1, label: Text('1')),
                      ButtonSegment(value: 2, label: Text('2')),
                      ButtonSegment(value: 3, label: Text('3')),
                    ],
                    selected: {_selectedIndex.clamp(0, 3)},
                    onSelectionChanged: (s) {
                      final v = s.first;
                      setState(() => _selectedIndex = v);
                    },
                  ),
                );

                if (constraints.maxWidth < 360) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Index:'),
                      const SizedBox(height: 8),
                      segmented,
                    ],
                  );
                }

                return Row(
                  children: [
                    const Text('Index:'),
                    const SizedBox(width: 10),
                    Expanded(child: segmented),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _boolChip({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return FilterChip(
      label: Text(label),
      selected: value,
      onSelected: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _showEmpty ? <DrawerListTile>[] : _buildTabs();
    final pages = _showEmpty ? <Widget>[] : _pages;

    final theme = VerticalTabBarTheme.linearGradient(
      gradientColors: [Colors.deepPurple.shade400, Colors.blue.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      backgroundColor: Colors.grey.shade50,
      indicatorColor: Colors.deepPurple.shade700,
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      unselectedTextStyle: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 15,
      ),
      selectedIconColor: Colors.white,
      unselectedIconColor: Colors.grey.shade700,
      tabBorderRadius: BorderRadius.circular(14),
      selectedTabElevation: 2,
      listTilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      tabPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      tabDividerColor: Colors.grey.shade200,
    );

    final widgetTree = VerticalTabBar(
      drawerListTiles: tabs,
      pages: pages,
      theme: theme,
      keepAlivePages: _keepAlive,
      initialIndex: 1,
      selectedIndex: _controlled ? _selectedIndex : null,
      onTabChanged: (i) {
        if (_controlled) {
          setState(() => _selectedIndex = i);
        }
        _showSnack('onTabChanged: $i');
      },
      showTabDivider: true,
      sidebarHeader: _controlsCard(),
      sidebarFooter: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.tonal(
            onPressed: () => _showSnack('Sidebar footer'),
            child: const Text('Sidebar Footer Action'),
          ),
        ),
      ),
      drawerHeader: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Drawer Header',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: () => _showSnack('Header action 1'),
                    child: const Text('Action 1'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => _showSnack('Header action 2'),
                    child: const Text('Action 2'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawerFooter: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () => _showSnack('Drawer footer'),
                  child: const Text('Drawer Footer Action'),
                ),
              ),
            ],
          ),
        ),
      ),
      emptyState: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 52),
            const SizedBox(height: 12),
            const Text(
              'Empty State فعال است',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => setState(() => _showEmpty = false),
              child: const Text('برگرد به حالت عادی'),
            ),
          ],
        ),
      ),
      enableDrawerMode: true,
      tabletBreakpoint: _forceSidebar ? 0 : 900,
      drawerWidth: 320,
      widthTabBar: 320,
      tabBuilder: _customTabs ? _buildTabBuilder : null,
      appBarTitle: const Text('Advanced Features'),
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => setState(() {}),
        ),
      ],
    );

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(body: widgetTree),
    );
  }
}

class _CounterPage extends StatefulWidget {
  final String title;
  final Color color;

  const _CounterPage({required this.title, required this.color});

  @override
  State<_CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<_CounterPage> {
  int _count = 0;
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.all(16),
        itemCount: 30,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Card(
              color: widget.color.withValues(alpha: 0.10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Counter: $_count',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () => setState(() => _count++),
                      child: const Text('+1'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListTile(
            title: Text('${widget.title} Item $index'),
            subtitle: const Text('اسکرول کن و تب عوض کن'),
          );
        },
      ),
    );
  }
}

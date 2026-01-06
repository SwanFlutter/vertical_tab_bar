# Vertical Tab Bar

یک پکیج Flutter حرفه‌ای برای ساخت تب بار عمودی با انیمیشن‌های روان و طراحی Responsive

## ویژگی‌ها ✨

- 🎨 **انیمیشن‌های روان و حرفه‌ای** - تغییر بین تب‌ها با انیمیشن‌های زیبا
- 📱 **Responsive Design** - حالت Drawer برای موبایل و Sidebar برای دسکتاپ
- 🎭 **تم‌های قدرتمند** - پشتیبانی از رنگ‌های ساده، گرادیانت خطی و شعاعی
- ⚙️ **قابل تنظیم** - کنترل کامل بر روی ظاهر و رفتار
- 🧠 **حفظ State صفحات** - امکان نگه داشتن صفحات برای جلوگیری از reset شدن
- 🎛️ **کنترل‌پذیر** - `selectedIndex` و `onTabChanged` برای مدیریت بیرونی
- 🧩 **قابلیت‌های تب** - Badge، trailing و `onTap` برای هر تب
- 🧱 **اسلات‌ها** - Header/Footer برای Sidebar و Drawer
- 🚀 **بهینه‌سازی شده** - عملکرد سریع و روان
- 🌐 **RTL Support** - پشتیبانی کامل از زبان‌های راست به چپ

## نصب 📦

فایل `pubspec.yaml` خود را ویرایش کنید:

```yaml
dependencies:
  vertical_tab_bar: ^latest_version
```

سپس دستور زیر را اجرا کنید:

```bash
flutter pub get
```

## نصب از GitHub 🔧

برای استفاده از آخرین نسخه توسعه مستقیماً از GitHub، این را به `pubspec.yaml` خود اضافه کنید:

```yaml
dependencies:
  vertical_tab_bar:
    git:
      url: https://github.com/SwanFlutter/vertical_tab_bar.git
      ref: main
```

سپس دستور زیر را اجرا کنید:

```bash
flutter pub get
```

## استفاده سریع 🚀

### مثال ساده

```dart
import 'package:flutter/material.dart';
import 'package:vertical_tab_bar/vertical_tab_bar.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VerticalTabBar(
      drawerListTiles: [
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
      ],
      pages: [
        Center(child: Text('صفحه خانه')),
        Center(child: Text('صفحه پروفایل')),
        Center(child: Text('صفحه تنظیمات')),
      ],
    );
  }
}
```

### کنترل تب + حفظ State صفحات

```dart
class ControlledTabsExample extends StatefulWidget {
  const ControlledTabsExample({super.key});

  @override
  State<ControlledTabsExample> createState() => _ControlledTabsExampleState();
}

class _ControlledTabsExampleState extends State<ControlledTabsExample> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return VerticalTabBar(
      drawerListTiles: const [
        DrawerListTile(title: 'خانه', icon: Icon(Icons.home)),
        DrawerListTile(title: 'پروفایل', icon: Icon(Icons.person)),
      ],
      pages: const [
        Center(child: Text('صفحه خانه')),
        Center(child: Text('صفحه پروفایل')),
      ],
      selectedIndex: selectedIndex,
      onTabChanged: (i) => setState(() => selectedIndex = i),
      keepAlivePages: true,
    );
  }
}
```

### Badge / Trailing / onTap

```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(
      title: 'پیام‌ها',
      icon: const Icon(Icons.message),
      badge: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Text(
          '12',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
      trailing: const Icon(Icons.chevron_left),
      onTap: () {},
    ),
  ],
  pages: const [Center(child: Text('صفحه پیام‌ها'))],
)
```

### Header/Footer + TabBuilder + EmptyState

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  sidebarHeader: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Header Sidebar'),
  ),
  sidebarFooter: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Footer Sidebar'),
  ),
  drawerHeader: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Header Drawer'),
  ),
  drawerFooter: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Footer Drawer'),
  ),
  emptyState: const Center(child: Text('هیچ تبی وجود ندارد')),
  tabBuilder: (context, index, isSelected, item, isInDrawer) {
    final color = isSelected ? Colors.white : Colors.black87;
    return Row(
      children: [
        Icon(item.icon.icon, color: color),
        const SizedBox(width: 12),
        Expanded(child: Text(item.title, style: TextStyle(color: color))),
        if (item.trailing != null) item.trailing!,
      ],
    );
  },
)
```

### دکمه‌های عملیاتی (فقط نویگیشن)

از `isAction: true` برای ایجاد دکمه‌ای استفاده کنید که فقط `onTap` را اجرا می‌کند و تب انتخاب‌شده را تغییر نمی‌دهد (مثلاً دکمه "خانه" که به یک مسیر دیگر هدایت می‌کند).

```dart
VerticalTabBar(
  initialIndex: 1, // شروع از داشبورد (چون ایندکس 0 دکمه عملیاتی است)
  drawerListTiles: [
    // ایندکس 0: دکمه صفحه اصلی (فقط نویگیشن)
    DrawerListTile(
      title: 'صفحه اصلی',
      icon: Icon(Icons.home),
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      isAction: true, // <--- این خط مهم است: باعث می‌شود تب انتخاب نشود
    ),
    // ایندکس 1: داشبورد
    DrawerListTile(
      title: 'داشبورد',
      icon: Icon(Icons.dashboard),
    ),
  ],
  pages: [
    SizedBox(), // ویجت خالی برای دکمه صفحه اصلی
    DashboardPage(),
  ],
)
```

### مثال با اکشن‌های AppBar

اضافه کردن اکشن‌های سفارشی به AppBar (تغییر زبان، تغییر تم و غیره):

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  appBarTitle: Text('برنامه من'),
  appBarActions: [
    // تغییر زبان
    PopupMenuButton<String>(
      icon: Icon(Icons.language),
      tooltip: 'زبان',
      onSelected: (String value) {
        // تغییر زبان
        if (value == 'en') {
          // تغییر به انگلیسی
        } else if (value == 'fa') {
          // تغییر به فارسی
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              Icon(Icons.language, size: 20),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'fa',
          child: Row(
            children: [
              Icon(Icons.language, size: 20),
              SizedBox(width: 8),
              Text('فارسی'),
            ],
          ),
        ),
      ],
    ),
    // تغییر تم
    IconButton(
      icon: Icon(Icons.dark_mode),
      tooltip: 'تغییر تم',
      onPressed: () {
        // منطق تغییر تم
      },
    ),
  ],
)
```

### مثال با رنگ سفارشی

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  colorSelectedMenu: Colors.blue.shade700,  // رنگ آیکون و متن انتخاب شده
  tabColor: Colors.blue.shade100,           // رنگ پس‌زمینه تب انتخاب شده
  colorMenu: Colors.white,                  // رنگ پس‌زمینه تب‌های غیرفعال
  dividerColor: Colors.grey.shade300,       // رنگ خط جداکننده
  showDivider: true,                        // نمایش خط جداکننده
)
```

### مثال با استایل متن سفارشی

```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(
      title: 'Dashboard',
      icon: Icon(Icons.dashboard),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.deepPurple,
      ),
    ),
    DrawerListTile(
      title: 'Settings',
      icon: Icon(Icons.settings),
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.teal,
        fontStyle: FontStyle.italic,
      ),
    ),
  ],
  pages: myPages,
)
```

## تم‌ها 🎨

### 1. تم با رنگ ساده

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.solid(
    selectedColor: Colors.blue.shade100,
    unselectedColor: Colors.transparent,
    indicatorColor: Colors.blue,
    selectedIconColor: Colors.blue.shade700,
    unselectedIconColor: Colors.grey,
    selectedTextStyle: TextStyle(
      color: Colors.blue.shade900,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    unselectedTextStyle: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 15,
    ),
  ),
)
```

### 2. تم با گرادیانت خطی

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.linearGradient(
    gradientColors: [
      Colors.purple.shade300,
      Colors.blue.shade300,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    indicatorColor: Colors.purple.shade700,
    selectedIconColor: Colors.white,
    unselectedIconColor: Colors.grey.shade600,
  ),
)
```

### 3. تم با گرادیانت شعاعی

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.radialGradient(
    gradientColors: [
      Colors.orange.shade200,
      Colors.red.shade300,
    ],
    center: Alignment.center,
    radius: 0.8,
    indicatorColor: Colors.red.shade700,
  ),
)
```

## تنظیمات انیمیشن ⚡

### کنترل کامل انیمیشن‌ها

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.solid(
    selectedColor: Colors.green.shade100,
    indicatorColor: Colors.green,
    // تنظیمات انیمیشن
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOutCubic,
    enableScaleAnimation: true,      // انیمیشن zoom تب
    enableFadeAnimation: true,       // انیمیشن fade صفحات
    enableSlideAnimation: true,      // انیمیشن slide صفحات
    enableIndicatorShadow: true,     // سایه indicator
  ),
)
```

### منحنی‌های انیمیشن پیشنهادی

| منحنی | توضیح | مناسب برای |
|-------|-------|-----------|
| `Curves.easeInOutCubic` | نرم و طبیعی | استفاده عمومی ⭐ |
| `Curves.easeOutQuart` | شروع سریع، پایان آهسته | اپلیکیشن‌های سریع |
| `Curves.easeInOutBack` | با افکت bounce | اپلیکیشن‌های بازی‌گونه |
| `Curves.fastOutSlowIn` | استاندارد Material Design | اپلیکیشن‌های Material |
| `Curves.easeInOutCubicEmphasized` | خیلی نرم و لوکس | اپلیکیشن‌های پرمیوم |

## تنظیمات Responsive 📱

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  // نقاط شکست
  mobileBreakpoint: 600,      // زیر 600px = موبایل
  tabletBreakpoint: 900,      // 600-900px = تبلت
  enableDrawerMode: true,     // فعال‌سازی حالت drawer
  // تنظیمات drawer
  drawerWidth: 300,
  showMenuButton: true,
  appBarTitle: Text('عنوان برنامه'),
  // تنظیمات sidebar
  widthTabBar: 250,
)
```

## تنظیمات ظاهری 🎯

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  // اندازه‌ها
  widthTabBar: 250,              // عرض sidebar
  heightAnimatedBox: 55,         // ارتفاع indicator
  widthAnimatedBox: 6,           // عرض indicator
  height: 65,                    // ارتفاع هر تب
  // رنگ‌ها (deprecated - از theme استفاده کنید)
  backgroundColor: Colors.white,
  tabColor: Colors.blue.shade100,
  colorMenu: Colors.white,
  colorSelectedMenu: Colors.blue.shade700,  // رنگ آیکون و متن انتخاب شده
  dividerColor: Colors.grey.shade300,       // رنگ خط جداکننده
  showDivider: true,                        // نمایش خط جداکننده
  // فاصله‌ها (deprecated - از theme استفاده کنید)
  horizontalPadding: 16,
  verticalPadding: 12,
)
```

## پارامترهای Theme 📋

### VerticalTabBarTheme

| پارامتر | نوع | پیشفرض | توضیح |
|---------|-----|--------|-------|
| `selectedTabDecoration` | BoxDecoration? | null | دکوراسیون تب انتخاب شده |
| `unselectedTabDecoration` | BoxDecoration? | null | دکوراسیون تب‌های غیرفعال |
| `backgroundColor` | Color? | null | رنگ پس‌زمینه تب بار |
| `indicatorColor` | Color? | null | رنگ نشانگر تب |
| `indicatorWidth` | double? | 5 | عرض نشانگر |
| `indicatorHeight` | double? | 50 | ارتفاع نشانگر |
| `selectedTextStyle` | TextStyle? | null | استایل متن تب انتخاب شده |
| `unselectedTextStyle` | TextStyle? | null | استایل متن تب‌های غیرفعال |
| `selectedIconColor` | Color? | null | رنگ آیکون تب انتخاب شده |
| `unselectedIconColor` | Color? | null | رنگ آیکون تب‌های غیرفعال |
| `iconSize` | double? | 24 | اندازه آیکون‌ها |
| `iconTextSpacing` | double | 8 | فاصله بین آیکون و متن |
| `tabPadding` | EdgeInsets | (12, 8) | padding داخل تب |
| `listTilePadding` | EdgeInsets | 0 | padding اطراف هر آیتم تب |
| `animationDuration` | Duration | 300ms | مدت زمان انیمیشن |
| `animationCurve` | Curve | easeInOut | منحنی انیمیشن |
| `tabBorderRadius` | BorderRadius? | null | گردی گوشه‌های تب‌ها |
| `selectedTabElevation` | double? | null | elevation تب انتخاب‌شده |
| `enableScaleAnimation` | bool | true | فعال/غیرفعال zoom تب |
| `enableFadeAnimation` | bool | true | فعال/غیرفعال fade صفحات |
| `enableSlideAnimation` | bool | true | فعال/غیرفعال slide صفحات |
| `enableIndicatorShadow` | bool | true | فعال/غیرفعال سایه indicator |
| `dividerColor` | Color? | null | رنگ خط جداکننده کنار sidebar |
| `tabDividerColor` | Color? | null | رنگ خط بین تب‌ها |

## اجرای مثال کامل

```bash
cd example
flutter run -t lib/advanced_features_example.dart
```

## مثال جدا: Sidebar Widget

برای تست `VerticalTabBar.sidebar()`:

```bash
cd example
flutter run -t lib/sidebar_widget_example.dart
```

## مثال‌های پیشرفته 🔥

### مثال 1: اپلیکیشن داشبورد

```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(title: 'داشبورد', icon: Icon(Icons.dashboard)),
    DrawerListTile(title: 'آمار', icon: Icon(Icons.analytics)),
    DrawerListTile(title: 'گزارش‌ها', icon: Icon(Icons.assessment)),
    DrawerListTile(title: 'کاربران', icon: Icon(Icons.people)),
  ],
  pages: [
    DashboardPage(),
    AnalyticsPage(),
    ReportsPage(),
    UsersPage(),
  ],
  theme: VerticalTabBarTheme.linearGradient(
    gradientColors: [Colors.indigo.shade400, Colors.blue.shade400],
    selectedIconColor: Colors.white,
    selectedTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    animationDuration: Duration(milliseconds: 350),
    animationCurve: Curves.easeOutCubic,
  ),
  widthTabBar: 280,
  appBarTitle: Text('پنل مدیریت'),
)
```

### مثال 2: اپلیکیشن فروشگاهی

```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(title: 'محصولات', icon: Icon(Icons.shopping_bag)),
    DrawerListTile(title: 'سبد خرید', icon: Icon(Icons.shopping_cart)),
    DrawerListTile(title: 'علاقه‌مندی‌ها', icon: Icon(Icons.favorite)),
    DrawerListTile(title: 'سفارشات', icon: Icon(Icons.receipt_long)),
  ],
  pages: [
    ProductsPage(),
    CartPage(),
    FavoritesPage(),
    OrdersPage(),
  ],
  theme: VerticalTabBarTheme.solid(
    selectedColor: Colors.orange.shade100,
    indicatorColor: Colors.orange.shade700,
    selectedIconColor: Colors.orange.shade900,
    animationDuration: Duration(milliseconds: 300),
    enableScaleAnimation: true,
  ),
  mobileBreakpoint: 600,
  tabletBreakpoint: 1024,
)
```

### مثال 3: انیمیشن سفارشی

```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.radialGradient(
    gradientColors: [
      Colors.pink.shade200,
      Colors.purple.shade300,
    ],
    // انیمیشن خیلی آهسته و نرم
    animationDuration: Duration(milliseconds: 600),
    animationCurve: Curves.easeInOutCubicEmphasized,
    // فقط fade، بدون slide و scale
    enableScaleAnimation: false,
    enableSlideAnimation: false,
    enableFadeAnimation: true,
  ),
)
```

## نکات بهینه‌سازی ⚡

### 1. سرعت انیمیشن

```dart
// برای اپلیکیشن‌های سبک و سریع
animationDuration: Duration(milliseconds: 200-300)

// برای اپلیکیشن‌های لوکس و پرمیوم
animationDuration: Duration(milliseconds: 400-600)
```

### 2. عملکرد در دستگاه‌های ضعیف

```dart
// غیرفعال کردن برخی انیمیشن‌ها
theme: VerticalTabBarTheme.solid(
  selectedColor: Colors.blue,
  enableScaleAnimation: false,  // کاهش بار CPU
  enableSlideAnimation: false,  // کاهش بار GPU
  enableFadeAnimation: true,    // سبک‌ترین انیمیشن
)
```

### 3. بهترین تجربه کاربری

```dart
// تنظیمات پیشنهادی برای بهترین UX
theme: VerticalTabBarTheme.linearGradient(
  gradientColors: [color1, color2],
  animationDuration: Duration(milliseconds: 350),
  animationCurve: Curves.easeInOutCubic,
  enableScaleAnimation: true,
  enableFadeAnimation: true,
  enableSlideAnimation: true,
  enableIndicatorShadow: true,
)
```

## رفع مشکلات 🔧

### مشکل: تب‌ها در تست نمایش داده نمی‌شوند

```dart
testWidgets('test', (tester) async {
  // تنظیم اندازه صفحه
  tester.view.physicalSize = Size(1200, 800);
  tester.view.devicePixelRatio = 1.0;
  
  // تست شما
  
  // ریست کردن
  addTearDown(tester.view.reset);
});
```

### مشکل: انیمیشن‌ها کند هستند

```dart
// کاهش مدت زمان انیمیشن
animationDuration: Duration(milliseconds: 200)

// یا غیرفعال کردن برخی انیمیشن‌ها
enableScaleAnimation: false
```

### مشکل: Drawer در موبایل باز نمی‌شود

```dart
// مطمئن شوید که enableDrawerMode فعال است
VerticalTabBar(
  enableDrawerMode: true,
  showMenuButton: true,
  // ...
)
```

## مثال کامل 📱

برای مشاهده یک مثال کامل و کاربردی، فایل `example/lib/main.dart` را مشاهده کنید.

برای اجرای مثال:

```bash
cd example
flutter run
```

## مشارکت 🤝

مشارکت‌ها همیشه خوش‌آمد هستند! لطفاً:

1. Repository را Fork کنید
2. یک Branch جدید بسازید (`git checkout -b feature/amazing-feature`)
3. تغییرات خود را Commit کنید (`git commit -m 'Add amazing feature'`)
4. به Branch خود Push کنید (`git push origin feature/amazing-feature`)
5. یک Pull Request باز کنید

## لایسنس 📄

این پروژه تحت لایسنس MIT منتشر شده است - فایل [LICENSE](LICENSE) را برای جزئیات بیشتر مشاهده کنید.

## تماس با ما 📧

اگر سوال یا پیشنهادی دارید، لطفاً یک Issue باز کنید.

---

ساخته شده با ❤️ برای جامعه Flutter

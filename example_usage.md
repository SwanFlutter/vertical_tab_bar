# How to Use Advanced Animations in VerticalTabBar

## New Animation Features
Your package now includes the following smooth and professional animations:

### 1. Tab Change Animations
- **Scale Animation**: The selected tab is displayed with a zoom effect.
- **Fade Animation**: Icons are displayed with opacity changes.
- **Smooth Indicator**: The tab indicator moves smoothly with a shadow effect.
- **Text Style Transition**: Text animates smoothly between different states.

### 2. Page Change Animations
- **Fade Transition**: Pages transition with fade in/out effects.
- **Slide Transition**: Pages appear with a smooth right-to-left motion.
- **Smooth Page Navigation**: Uses `animateToPage` instead of `jumpToPage`.

---

## Usage Examples

### Example 1: Simple Theme with Default Animations
```dart
VerticalTabBar(
  drawerListTiles: [
    DrawerListTile(
      title: 'Home',
      icon: Icon(Icons.home),
    ),
    DrawerListTile(
      title: 'Profile',
      icon: Icon(Icons.person),
    ),
  ],
  pages: [
    HomePage(),
    ProfilePage(),
  ],
  theme: VerticalTabBarTheme.solid(
    selectedColor: Colors.blue.shade100,
    unselectedColor: Colors.transparent,
    indicatorColor: Colors.blue,
    selectedIconColor: Colors.blue.shade700,
    unselectedIconColor: Colors.grey,
    // Default animations are enabled
  ),
)
```

### Example 2: Gradient Theme with Fast Animations
```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.linearGradient(
    gradientColors: [
      Colors.purple.shade300,
      Colors.blue.shade300,
    ],
    indicatorColor: Colors.purple,
    animationDuration: Duration(milliseconds: 250), // Faster
    animationCurve: Curves.easeOutQuart, // Sharp curve
  ),
)
```

### Example 3: Disabling Some Animations
```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.solid(
    selectedColor: Colors.green.shade100,
    indicatorColor: Colors.green,
    enableScaleAnimation: false, // No zoom
    enableSlideAnimation: false, // Only fade
    enableFadeAnimation: true,
    animationDuration: Duration(milliseconds: 200),
  ),
)
```

### Example 4: Slow and Smooth Animation
```dart
VerticalTabBar(
  drawerListTiles: myTabs,
  pages: myPages,
  theme: VerticalTabBarTheme.radialGradient(
    gradientColors: [
      Colors.orange.shade200,
      Colors.red.shade200,
    ],
    animationDuration: Duration(milliseconds: 600), // Slow
    animationCurve: Curves.easeInOutCubicEmphasized, // Very smooth
    enableIndicatorShadow: true, // Shadow on indicator
  ),
)
```

---

## Animation Settings in Theme


Animation Parameters


| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `animationDuration` | Duration | 300ms | Duration of the animation |
| `animationCurve` | Curve | easeInOut | Animation curve |
| `enableScaleAnimation` | bool | true | Enable/disable tab zoom |
| `enableFadeAnimation` | bool | true | Enable/disable page fade |
| `enableSlideAnimation` | bool | true | Enable/disable page slide |
| `enableIndicatorShadow` | bool | true | Enable/disable indicator shadow |

---

## Recommended Animation Curves
For smoother animations, try these curves:
- `Curves.easeInOutCubic` – Soft and natural (recommended)
- `Curves.easeOutQuart` – Fast start, slow end
- `Curves.easeInOutBack` – With a bounce effect
- `Curves.fastOutSlowIn` – Standard Material Design
- `Curves.easeInOutCubicEmphasized` – Very smooth and professional

---

## Optimization Tips
1. For lightweight apps: `animationDuration: Duration(milliseconds: 200-300)`
2. For luxury apps: `animationDuration: Duration(milliseconds: 400-600)`
3. If the device is slow, disable `enableScaleAnimation` and `enableSlideAnimation`
4. For the best experience, keep all animations enabled
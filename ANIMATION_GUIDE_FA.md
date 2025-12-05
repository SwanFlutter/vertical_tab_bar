# Vertical Tab Bar Animation Guide

This package includes smooth and professional animations in three main sections:

---

## 1. Sidebar to Drawer Transformation Animation 🔄

When the window size changes (e.g., from desktop to mobile), the sidebar smoothly fades out and is replaced by a drawer.

### Features:
- **Slide Animation**: The sidebar slides from left to right and fades out.
- **Fade Animation**: Opacity changes simultaneously with the slide.
- **Duration**: 350 milliseconds
- **Curve**: `Curves.easeInOutCubic` for smooth movement

### Implementation Code:
```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 350),
  switchInCurve: Curves.easeInOutCubic,
  switchOutCurve: Curves.easeInOutCubic,
  transitionBuilder: (Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),  // Start from the left
        end: Offset.zero,                // End at the original position
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  },
  child: !useDrawer ? _buildSidebar() : SizedBox.shrink(),
)
```

### How to Observe:
1. Run the app in desktop mode.
2. Resize the window to less than 900 pixels.
3. The sidebar will fade out with animation, and the AppBar with a menu button will appear.

---

## 2. Tab Change Animation 🎯

When you click on a tab, multiple animations are executed simultaneously:

### a) Indicator Animation
```dart
AnimatedContainer(
  duration: animationDuration,
  curve: animationCurve,
  height: isSelected ? indicatorHeight : 0,
  width: indicatorWidth,
  decoration: BoxDecoration(
    color: indicatorColor,
    boxShadow: isSelected ? [
      BoxShadow(
        color: indicatorColor.withOpacity(0.4),
        blurRadius: 8,
        offset: const Offset(2, 0),
      ),
    ] : null,
  ),
)
```
**Features:**
- Height changes from 0 to full value.
- Shadow becomes visible.
- Color changes with fade.

### b) Tab Scale Animation
```dart
AnimatedScale(
  scale: isSelected ? 1.0 : 0.98,
  duration: animationDuration,
  curve: animationCurve,
  child: tabContent,
)
```
**Features:**
- The selected tab becomes slightly larger (zoom).
- Other tabs become slightly smaller.
- Subtle effect for visual focus.

### c) Icon Animation
```dart
AnimatedOpacity(
  opacity: isSelected ? 1.0 : 0.7,
  duration: animationDuration,
  child: Icon(...),
)
```
**Features:**
- Selected icon: opacity = 1.0 (fully visible).
- Other icons: opacity = 0.7 (slightly faded).

### d) Text Animation
```dart
AnimatedDefaultTextStyle(
  duration: animationDuration,
  curve: animationCurve,
  style: isSelected ? selectedTextStyle : unselectedTextStyle,
  child: Text(title),
)
```
**Features:**
- Text color changes.
- Font weight (bold/normal) changes.
- Font size can change.

---

## 3. Page Change Animation 📄

When the tab changes, the page transitions with animation:

```dart
AnimatedSwitcher(
  duration: Duration(milliseconds: 400),
  transitionBuilder: (Widget child, Animation<double> animation) {
    Widget result = child;
    // Slide Animation
    if (enableSlideAnimation) {
      result = SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.03, 0),  // Slightly from the right
          end: Offset.zero,              // End at the original position
        ).animate(animation),
        child: result,
      );
    }
    // Fade Animation
    if (enableFadeAnimation) {
      result = FadeTransition(
        opacity: animation,
        child: result,
      );
    }
    return result;
  },
  child: pages[selectedIndex],
)
```
**Features:**
- **Fade**: The previous page fades out, and the new page fades in.
- **Slide**: The new page slides in from the right.
- **Customizable**: You can enable/disable each animation individually.

---

## Animation Settings ⚙️

### Full Control via Theme
```dart
VerticalTabBarTheme.linearGradient(
  gradientColors: [Colors.blue, Colors.purple],
  // Time and curve settings
  animationDuration: Duration(milliseconds: 400),
  animationCurve: Curves.easeInOutCubic,
  // Enable/disable animations
  enableScaleAnimation: true,      // Tab zoom
  enableFadeAnimation: true,       // Page fade
  enableSlideAnimation: true,      // Page slide
  enableIndicatorShadow: true,     // Indicator shadow
)
```

---

## Animation Curves 📈

### Recommended Curves and Their Effects:

#### 1. `Curves.easeInOutCubic` ⭐ (Default)
```dart
animationCurve: Curves.easeInOutCubic
```
- **Feel**: Smooth and natural
- **Speed**: Medium
- **Suitable**: All types of apps

#### 2. `Curves.easeOutQuart`
```dart
animationCurve: Curves.easeOutQuart
```
- **Feel**: Fast start, slow end
- **Speed**: Fast
- **Suitable**: High-speed apps

#### 3. `Curves.easeInOutBack`
```dart
animationCurve: Curves.easeInOutBack
```
- **Feel**: With a bounce effect
- **Speed**: Medium with bounce
- **Suitable**: Game-like apps

#### 4. `Curves.fastOutSlowIn`
```dart
animationCurve: Curves.fastOutSlowIn
```
- **Feel**: Standard Material Design
- **Speed**: Fast start, slow end
- **Suitable**: Material apps

#### 5. `Curves.easeInOutCubicEmphasized`
```dart
animationCurve: Curves.easeInOutCubicEmphasized
```
- **Feel**: Very smooth and luxurious
- **Speed**: Slow
- **Suitable**: Premium apps

---

## Practical Examples 💡

### Example 1: Fast and Responsive Animation
```dart
theme: VerticalTabBarTheme.solid(
  selectedColor: Colors.blue,
  animationDuration: Duration(milliseconds: 200),
  animationCurve: Curves.easeOutQuart,
  enableScaleAnimation: true,
  enableFadeAnimation: true,
  enableSlideAnimation: false,  // No slide for faster speed
)
```

### Example 2: Luxurious and Smooth Animation
```dart
theme: VerticalTabBarTheme.linearGradient(
  gradientColors: [Colors.purple, Colors.pink],
  animationDuration: Duration(milliseconds: 600),
  animationCurve: Curves.easeInOutCubicEmphasized,
  enableScaleAnimation: true,
  enableFadeAnimation: true,
  enableSlideAnimation: true,
  enableIndicatorShadow: true,
)
```

### Example 3: Playful Animation
```dart
theme: VerticalTabBarTheme.radialGradient(
  gradientColors: [Colors.orange, Colors.red],
  animationDuration: Duration(milliseconds: 350),
  animationCurve: Curves.easeInOutBack,  // With bounce
  enableScaleAnimation: true,
  enableFadeAnimation: true,
  enableSlideAnimation: true,
)
```

### Example 4: Minimal Animation (For Low-End Devices)
```dart
theme: VerticalTabBarTheme.solid(
  selectedColor: Colors.green,
  animationDuration: Duration(milliseconds: 150),
  animationCurve: Curves.linear,
  enableScaleAnimation: false,
  enableFadeAnimation: true,  // Only fade
  enableSlideAnimation: false,
  enableIndicatorShadow: false,
)
```

---

## Performance Optimization 🚀

### Tips for Better Performance:
1. **Reduce Animation Duration**
   ```dart
   animationDuration: Duration(milliseconds: 200)  // Instead of 400
   ```
2. **Disable Heavy Animations**
   ```dart
   enableScaleAnimation: false,  // Reduce CPU load
   enableSlideAnimation: false,  // Reduce GPU load
   ```
3. **Use Simple Curves**
   ```dart
   animationCurve: Curves.linear  // Instead of easeInOutCubic
   ```
4. **Disable Shadows**
   ```dart
   enableIndicatorShadow: false  // Reduce rendering load
   ```

---

## Testing Animations 🧪

To test animations at different sizes:

```dart
// In tests
testWidgets('animation test', (tester) async {
  // Set desktop size
  tester.view.physicalSize = Size(1200, 800);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(myApp);

  // Change to mobile
  tester.view.physicalSize = Size(400, 800);
  await tester.pumpAndSettle();  // Wait for animation to complete

  // Check drawer
  expect(find.byType(Drawer), findsOneWidget);

  addTearDown(tester.view.reset);
});
```

---

## Summary ✨

This package includes **5 main types of animations**:
1. ✅ **Sidebar ↔ Drawer**: Smooth transition between different states.
2. ✅ **Indicator**: Movement and appearance of the tab indicator.
3. ✅ **Tab Scale**: Zoom of the selected tab.
4. ✅ **Icon/Text**: Change in opacity and style.
5. ✅ **Page Transition**: Fade and slide between pages.

All these animations are **customizable** and **optimized**! 🎉
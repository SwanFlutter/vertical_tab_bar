# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-07-21

### Added

#### Badge Support for Tabs
- **`TabBadge` widget**: New dedicated badge widget in `src/widgets/tab_badge.dart`
  - `TabBadge(count: n)` — شمارنده با اعداد، برای تعداد بالای `maxCount` نمایش `99+` می‌دهد
  - `TabBadge.dot()` — نقطه ساده بدون عدد (مناسب برای نشان دادن وضعیت)
  - `TabBadge.custom(child: ...)` — ویجت دلخواه داخل badge
  - پشتیبانی از رنگ، اندازه، border و انیمیشن روی تغییر شمارنده
- **`badgeBuilder` در `DrawerListTile`**: builder داینامیک برای badge
  - هر بار بازسازی تب، builder فراخوانی می‌شود — وضعیت زنده را منعکس می‌کند
  - اگر هم `badge` و هم `badgeBuilder` تعریف شده باشد، `badgeBuilder` اولویت دارد
  - می‌تواند `null` برگرداند تا badge پنهان شود

### Fixed
- حذف `_scaleController` (AnimationController بلااستفاده / dead code) از `VerticalTabBarState`
- حذف `SingleTickerProviderStateMixin` که دیگر نیاز نبود
- حذف کامنت `// ignore_for_file: use_build_context_synchronously` که بدون دلیل واقعی بود
- موقعیت badge روی آیکون از `top: -4` به `top: -6` اصلاح شد برای نمایش بهتر

## [1.1.0] - 2024-02-07

### Added - Sidebar Enhancements

#### Sidebar Widget
- **User Profile Section**: Added `userName`, `userSubtitle`, `userImageUrl`, and `userAvatar` properties
- **Logout Button**: Added `showLogoutButton`, `onLogout`, and `logoutText` properties
- **Auto Avatar**: Automatically generates avatar from first letter of username if no image provided
- **Responsive Footer**: Footer adapts to collapsed/expanded state
- **Brand Background**: Added `showBrandBackground`, `brandLogoLight`, `brandLogoDark`, and `brandLogoOpacity` properties
  - Brand logo stays fixed in background
  - Automatically switches between light/dark versions
  - Items scroll over the brand logo
  - Customizable opacity (0.0 to 1.0)

#### Helper Widgets
- **ProfileSection**: Reusable user profile widget for sidebar footer
- **LogoutButton**: Styled logout button widget

### Changed
- Enhanced `Sidebar` widget with footer customization
- Improved responsive behavior for collapsed sidebar
- Better RTL support for profile section
- Fixed overflow issues in collapsed state

### Example
- Updated `sidebar_example.dart` with profile and logout demo
- Added `sidebar_with_brand_example.dart` for brand background demo
- Added `sidebar_collapse_test.dart` for testing collapse behavior

## [1.0.0] - 2024-01-15

### Added
- Initial release
- Vertical tab bar with responsive design
- Drawer mode for mobile, Sidebar for desktop
- Theme support (solid colors, gradients)
- State preservation with keep-alive pages
- Controlled/uncontrolled modes
- Badge and trailing widget support
- Custom tab builder
- RTL support

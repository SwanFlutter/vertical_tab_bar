# Changelog

All notable changes to this project will be documented in this file.

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

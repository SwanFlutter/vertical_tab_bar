# Vertical Tab Bar Example

This is an example app demonstrating the usage of the `vertical_tab_bar` package.

## Running the Examples

### Main Example (Full Featured)

```bash
cd example
flutter run
```

This will run `lib/main.dart` which includes:
- 5 different pages (Home, Profile, Settings, Messages, Notifications)
- Linear gradient theme
- All animation features enabled
- Responsive design demonstration

### Simple Example

```bash
cd example
flutter run -t lib/simple_example.dart
```

This will run a simpler version with:
- 4 basic pages
- Minimal setup
- Easy to understand code

### Color Example

```bash
cd example
flutter run -t lib/color_example.dart
```

This demonstrates the `colorSelectedMenu` parameter:
- Custom selected icon and text color
- Simple color configuration
- Clean example code

### Custom Style Example

```bash
cd example
flutter run -t lib/custom_style_example.dart
```

This demonstrates custom text styles for each tab:
- Individual `textStyle` for each `DrawerListTile`
- Different fonts, sizes, and colors per tab
- Merges with theme styles

## Features Demonstrated

- ✅ Responsive design (sidebar on desktop, drawer on mobile)
- ✅ Smooth animations between tabs
- ✅ Linear gradient theme
- ✅ Custom icons and text
- ✅ Multiple pages with different content
- ✅ Animated sidebar ↔ drawer transition

## Resize the Window

Try resizing the window to see the smooth animation when the sidebar transforms into a drawer!

- **Desktop mode** (width > 900px): Sidebar visible
- **Tablet mode** (600px < width < 900px): Drawer mode
- **Mobile mode** (width < 600px): Drawer mode

## Learn More

For more information and documentation, see the main [README](../README.md).

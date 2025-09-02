# Flutter Common Components

A collection of common Flutter UI components for building responsive applications.

## Features

### Common Components
- **Circular Progress Cards**: Display statistics with circular progress indicators
- **Info Buttons**: Icon and text button variants for displaying information
- **Info Rows**: Builder function for creating consistent info display rows
- **Module Containers**: Container component for organizing content modules
- **Pagination Widget**: Customizable pagination with various styles
- **Summary Cards**: Desktop and mobile versions for displaying key metrics
- **Top-Level Snackbars**: Notification system for app-wide messages

### Layout Components
- **ResponsiveScaffold**: Animated responsive scaffold with side menu
- **ResponsiveLayout**: Base layout component with AppBar and TabBar support
- **ResponsivePage**: Page component with responsive content builder
- **ResponsiveUtils**: Screen type detection and responsive helpers

### Template Components
- **TabBarContainer**: Container with automatic TabController management
- **TabBarStyle**: Preset styles for TabBar components
- **SimpleTabView**: Simple tab view implementation

### Dialog Components
- **AppAboutDialog**: About dialog with package information

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_common_components:
    git:
      url: https://github.com/zpy-0713/fl_common_components.git
      ref: main
```

## Usage

Import the package in your Dart code:

```dart
import 'package:flutter_common_components/flutter_common_components.dart';
```

### Layout Components

#### ResponsiveScaffold

```dart
ResponsiveScaffold(
  title: Text('My App'),
  menuTitle: Image.asset('assets/logo.png'),
  menuItems: [
    ResponsiveMenuItems(
      label: 'Home',
      icon: Icons.home,
      route: 'home',
    ),
    ResponsiveMenuItems(
      label: 'Settings',
      icon: Icons.settings,
      route: 'settings',
    ),
  ],
  onSelect: (index) => print('Selected item $index'),
  body: YourPageContent(),
)
```

#### ResponsiveLayout

```dart
ResponsiveLayout(
  title: Text('Page Title'),
  body: YourPageContent(),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () => print('Search'),
    ),
  ],
)
```

#### ResponsivePage

```dart
ResponsivePage(
  title: Text('Responsive Page'),
  contentBuilder: (context, screenType) {
    switch (screenType) {
      case ScreenType.mobile:
        return MobileLayout();
      case ScreenType.tablet:
        return TabletLayout();
      case ScreenType.desktop:
        return DesktopLayout();
    }
  },
)
```

### Template Components

#### TabBarContainer

```dart
TabBarContainer(
  tabs: [
    Tab(text: 'Tab 1'),
    Tab(text: 'Tab 2'),
    Tab(text: 'Tab 3'),
  ],
  tabBuilder: (context, index) {
    return Center(child: Text('Content for Tab ${index + 1}'));
  },
  onTabChanged: (index) => print('Tab $index selected'),
)
```

### Dialog Components

#### AppAboutDialog

```dart
showDialog(
  context: context,
  builder: (context) => AppAboutDialog(),
);
```

### Responsive Utilities

```dart
// Check screen type
if (ResponsiveUtils.isMobile(context)) {
  // Mobile-specific code
}

// Get screen type
final screenType = ResponsiveUtils.getScreenType(context);

// Responsive values
final padding = ResponsiveUtils.responsive(
  context,
  mobile: 16.0,
  tablet: 24.0,
  desktop: 32.0,
);

// Using the common utilities (with prefix to avoid conflicts)
if (CommonResponsiveUtils.isMobile(context)) {
  // Mobile-specific code
}
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
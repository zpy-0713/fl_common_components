/// Flutter Common Components
///
/// A collection of common Flutter UI components for building responsive applications.
///
/// This package provides:
/// - Circular progress cards for displaying statistics
/// - Info buttons and rows for displaying information
/// - Module containers for organizing content
/// - Summary cards for displaying key metrics
/// - Top-level snackbars for notifications
/// - Pagination widgets for data navigation
/// - Responsive utilities for adaptive layouts
/// - Layout components (ResponsiveScaffold, ResponsiveLayout, ResponsivePage)
/// - Template components (TabBarContainer)
/// - Dialog components (AboutDialog)
library flutter_common_components;

// Export all components
export 'src/components/circular_progress_card.dart';
export 'src/components/info_button.dart';
export 'src/components/info_row.dart';
export 'src/components/module_container.dart';
export 'src/components/pagination_widget.dart';
export 'src/components/summary_card.dart';
export 'src/components/top_level_snackbar.dart';

// Layout components
export 'src/layout/responsive_scaffold.dart';
export 'src/layout/responsive_layout.dart';
export 'src/layout/responsive_page.dart';
export 'src/layout/responsive_utils.dart';

// Template components
export 'src/template/tab_bar_container.dart';

// Dialog components
export 'src/dialogs/about_dialog.dart';

// Export utilities with prefix to avoid conflicts
export 'src/utils/responsive_utils.dart'
    show CommonResponsiveUtils, CommonScreenType;

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
library flutter_common_components;

// Export all components
export 'src/components/circular_progress_card.dart';
export 'src/components/info_button.dart';
export 'src/components/info_row.dart';
export 'src/components/module_container.dart';
export 'src/components/pagination_widget.dart';
export 'src/components/summary_card.dart';
export 'src/components/top_level_snackbar.dart';

// Export utilities with prefix to avoid conflicts
export 'src/utils/responsive_utils.dart'
    show CommonResponsiveUtils, CommonScreenType;

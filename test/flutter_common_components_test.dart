import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_common_components/flutter_common_components.dart';

void main() {
  test('package exports are available', () {
    // 测试包是否正确导出
    // Common components
    expect(CircularProgressCard, isNotNull);
    expect(InfoIconButton, isNotNull);
    expect(InfoTextButton, isNotNull);
    expect(ModuleContainer, isNotNull);
    expect(PaginationWidget, isNotNull);
    expect(SummaryCard, isNotNull);
    expect(TopLevelSnackBar, isNotNull);
    
    // Layout components
    expect(ResponsiveScaffold, isNotNull);
    expect(ResponsiveLayout, isNotNull);
    expect(ResponsivePage, isNotNull);
    expect(ResponsiveUtils, isNotNull);
    expect(ScreenType, isNotNull);
    
    // Template components
    expect(TabBarContainer, isNotNull);
    expect(TabBarStyle, isNotNull);
    expect(SimpleTabView, isNotNull);
    
    // Dialog components
    expect(AppAboutDialog, isNotNull);
    
    // Utilities
    expect(CommonResponsiveUtils, isNotNull);
    expect(CommonScreenType, isNotNull);
  });
}

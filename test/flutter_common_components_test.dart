import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_common_components/flutter_common_components.dart';

void main() {
  test('package exports are available', () {
    // 测试包是否正确导出
    expect(CircularProgressCard, isNotNull);
    expect(InfoIconButton, isNotNull);
    expect(InfoTextButton, isNotNull);
    expect(ModuleContainer, isNotNull);
    expect(PaginationWidget, isNotNull);
    expect(SummaryCard, isNotNull);
    expect(TopLevelSnackBar, isNotNull);
    expect(CommonResponsiveUtils, isNotNull);
  });
}

# Flutter Common Components

一个用于构建响应式 Flutter 应用的通用 UI 组件库。

## 功能特性

- 🎯 **响应式设计** - 支持手机、平板、桌面等不同屏幕尺寸
- 🎨 **Material Design** - 遵循 Material Design 设计规范
- 🔧 **高度可定制** - 提供丰富的自定义选项
- 📱 **移动端优化** - 针对移动端提供专门的组件变体
- 🚀 **易于使用** - 简洁的 API 设计

## 安装

在你的 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  flutter_common_components:
    path: ../flutter_common_components  # 本地路径
    # 或者如果发布到 pub.dev
    # flutter_common_components: ^0.0.1
```

然后运行：

```bash
flutter pub get
```

## 使用方法

### 导入库

```dart
import 'package:flutter_common_components/flutter_common_components.dart';
```

### 组件示例

#### 1. 环状进度卡片

```dart
CircularProgressCard(
  title: '完成率',
  percentage: 75.5,
  numerator: 151,
  denominator: 200,
  color: Colors.blue,
)

// 移动端版本
MobileCircularProgressCard(
  title: '完成率',
  percentage: 75.5,
  numerator: 151,
  denominator: 200,
  color: Colors.blue,
)
```

#### 2. 信息按钮

```dart
InfoIconButton(
  icon: Icons.info,
  label: '详细信息',
  value: '这是一个信息提示',
  color: Colors.blue,
)

InfoTextButton(
  buttonText: '查看详情',
  label: '详细信息',
  value: '这是一个信息提示',
  color: Colors.blue,
)
```

#### 3. 信息行

```dart
buildInfoRow(
  context,
  '用户名',
  '张三',
  titleStyle: TextStyle(fontWeight: FontWeight.bold),
  valueStyle: TextStyle(color: Colors.blue),
)
```

#### 4. 模块容器

```dart
ModuleContainer(
  context: context,
  title: '用户管理',
  subtitle: '管理系统用户信息',
  icon: Icons.people,
  iconColor: Colors.blue,
  headerColor: Colors.blue.withOpacity(0.1),
  child: YourContentWidget(),
)
```

#### 5. 统计卡片

```dart
SummaryCard(
  icon: Icons.people,
  value: '1,234',
  label: '总用户数',
  isWide: true,
  color: Colors.green,
)

// 移动端版本
MobileSummaryCard(
  icon: Icons.people,
  value: '1,234',
  label: '总用户数',
  color: Colors.green,
)
```

#### 6. 分页组件

```dart
PaginationWidget(
  currentPage: 1,
  totalItems: 100,
  pageSize: 10,
  onPageChanged: (page) {
    // 处理页码变化
  },
  showTotalCount: true,
  showJumpInput: true,
)
```

#### 7. 顶部通知栏

```dart
TopLevelSnackBar.showSuccess(context, '操作成功！');
TopLevelSnackBar.showError(context, '操作失败！');
TopLevelSnackBar.showWarning(context, '请注意！');
```

#### 8. 响应式工具

```dart
// 检查屏幕类型
if (CommonResponsiveUtils.isMobile(context)) {
  // 手机端逻辑
} else if (CommonResponsiveUtils.isTablet(context)) {
  // 平板端逻辑
} else {
  // 桌面端逻辑
}

// 响应式值
final fontSize = CommonResponsiveUtils.responsive(
  context,
  mobile: 14.0,
  tablet: 16.0,
  desktop: 18.0,
);
```

## 自定义样式

大多数组件都支持自定义样式，例如：

```dart
PaginationWidget(
  // ... 其他参数
  style: PaginationStyle(
    containerPadding: EdgeInsets.all(16),
    spacing: 20.0,
    inputWidth: 60.0,
    jumpButtonText: 'Go',
  ),
)
```

## 响应式断点

默认的响应式断点：
- 手机：< 450px
- 平板：450px - 900px  
- 桌面：> 900px

你可以自定义这些断点：

```dart
CommonResponsiveUtils.isMobile(
  context,
  phoneBreakpoint: 600.0, // 自定义断点
)
```

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！
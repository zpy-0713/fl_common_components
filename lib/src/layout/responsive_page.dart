import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'responsive_layout.dart';
import 'responsive_utils.dart';

/// 响应式页面组件
///
/// 扩展ResponsiveLayout，添加响应式布局支持，
/// 可以根据不同屏幕尺寸调整内容布局
class ResponsivePage extends StatefulWidget {
  const ResponsivePage({
    super.key,
    this.title,
    required this.contentBuilder,
    this.actions,
    this.tabBar,
    this.tabController,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.forceShowBackButton,
    this.forceHideBackButton,
    this.onBackPressed,
    this.showMenuButton = false,
    this.onMenuPressed,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.contentPadding,
    this.safeArea = true,
    this.scrollable = false,
    this.scrollController,
    this.systemUiOverlayStyle,
    this.resizeToAvoidBottomInset,
    this.appBarHeight,
    this.appBarElevation,
    this.centerTitle = false,
    this.drawer,
    this.endDrawer,
    this.phoneBreakpoint = 450, // 手机屏幕的最大宽度
    this.tabletBreakpoint = 900, // 平板屏幕的最大宽度
  });

  /// 页面标题
  final Widget? title;

  /// 页面内容构建器，接收BuildContext和ScreenType，返回对应的布局
  final Widget Function(BuildContext context, ScreenType screenType)
      contentBuilder;

  /// AppBar操作按钮
  final List<Widget>? actions;

  /// AppBar底部TabBar
  final PreferredSizeWidget? tabBar;

  /// TabBar控制器
  final TabController? tabController;

  /// 悬浮按钮
  final Widget? floatingActionButton;

  /// 悬浮按钮位置
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// 底部导航栏
  final Widget? bottomNavigationBar;

  /// 是否强制显示返回按钮
  final bool? forceShowBackButton;

  /// 是否强制隐藏返回按钮
  final bool? forceHideBackButton;

  /// 自定义返回按钮点击行为
  final VoidCallback? onBackPressed;

  /// 是否显示菜单按钮
  final bool showMenuButton;

  /// 菜单按钮点击回调
  final VoidCallback? onMenuPressed;

  /// 背景色
  final Color? backgroundColor;

  /// AppBar背景色
  final Color? appBarBackgroundColor;

  /// 内容填充
  final EdgeInsetsGeometry? contentPadding;

  /// 页面安全区域
  final bool safeArea;

  /// 是否可滚动
  final bool scrollable;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 系统UI覆盖样式
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  /// 是否调整大小以避免键盘遮挡
  final bool? resizeToAvoidBottomInset;

  /// AppBar的高度
  final double? appBarHeight;

  /// AppBar阴影
  final double? appBarElevation;

  /// AppBar中心标题
  final bool centerTitle;

  /// 抽屉菜单
  final Widget? drawer;

  /// 末端抽屉菜单
  final Widget? endDrawer;

  /// 屏幕类型断点 - 手机与平板的分界点
  final double phoneBreakpoint;

  /// 屏幕类型断点 - 平板与桌面的分界点
  final double tabletBreakpoint;

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  @override
  Widget build(BuildContext context) {
    // 获取当前屏幕尺寸
    final double screenWidth = MediaQuery.of(context).size.width;

    // 根据屏幕宽度确定屏幕类型
    final ScreenType screenType = _getScreenType(screenWidth);

    // 构建响应式内容
    final Widget content = widget.contentBuilder(context, screenType);

    // 应用系统UI覆盖样式
    if (widget.systemUiOverlayStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(widget.systemUiOverlayStyle!);
    }

    // 使用ResponsiveLayout构建页面
    return ResponsiveLayout(
      title: widget.title,
      body: content,
      actions: widget.actions,
      tabBar: widget.tabBar,
      tabController: widget.tabController,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
      forceShowBackButton: widget.forceShowBackButton,
      forceHideBackButton: widget.forceHideBackButton,
      onBackPressed: widget.onBackPressed,
      showMenuButton: widget.showMenuButton,
      onMenuPressed: widget.onMenuPressed,
      backgroundColor: widget.backgroundColor,
      appBarBackgroundColor: widget.appBarBackgroundColor,
      contentPadding: widget.contentPadding,
      safeArea: widget.safeArea,
      scrollable: widget.scrollable,
      scrollController: widget.scrollController,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBarHeight: widget.appBarHeight,
      appBarElevation: widget.appBarElevation,
      centerTitle: widget.centerTitle,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
    );
  }

  /// 根据屏幕宽度确定屏幕类型
  ScreenType _getScreenType(double width) {
    if (width < widget.phoneBreakpoint) {
      return ScreenType.mobile;
    } else if (width < widget.tabletBreakpoint) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'responsive_utils.dart';

/// 响应式布局基础组件
///
/// 基于Scaffold构建，提供自定义AppBar、TabBar等功能，
/// 自动处理返回按钮显示逻辑，作为所有页面的基础模板
class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    super.key,
    required this.body,
    this.title,
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
    this.resizeToAvoidBottomInset,
    this.appBarHeight,
    this.appBarElevation,
    this.centerTitle = false,
    this.drawer,
    this.endDrawer,
    this.integrateTabBar = true,
  });

  /// 页面主体内容
  final Widget body;

  /// AppBar标题
  final Widget? title;

  /// AppBar操作按钮
  final List<Widget>? actions;

  /// AppBar底部TabBar
  final PreferredSizeWidget? tabBar;

  /// TabBar控制器，如果提供了tabBar则必须提供此控制器
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

  /// 滚动控制器，当scrollable为true时使用
  final ScrollController? scrollController;

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

  /// 是否在AppBar中集成TabBar
  ///
  /// 如果为true，则tabBar将作为AppBar的bottom属性，
  /// 否则TabBar将作为body的一部分
  final bool integrateTabBar;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();

    // TabBar需要TabController
    assert(
      (widget.tabBar == null) ||
          (widget.tabBar != null && widget.tabController != null),
      'TabBar必须提供TabController',
    );
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 构建AppBar
    final PreferredSizeWidget? appBar = _buildAppBar(context);

    // 构建主体内容
    Widget content = widget.body;

    // 如果不在AppBar中集成TabBar，则需要将TabBar添加到页面内容中
    if (!widget.integrateTabBar &&
        widget.tabBar != null &&
        widget.tabController != null) {
      content = Column(
        children: <Widget>[
          widget.tabBar!,
          Expanded(child: content),
        ],
      );
    }

    // 处理内容填充
    if (widget.contentPadding != null) {
      content = Padding(
        padding: widget.contentPadding!,
        child: content,
      );
    }

    // 处理可滚动内容
    if (widget.scrollable) {
      content = SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: content,
      );
    }

    // 处理安全区域
    if (widget.safeArea) {
      content = SafeArea(
        child: content,
      );
    }

    // 构建Scaffold
    return Scaffold(
      appBar: appBar,
      body: content,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
    );
  }

  /// 构建AppBar
  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    // 如果没有标题和TabBar，且不显示返回和菜单按钮，则不显示AppBar
    if (widget.title == null &&
        widget.tabBar == null &&
        (widget.forceHideBackButton ?? true) &&
        !widget.showMenuButton &&
        (widget.actions == null || widget.actions!.isEmpty)) {
      return null;
    }

    return AppBar(
      title: widget.title,
      centerTitle: widget.centerTitle,
      backgroundColor: widget.appBarBackgroundColor,
      surfaceTintColor: Colors.transparent,
      leading: _buildLeadingButton(context),
      actions: (widget.actions == null &&
              (ResponsiveUtils.isTablet(context) ||
                  ResponsiveUtils.isMobile(context)))
          ? <Widget>[
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ]
          : widget.actions,
      bottom: widget.integrateTabBar ? widget.tabBar : null,
      toolbarHeight: widget.appBarHeight,
      elevation: widget.appBarElevation,
    );
  }

  /// 构建前导按钮（返回或菜单）
  Widget? _buildLeadingButton(BuildContext context) {
    // 根据页面栈状态判断是否显示返回按钮
    bool shouldShowBackButton = false;

    // 优先使用forceShowBackButton和forceHideBackButton设置
    if (widget.forceShowBackButton ?? false) {
      shouldShowBackButton = true;
    } else if (widget.forceHideBackButton ?? false) {
      shouldShowBackButton = false;
    } else {
      // 自动判断是否有上一级页面
      shouldShowBackButton = Navigator.of(context).canPop() ||
          (GoRouter.of(context)
                  .routerDelegate
                  .currentConfiguration
                  .matches
                  .length >
              1);
    }

    // 抽屉菜单按钮优先级最高
    if (widget.drawer != null) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }

    // 显示返回按钮
    if (shouldShowBackButton) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: widget.onBackPressed ??
            () {
              // 如果没有提供自定义返回行为，则使用默认导航返回
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else if (GoRouter.of(context).canPop()) {
                // 如果不能pop，尝试使用GoRouter返回
                context.pop();
              }
            },
      );
    }

    // 如果需要显示菜单按钮
    if (widget.showMenuButton) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: widget.onMenuPressed,
      );
    }

    return null;
  }
}

/// 响应式布局构建器
///
/// 提供一个便捷的方式来创建响应式布局页面
class ResponsiveLayoutBuilder {
  /// 创建一个基础的响应式页面
  static Widget build({
    required BuildContext context,
    required Widget body,
    Widget? title,
    List<Widget>? actions,
    PreferredSizeWidget? tabBar,
    TabController? tabController,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    Widget? bottomNavigationBar,
    bool? forceShowBackButton,
    bool? forceHideBackButton,
    VoidCallback? onBackPressed,
    bool showMenuButton = false,
    VoidCallback? onMenuPressed,
    Color? backgroundColor,
    Color? appBarBackgroundColor,
    EdgeInsetsGeometry? contentPadding,
    bool safeArea = true,
    bool scrollable = false,
    ScrollController? scrollController,
    bool? resizeToAvoidBottomInset,
    double? appBarHeight,
    double? appBarElevation,
    bool centerTitle = false,
    Widget? drawer,
    Widget? endDrawer,
    bool integrateTabBar = true,
  }) {
    return ResponsiveLayout(
      body: body,
      title: title,
      actions: actions,
      tabBar: tabBar,
      tabController: tabController,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      forceShowBackButton: forceShowBackButton,
      forceHideBackButton: forceHideBackButton,
      onBackPressed: onBackPressed,
      showMenuButton: showMenuButton,
      onMenuPressed: onMenuPressed,
      backgroundColor: backgroundColor,
      appBarBackgroundColor: appBarBackgroundColor,
      contentPadding: contentPadding,
      safeArea: safeArea,
      scrollable: scrollable,
      scrollController: scrollController,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBarHeight: appBarHeight,
      appBarElevation: appBarElevation,
      centerTitle: centerTitle,
      drawer: drawer,
      endDrawer: endDrawer,
      integrateTabBar: integrateTabBar,
    );
  }

  /// 创建一个带有TabBar的页面
  static Widget buildWithTabs({
    required BuildContext context,
    required Widget body,
    required List<Tab> tabs,
    required TabController tabController,
    Widget? title,
    List<Widget>? actions,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    Widget? bottomNavigationBar,
    bool? forceShowBackButton,
    bool? forceHideBackButton,
    VoidCallback? onBackPressed,
    bool showMenuButton = false,
    VoidCallback? onMenuPressed,
    Color? backgroundColor,
    Color? appBarBackgroundColor,
    EdgeInsetsGeometry? contentPadding,
    bool safeArea = true,
    bool scrollable = false,
    ScrollController? scrollController,
    bool? resizeToAvoidBottomInset,
    double? appBarHeight,
    double? appBarElevation,
    bool centerTitle = false,
    Widget? drawer,
    Widget? endDrawer,
    bool isScrollableTabBar = false,
    TabAlignment? tabAlignment,
    Color? tabIndicatorColor,
    Color? tabLabelColor,
    Color? tabUnselectedLabelColor,
    TextStyle? tabLabelStyle,
    TextStyle? tabUnselectedLabelStyle,
    bool integrateTabBar = true,
  }) {
    final TabBar tabBar = TabBar(
      controller: tabController,
      tabs: tabs,
      isScrollable: isScrollableTabBar,
      tabAlignment: isScrollableTabBar ? tabAlignment : null,
      indicatorColor: tabIndicatorColor,
      labelColor: tabLabelColor,
      unselectedLabelColor: tabUnselectedLabelColor,
      labelStyle: tabLabelStyle,
      unselectedLabelStyle: tabUnselectedLabelStyle,
    );

    return ResponsiveLayout(
      body: body,
      title: title,
      actions: actions,
      tabBar: tabBar,
      tabController: tabController,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      forceShowBackButton: forceShowBackButton,
      forceHideBackButton: forceHideBackButton,
      onBackPressed: onBackPressed,
      showMenuButton: showMenuButton,
      onMenuPressed: onMenuPressed,
      backgroundColor: backgroundColor,
      appBarBackgroundColor: appBarBackgroundColor,
      contentPadding: contentPadding,
      safeArea: safeArea,
      scrollable: scrollable,
      scrollController: scrollController,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBarHeight: appBarHeight,
      appBarElevation: appBarElevation,
      centerTitle: centerTitle,
      drawer: drawer,
      endDrawer: endDrawer,
      integrateTabBar: integrateTabBar,
    );
  }
}

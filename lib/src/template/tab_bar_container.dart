import 'package:flutter/material.dart';

/// TabBar容器组件
///
/// 自动处理TabController的生命周期，
/// 提供一个简单的方式来创建带有TabBar的页面
class TabBarContainer extends StatefulWidget {
  const TabBarContainer({
    super.key,
    required this.tabs,
    required this.tabBuilder,
    this.initialIndex = 0,
    this.onTabChanged,
    this.tabAlignment,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelPadding,
    this.indicatorWeight,
    this.indicatorPadding,
    this.indicatorSizeFromLabel = false,
    this.tabBarColor,
    this.tabBarHeight = kToolbarHeight,
    this.physics,
  })  : assert(initialIndex >= 0 && initialIndex < tabs.length,
            'initialIndex 必须在 0 和 tabs.length (${tabs.length}) 之间'),
        assert(
            tabAlignment == null ||
                isScrollable ||
                tabAlignment == TabAlignment.center,
            'TabAlignment只在isScrollable为true时可以使用TabAlignment.start或TabAlignment.end');

  /// Tab标签列表
  final List<Tab> tabs;

  /// Tab内容构建器，根据索引构建对应Tab的内容
  final IndexedWidgetBuilder tabBuilder;

  /// 初始选中的Tab索引
  final int initialIndex;

  /// Tab切换事件回调
  final void Function(int)? onTabChanged;

  /// Tab位置对齐方式，只在isScrollable为true时有效
  final TabAlignment? tabAlignment;

  /// 是否可滚动
  final bool isScrollable;

  /// 指示器颜色
  final Color? indicatorColor;

  /// 选中标签颜色
  final Color? labelColor;

  /// 未选中标签颜色
  final Color? unselectedLabelColor;

  /// 标签样式
  final TextStyle? labelStyle;

  /// 未选中标签样式
  final TextStyle? unselectedLabelStyle;

  /// 标签内边距
  final EdgeInsetsGeometry? labelPadding;

  /// 指示器权重
  final double? indicatorWeight;

  /// 指示器内边距
  final EdgeInsetsGeometry? indicatorPadding;

  /// 是否使用标签宽度作为指示器宽度
  final bool indicatorSizeFromLabel;

  /// TabBar背景色
  final Color? tabBarColor;

  /// TabBar高度
  final double tabBarHeight;

  /// 内容物理效果
  final ScrollPhysics? physics;

  @override
  State<TabBarContainer> createState() => _TabBarContainerState();
}

class _TabBarContainerState extends State<TabBarContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabController();
  }

  @override
  void didUpdateWidget(TabBarContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果Tab数量变化，需要重新创建TabController
    if (widget.tabs.length != oldWidget.tabs.length) {
      _disposeTabController();
      _initTabController();
    } else if (widget.initialIndex != _tabController.index) {
      // 如果初始索引变化，更新TabController
      _tabController.index = widget.initialIndex;
    }
  }

  @override
  void dispose() {
    _disposeTabController();
    super.dispose();
  }

  void _initTabController() {
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );

    if (widget.onTabChanged != null) {
      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          widget.onTabChanged?.call(_tabController.index);
        }
      });
    }
  }

  void _disposeTabController() {
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: widget.physics,
            children: List<Widget>.generate(
              widget.tabs.length,
              (int index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建TabBar
  Widget _buildTabBar() {
    return Container(
      color: widget.tabBarColor,
      height: widget.tabBarHeight,
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs,
        isScrollable: widget.isScrollable,
        indicatorColor: widget.indicatorColor,
        labelColor: widget.labelColor,
        unselectedLabelColor: widget.unselectedLabelColor,
        labelStyle: widget.labelStyle,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        labelPadding: widget.labelPadding,
        indicatorWeight: widget.indicatorWeight ?? 2.0,
        indicatorPadding: widget.indicatorPadding ?? EdgeInsets.zero,
        indicatorSize: widget.indicatorSizeFromLabel
            ? TabBarIndicatorSize.label
            : TabBarIndicatorSize.tab,
        tabAlignment: widget.isScrollable ? widget.tabAlignment : null,
      ),
    );
  }
}

/// TabBar预设样式
class TabBarStyle {
  /// 创建一个填充整个宽度的TabBar
  static TabBar fullWidth({
    required TabController controller,
    required List<Tab> tabs,
    Color? indicatorColor,
    Color? labelColor,
    Color? unselectedLabelColor,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
  }) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor: indicatorColor,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      // 不在isScrollable为false时设置tabAlignment
    );
  }

  /// 创建一个可滚动的TabBar
  static TabBar scrollable({
    required TabController controller,
    required List<Tab> tabs,
    Color? indicatorColor,
    Color? labelColor,
    Color? unselectedLabelColor,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    TabAlignment alignment = TabAlignment.start,
  }) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: true,
      indicatorColor: indicatorColor,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      tabAlignment: alignment,
    );
  }
}

/// 简单的Tab内容视图
///
/// 结合TabBar和TabBarView，自动管理TabController
class SimpleTabView extends StatelessWidget {
  const SimpleTabView({
    super.key,
    required this.tabBarContainer,
  });

  /// Tab页面构建器
  final TabBarContainer tabBarContainer;

  @override
  Widget build(BuildContext context) {
    return tabBarContainer;
  }

  /// 从标签和构建器创建SimpleTabView
  static Widget fromTabs({
    required List<Tab> tabs,
    required IndexedWidgetBuilder tabBuilder,
    int initialIndex = 0,
    void Function(int)? onTabChanged,
    TabAlignment? tabAlignment,
    bool isScrollable = false,
    Color? indicatorColor,
    Color? labelColor,
    Color? unselectedLabelColor,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    EdgeInsetsGeometry? labelPadding,
    double? indicatorWeight,
    EdgeInsetsGeometry? indicatorPadding,
    bool indicatorSizeFromLabel = false,
    Color? tabBarColor,
    double tabBarHeight = kToolbarHeight,
    ScrollPhysics? physics,
  }) {
    return TabBarContainer(
      tabs: tabs,
      tabBuilder: tabBuilder,
      initialIndex: initialIndex,
      onTabChanged: onTabChanged,
      tabAlignment: tabAlignment,
      isScrollable: isScrollable,
      indicatorColor: indicatorColor,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      labelPadding: labelPadding,
      indicatorWeight: indicatorWeight,
      indicatorPadding: indicatorPadding,
      indicatorSizeFromLabel: indicatorSizeFromLabel,
      tabBarColor: tabBarColor,
      tabBarHeight: tabBarHeight,
      physics: physics,
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';

/// 通用分页控件
class PaginationWidget extends StatefulWidget {
  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalItems,
    required this.pageSize,
    required this.onPageChanged,
    this.showTotalCount = true,
    this.showJumpInput = true,
    this.style,
  });

  /// 当前页码
  final int currentPage;

  /// 总条数
  final int totalItems;

  /// 每页条数
  final int pageSize;

  /// 页码改变回调
  final ValueChanged<int> onPageChanged;

  /// 是否显示总条数
  final bool showTotalCount;

  /// 是否显示跳转输入框
  final bool showJumpInput;

  /// 自定义样式
  final PaginationStyle? style;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  late TextEditingController _pageController;
  late FocusNode _focusNode;
  late int _maxPage;

  @override
  void initState() {
    super.initState();
    _pageController = TextEditingController(
      text: widget.currentPage.toString(),
    );
    _focusNode = FocusNode();
    _updateMaxPage();
  }

  @override
  void didUpdateWidget(PaginationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalItems != widget.totalItems ||
        oldWidget.pageSize != widget.pageSize) {
      _updateMaxPage();
    }
    // 只有当当前页码发生变化且输入框没有焦点时才更新控制器文本
    if (oldWidget.currentPage != widget.currentPage && !_focusNode.hasFocus) {
      _pageController.text = widget.currentPage.toString();
    }
  }

  void _updateMaxPage() {
    _maxPage = (widget.totalItems / widget.pageSize).ceil();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _jumpToPage(String value) {
    final int? page = int.tryParse(value);

    if (page != null && page >= 1 && page <= _maxPage) {
      widget.onPageChanged(page);
      // 跳转成功后清除焦点
      _focusNode.unfocus();
    } else {
      // 显示错误提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('页码必须在 1 到 $_maxPage 之间'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      // 重置输入框为当前页码
      _pageController.text = widget.currentPage.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PaginationStyle style = widget.style ?? PaginationStyle();

    // 如果只有一页，不显示分页控件
    if (_maxPage <= 1) {
      return const SizedBox.shrink();
    }

    return Container(
      padding:
          style.containerPadding ??
          EdgeInsets.fromLTRB(
            2,
            2,
            2,
            CommonResponsiveUtils.isDesktop(context) ? 2 : 16,
          ),
      decoration: style.containerDecoration,
      child: Row(
        mainAxisAlignment: style.mainAxisAlignment,
        children: <Widget>[
          if (widget.showTotalCount) ...<Widget>[
            // 总条数显示
            Text(
              '共${widget.totalItems}条',
              style:
                  style.totalCountTextStyle ??
                  theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
            // SizedBox(width: style.spacing),
          ],

          // 向前按钮
          IconButton(
            icon: style.previousIcon,
            onPressed: widget.currentPage > 1
                ? () => widget.onPageChanged(widget.currentPage - 1)
                : null,
            tooltip: style.previousTooltip,
            style: style.previousButtonStyle,
          ),
          // SizedBox(width: style.spacing),

          // 当前页/总页数
          Text(
            '${widget.currentPage} / $_maxPage',
            style:
                style.pageInfoTextStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          // SizedBox(width: style.spacing),

          // 向后按钮
          IconButton(
            icon: style.nextIcon,
            onPressed: widget.currentPage < _maxPage
                ? () => widget.onPageChanged(widget.currentPage + 1)
                : null,
            tooltip: style.nextTooltip,
            style: style.nextButtonStyle,
          ),

          if (widget.showJumpInput) ...<Widget>[
            SizedBox(width: style.jumpInputSpacing),

            // 输入框（输入跳转页码）
            SizedBox(
              width: style.inputWidth,
              child: TextField(
                controller: _pageController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: style.inputTextStyle ?? theme.textTheme.bodySmall,
                decoration: InputDecoration(
                  border: style.inputBorder ?? const OutlineInputBorder(),
                  contentPadding:
                      style.inputContentPadding ??
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  isDense: true,
                  hintText: style.inputHintText,
                  helperText: style.showInputHelper ? '1-$_maxPage' : null,
                  helperMaxLines: 1,
                ),
                onSubmitted: _jumpToPage,
              ),
            ),
            SizedBox(width: style.spacing),

            // 跳转按钮
            ElevatedButton(
              onPressed: () => _jumpToPage(_pageController.text),
              style:
                  style.jumpButtonStyle ??
                  ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: const Size(60, 32),
                  ),
              child: Text(style.jumpButtonText),
            ),
          ],
        ],
      ),
    );
  }
}

/// 分页控件样式配置
class PaginationStyle {
  PaginationStyle({
    this.containerPadding,
    this.containerDecoration,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spacing = 16.0,
    this.jumpInputSpacing = 24.0,
    this.inputWidth = 50.0,
    this.totalCountTextStyle,
    this.pageInfoTextStyle,
    this.inputTextStyle,
    this.inputBorder,
    this.inputContentPadding,
    this.inputHintText = '页码',
    this.showInputHelper = false,
    this.previousIcon = const Icon(Icons.chevron_left),
    this.nextIcon = const Icon(Icons.chevron_right),
    this.previousTooltip = '上一页',
    this.nextTooltip = '下一页',
    this.previousButtonStyle,
    this.nextButtonStyle,
    this.jumpButtonStyle,
    this.jumpButtonText = '跳转',
  });

  /// 容器内边距
  final EdgeInsetsGeometry? containerPadding;

  /// 容器装饰
  final BoxDecoration? containerDecoration;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 元素间距
  final double spacing;

  /// 跳转输入框间距
  final double jumpInputSpacing;

  /// 输入框宽度
  final double inputWidth;

  /// 总条数文字样式
  final TextStyle? totalCountTextStyle;

  /// 页码信息文字样式
  final TextStyle? pageInfoTextStyle;

  /// 输入框文字样式
  final TextStyle? inputTextStyle;

  /// 输入框边框
  final InputBorder? inputBorder;

  /// 输入框内容内边距
  final EdgeInsetsGeometry? inputContentPadding;

  /// 输入框提示文字
  final String inputHintText;

  /// 是否显示输入框帮助文字
  final bool showInputHelper;

  /// 上一页图标
  final Widget previousIcon;

  /// 下一页图标
  final Widget nextIcon;

  /// 上一页提示文字
  final String previousTooltip;

  /// 下一页提示文字
  final String nextTooltip;

  /// 上一页按钮样式
  final ButtonStyle? previousButtonStyle;

  /// 下一页按钮样式
  final ButtonStyle? nextButtonStyle;

  /// 跳转按钮样式
  final ButtonStyle? jumpButtonStyle;

  /// 跳转按钮文字
  final String jumpButtonText;
}

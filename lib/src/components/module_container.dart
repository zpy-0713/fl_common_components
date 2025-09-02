import 'package:flutter/material.dart';

/// 通用模块容器组件
///
/// 用于创建具有统一样式的模块容器，包含标题栏和内容区域
///
/// 参数说明：
/// - [context]: BuildContext
/// - [child]: 模块内容
/// - [title]: 模块标题
/// - [subtitle]: 模块副标题
/// - [icon]: 模块图标
/// - [iconColor]: 图标颜色
/// - [headerColor]: 标题栏背景色
/// - [minHeight]: 最小高度，默认为屏幕高度的30%
/// - [isLoading]: 是否显示加载状态指示器
class ModuleContainer extends StatelessWidget {
  const ModuleContainer({
    super.key,
    required this.context,
    required this.child,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.headerColor,
    this.minHeight,
    this.isLoading = false,
  });

  final BuildContext context;
  final Widget child;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color headerColor;
  final double? minHeight;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight ?? MediaQuery.of(context).size.height * 0.3,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 模块标题栏
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: iconColor,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
          // 模块内容
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                minHeight:
                    minHeight ?? MediaQuery.of(context).size.height * 0.3,
              ),
              child: Padding(padding: const EdgeInsets.all(16), child: child),
            ),
          ),
        ],
      ),
    );
  }
}

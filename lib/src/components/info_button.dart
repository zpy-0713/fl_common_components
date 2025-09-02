import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';

/// 通用信息图标按钮组件
class InfoIconButton extends StatelessWidget {
  const InfoIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity(
        vertical: -4,
        horizontal: CommonResponsiveUtils.isMobile(context) ? -4 : 0,
      ), // 减少水平密度
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minHeight: 25, // 减少最小高度
        minWidth: 25, // 减少最小宽度
      ),
      onPressed:
          onPressed ??
          () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(title: Text(label), content: Text(value));
              },
            );
          },
      icon: Icon(icon, size: 20, color: color),
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

/// 通用信息文本按钮组件
class InfoTextButton extends StatelessWidget {
  const InfoTextButton({
    super.key,
    required this.buttonText,
    required this.label,
    required this.value,
    required this.color,
    this.onPressed,
    this.style,
  });

  final String buttonText;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          onPressed ??
          () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(title: Text(label), content: Text(value));
              },
            );
          },
      style:
          style ??
          TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 2,
            ), // 减少内边距
            minimumSize: const Size(32, 24), // 减少最小尺寸
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 启用紧凑的触摸目标
          ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: color,
          fontSize: 11, // 稍微减小字体大小
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

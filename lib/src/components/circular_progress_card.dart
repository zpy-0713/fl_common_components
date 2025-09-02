import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircularProgressCard extends ConsumerWidget {
  const CircularProgressCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.numerator,
    required this.denominator,
    this.color,
    this.size = 120,
  });

  final String title;
  final double percentage;
  final int numerator;
  final int denominator;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;

    return Column(
      children: <Widget>[
        // 环状进度条
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // 背景圆环
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 8,
                  backgroundColor: cardColor.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    cardColor.withValues(alpha: 0.08),
                  ),
                ),
              ),
              // 进度圆环
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(cardColor),
                ),
              ),
              // 中心文字
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: size * 0.22,
                      fontWeight: FontWeight.w700,
                      color: cardColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$numerator/$denominator',
                      style: TextStyle(
                        fontSize: size * 0.11,
                        color: cardColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // 标题
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyMedium?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// 移动端环状进度条卡片组件
class MobileCircularProgressCard extends ConsumerWidget {
  const MobileCircularProgressCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.numerator,
    required this.denominator,
    this.color,
    this.size = 80,
  });

  final String title;
  final double percentage;
  final int numerator;
  final int denominator;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;

    return Column(
      children: <Widget>[
        // 环状进度条
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // 背景圆环
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 8,
                  backgroundColor: cardColor.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    cardColor.withValues(alpha: 0.08),
                  ),
                ),
              ),
              // 进度圆环
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(cardColor),
                ),
              ),
              // 中心文字
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: size * 0.2,
                      fontWeight: FontWeight.w700,
                      color: cardColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$numerator/$denominator',
                      style: TextStyle(
                        fontSize: size * 0.09,
                        color: cardColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 标题
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyMedium?.color,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

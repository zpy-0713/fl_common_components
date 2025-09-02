import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryCard extends ConsumerWidget {
  const SummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.fontScale = 1.0,
    required this.isWide,
    this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final double fontScale;
  final bool isWide;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // final bool isWide = constraints.maxWidth > 300;

        return Container(
          height: isWide ? 130 : 90,
          width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardColor.withValues(alpha: 0.2)),
          ),
          child: isWide
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: cardColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(icon, color: cardColor),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      color: cardColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: cardColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(icon, color: cardColor),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

/// 移动端小方块统计卡片组件
class MobileSummaryCard extends ConsumerWidget {
  const MobileSummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // final bool isWide = constraints.maxWidth > 300;
        return Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cardColor.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 14, color: cardColor),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: cardColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

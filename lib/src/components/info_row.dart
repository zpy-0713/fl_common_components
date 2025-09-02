import 'package:flutter/material.dart';

/// 通用信息行，标题靠左，内容靠右
Widget buildInfoRow(
  BuildContext context,
  String title,
  String value, {
  TextStyle? titleStyle,
  TextStyle? valueStyle,
}) {
  return Row(
    children: <Widget>[
      SelectableText(
        title,
        style:
            titleStyle ??
            Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: Colors.grey),
      ),
      const Spacer(),
      SelectableText(
        value.isEmpty ? '----' : value,
        style: valueStyle ?? Theme.of(context).textTheme.bodySmall,
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppAboutDialog extends ConsumerStatefulWidget {
  const AppAboutDialog({super.key});

  @override
  ConsumerState<AppAboutDialog> createState() => _AppAboutDialogState();
}

class _AppAboutDialogState extends ConsumerState<AppAboutDialog> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('关于应用', style: TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // 应用图标
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/img/logo_login.png',
                  width: 240,
                ),
              ),
              const SizedBox(height: 40),

              // 应用名称
              _buildInfoRow('应用名称:', '千鸟云智慧管理平台'),
              _buildDivider(),

              // 版本号
              _buildInfoRow('版本号:', _packageInfo?.version ?? '加载中...'),
              _buildDivider(),

              // 构建号
              _buildInfoRow('构建号:', _packageInfo?.buildNumber ?? '加载中...'),
              _buildDivider(),

              // 包名
              _buildInfoRow('包名:', _packageInfo?.packageName ?? '加载中...'),
              _buildDivider(),

              // 开发团队
              _buildInfoRow('开发团队:', '千鸟云技术团队'),
              _buildDivider(),

              // 版权信息
              _buildInfoRow('版权:', '© 2024 千鸟云. 保留所有权利'),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('关闭'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(thickness: 1);
  }
}

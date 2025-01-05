import 'package:flutter/material.dart';

/// 设置项分组
class SettingsGroup extends StatelessWidget {
  /// 创建设置项分组
  const SettingsGroup({
    super.key,
    required this.children,
  });

  /// 子组件列表
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(50),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: children,
      ),
    );
  }
}

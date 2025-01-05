import 'package:flutter/material.dart';

/// 统计卡片组件
class StatisticCard extends StatelessWidget {
  /// 创建统计卡片组件
  const StatisticCard({
    super.key,
    required this.value,
    required this.label,
    this.onTap,
  });

  /// 数值
  final String value;

  /// 标签
  final String label;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outlineVariant.withAlpha(50),
            ),
          ),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 卦象信息卡片组件
class HexagramInfoCard extends StatelessWidget {
  /// 创建卦象信息卡片组件
  const HexagramInfoCard({
    super.key,
    required this.text,
    required this.bgType,
    required this.yearRange,
    required this.guide,
    this.onTap,
  });

  /// 卦象文字
  final String text;

  /// 背景类型
  final HexagramBgType bgType;

  /// 年份范围
  final String yearRange;

  /// 卦象指引
  final String guide;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withAlpha(25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧卦象和年份
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlowingHexagram(
                    text: text,
                    size: 80,
                    enableAnimation: false,
                    bgType: bgType,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    yearRange,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // 右侧解说文本
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '卦象解读',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      guide,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

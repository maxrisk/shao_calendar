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
    this.onTap,
  });

  /// 卦象文字
  final String text;

  /// 背景类型
  final HexagramBgType bgType;

  /// 年份范围
  final String yearRange;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
                      '此卦象代表的年代（$yearRange）有其特定的时运与能量场。在这段时期出生或经历重要人生阶段的人，往往会受到此卦象能量的影响。\n\n'
                      '【$text】卦蕴含着宇宙运行的规律与智慧，影响着这一时期的集体潜意识和时代特征。了解这一卦象，有助于理解个人命运与大时代背景的关联。',
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

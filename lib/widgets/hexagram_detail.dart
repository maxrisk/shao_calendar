import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 卦象详细信息展示组件
class HexagramDetail extends StatelessWidget {
  /// 创建卦象详细信息组件
  const HexagramDetail({
    super.key,
    required this.timeRange,
    required this.hexagramName,
    required this.mainText,
    required this.secondaryText,
    required this.interpretation,
    required this.score,
  });

  /// 时间范围
  final String timeRange;

  /// 卦象名称
  final String hexagramName;

  /// 主卦辞
  final String mainText;

  /// 次卦辞
  final String secondaryText;

  /// 解读文本
  final String interpretation;

  /// 运势评分
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 时间段和卦象标题栏
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeRange,
                  style: const TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '变卦：$hexagramName',
                  style: const TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // 易经原文部分
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '《易经》原文',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '卦辞：$mainText',
                            style: const TextStyle(
                                color: AppTheme.primaryTextColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '彖辞：$secondaryText',
                            style: const TextStyle(
                                color: AppTheme.primaryTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 解读部分
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '解读',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  interpretation,
                  style: const TextStyle(
                    color: AppTheme.secondaryTextColor,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          // 总评分数
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '总评分数',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      score.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

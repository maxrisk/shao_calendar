import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 卦象展示组件
class HexagramDisplay extends StatelessWidget {
  /// 创建卦象展示组件
  const HexagramDisplay({
    super.key,
    required this.date,
  });

  /// 日期
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 左侧卦象展示
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppTheme.borderColor),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '今日卦象',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 这里添加卦象图形
                    const Center(
                      child: Text(
                        '䷀',
                        style: TextStyle(
                          fontSize: 72,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 右侧解释文本
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('卦辞', '乾：元，亨，利，贞。'),
                    const SizedBox(height: 16),
                    _buildSection('象传', '天行健，君子以自强不息。'),
                    const SizedBox(height: 16),
                    _buildSection('彖传', '大哉乾元，万物资始，乃统天。'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

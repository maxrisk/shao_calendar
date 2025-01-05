import 'package:flutter/material.dart';

/// 提成类型
enum CommissionType {
  /// 直接推荐奖励
  direct(label: '直接推荐奖励'),

  /// 间接推荐奖励
  indirect(label: '间接推荐奖励');

  const CommissionType({required this.label});

  /// 标签文本
  final String label;
}

/// 提成记录单元格
class CommissionRecordCell extends StatelessWidget {
  /// 创建提成记录单元格
  const CommissionRecordCell({
    super.key,
    required this.type,
    required this.orderNo,
    required this.dateTime,
    required this.amount,
  });

  /// 提成类型
  final CommissionType type;

  /// 单号
  final String orderNo;

  /// 时间
  final String dateTime;

  /// 金额
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withAlpha(50),
          ),
        ),
      ),
      child: Row(
        children: [
          // 左侧
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.label,
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onSurface,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  orderNo,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          // 右侧
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateTime,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount >= 0
                    ? '+${amount.toStringAsFixed(2)}'
                    : amount.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: amount >= 0 ? colorScheme.primary : colorScheme.error,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/statistic_card.dart';
import 'widgets/commission_record_cell.dart';

/// 提成明细页面
class CommissionDetailPage extends StatelessWidget {
  /// 创建提成明细页面
  const CommissionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('提成明细'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 顶部统计卡片
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: StatisticCard(
                    value: '123.00',
                    label: '总提成（元）',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatisticCard(
                    value: '123.00',
                    label: '余额（元）',
                  ),
                ),
              ],
            ),
          ),
          // 提成记录列表
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return CommissionRecordCell(
                  type: index % 2 == 0
                      ? CommissionType.direct
                      : CommissionType.indirect,
                  orderNo: 'NO.${index.toString().padLeft(8, '0')}',
                  dateTime: '2024-03-${index.toString().padLeft(2, '0')} 12:00',
                  amount: index % 3 == 0 ? -10.0 : 50.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

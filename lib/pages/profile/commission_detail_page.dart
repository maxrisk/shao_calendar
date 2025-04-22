import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/statistic_card.dart';
import 'widgets/commission_record_cell.dart';
import '../../models/commission_order.dart';
import '../../services/user_service.dart';
import 'commission_order_page.dart';
import 'withdraw_page.dart';

/// 提成明细页面
class CommissionDetailPage extends StatelessWidget {
  /// 创建提成明细页面
  const CommissionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userService = context.watch<UserService>();
    final user = userService.userInfo?.userInfo;
    final commission = user?.commission ?? 0.0;
    final balance = user?.amount ?? 0.0;

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
                    value: commission.toStringAsFixed(2),
                    label: '总提成（元）',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatisticCard(
                    value: balance.toStringAsFixed(2),
                    label: '余额（元）',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WithdrawPage(
                            balance: balance,
                          ),
                        ),
                      );
                    },
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
                  type: index % 3 == 0
                      ? CommissionOrderType.withdraw
                      : index % 2 == 0
                          ? CommissionOrderType.direct
                          : CommissionOrderType.indirect,
                  orderNo: 'NO.${index.toString().padLeft(8, '0')}',
                  dateTime: '2024-03-${index.toString().padLeft(2, '0')} 12:00',
                  amount: index % 3 == 0 ? -10.0 : 50.0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommissionOrderPage(
                          order: CommissionOrder(
                            type: index % 3 == 0
                                ? CommissionOrderType.withdraw
                                : index % 2 == 0
                                    ? CommissionOrderType.direct
                                    : CommissionOrderType.indirect,
                            amount: index % 3 == 0 ? -10.0 : 50.0,
                            orderNo: 'NO.${index.toString().padLeft(8, '0')}',
                            dateTime:
                                '2024-03-${index.toString().padLeft(2, '0')} 12:00',
                            description:
                                index % 3 == 0 ? '提现到银行卡' : '推荐用户购买会员服务',
                            cardNo:
                                index % 3 == 0 ? '6222************1234' : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

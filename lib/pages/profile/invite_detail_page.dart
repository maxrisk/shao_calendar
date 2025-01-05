import 'package:flutter/material.dart';
import 'widgets/statistic_card.dart';
import 'widgets/invite_record_cell.dart';
import 'member_detail_page.dart';

/// 邀请明细页面
class InviteDetailPage extends StatelessWidget {
  /// 创建邀请明细页面
  const InviteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('邀请明细'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: StatisticCard(
                    value: '0',
                    label: '直接邀请',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatisticCard(
                    value: '0',
                    label: '间接邀请',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 示例数据
              itemBuilder: (context, index) {
                return InviteRecordCell(
                  phoneNumber: '138****${index.toString().padLeft(4, '0')}',
                  inviteType:
                      index % 2 == 0 ? InviteType.direct : InviteType.indirect,
                  paymentStatus: index % 3 == 0
                      ? PaymentStatus.paid
                      : PaymentStatus.unpaid,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MemberDetailPage(),
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

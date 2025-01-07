import 'package:flutter/material.dart';
import 'invite_record_cell.dart';

/// 会员信息卡片
class MemberInfoCard extends StatelessWidget {
  /// 创建会员信息卡片
  const MemberInfoCard({
    super.key,
    required this.memberId,
    required this.paymentStatus,
    required this.phoneNumber,
    required this.name,
    required this.directInvites,
    required this.indirectInvites,
  });

  /// 会员号
  final String memberId;

  /// 付费状态
  final PaymentStatus paymentStatus;

  /// 手机号
  final String phoneNumber;

  /// 姓名
  final String name;

  /// 直接推荐数量
  final int directInvites;

  /// 间接推荐数量
  final int indirectInvites;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '会员详情',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoItem(context, '会员号', memberId),
                _buildDivider(colorScheme),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        '状态',
                        style: TextStyle(
                          fontSize: 15,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: paymentStatus == PaymentStatus.paid
                                ? colorScheme.primary.withAlpha(20)
                                : colorScheme.surfaceContainerHighest
                                    .withAlpha(77),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            paymentStatus.label,
                            style: TextStyle(
                              fontSize: 13,
                              color: paymentStatus == PaymentStatus.paid
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildDivider(colorScheme),
                _buildInfoItem(context, '手机号', phoneNumber),
                _buildDivider(colorScheme),
                _buildInfoItem(context, '姓名', name),
                _buildDivider(colorScheme),
                _buildInfoItem(
                  context,
                  '直接推荐',
                  '$directInvites人',
                  valueColor: colorScheme.primary,
                ),
                _buildDivider(colorScheme),
                _buildInfoItem(
                  context,
                  '间接推荐',
                  '$indirectInvites人',
                  valueColor: colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建分隔线
  Widget _buildDivider(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        color: colorScheme.outlineVariant.withAlpha(50),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: valueColor ?? colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// 邀请类型
enum InviteType {
  /// 直接邀请
  direct(label: '直接'),

  /// 间接邀请
  indirect(label: '间接');

  const InviteType({required this.label});

  /// 标签文本
  final String label;
}

/// 付费状态
enum PaymentStatus {
  /// 已付费
  paid(label: '已付费'),

  /// 未付费
  unpaid(label: '未付费');

  const PaymentStatus({required this.label});

  /// 标签文本
  final String label;
}

/// 邀请记录单元格
class InviteRecordCell extends StatelessWidget {
  /// 创建邀请记录单元格
  const InviteRecordCell({
    super.key,
    required this.phoneNumber,
    required this.inviteType,
    required this.paymentStatus,
    this.onTap,
  });

  /// 手机号
  final String phoneNumber;

  /// 邀请类型
  final InviteType inviteType;

  /// 付费状态
  final PaymentStatus paymentStatus;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
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
              // 手机号
              Text(
                phoneNumber,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                  height: 1.2,
                ),
              ),
              const Spacer(),
              // 邀请类型标签
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  inviteType.label,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.primary,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 付费状态
              Text(
                paymentStatus.label,
                style: TextStyle(
                  fontSize: 13,
                  color: paymentStatus == PaymentStatus.paid
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

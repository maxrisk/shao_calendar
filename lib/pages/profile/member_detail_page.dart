import 'package:flutter/material.dart';
import 'widgets/member_info_card.dart';
import 'widgets/invite_record_cell.dart';

/// 会员详情页面
class MemberDetailPage extends StatelessWidget {
  /// 创建会员详情页面
  const MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: MemberInfoCard(
          memberId: 'M123456789',
          paymentStatus: PaymentStatus.paid,
          phoneNumber: '138****0000',
          name: '张三',
          directInvites: 10,
          indirectInvites: 20,
        ),
      ),
    );
  }
}

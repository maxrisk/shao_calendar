import 'package:flutter/material.dart';
import '../../services/invite_service.dart';
import '../../models/referral_user_detail.dart';
import 'widgets/member_info_card.dart';

/// 会员详情页面
class MemberDetailPage extends StatefulWidget {
  /// 创建会员详情页面
  const MemberDetailPage({
    super.key,
    required this.userId,
  });

  /// 用户ID
  final int userId;

  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  final _inviteService = InviteService();
  late Future<ReferralUserDetail?> _userDetailFuture;

  @override
  void initState() {
    super.initState();
    _userDetailFuture = _inviteService.getReferralUserDetail(widget.userId);
  }

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
      body: FutureBuilder<ReferralUserDetail?>(
        future: _userDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '加载失败',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          final userDetail = snapshot.data;
          if (userDetail == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_off_rounded,
                    size: 48,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '用户不存在',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: MemberInfoCard(
              memberId: '${userDetail.id}',
              paymentStatusLabel: userDetail.isVip ? '已付费' : '未付费',
              isPaid: userDetail.isVip,
              phoneNumber: userDetail.phone,
              name: userDetail.nickName ?? '推荐用户',
              directInvites: userDetail.firstCount,
              indirectInvites: userDetail.secondCount,
            ),
          );
        },
      ),
    );
  }
}

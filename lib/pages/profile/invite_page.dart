import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import 'widgets/statistic_card.dart';
import 'invite_detail_page.dart';
import 'commission_detail_page.dart';
import '../../pages/profile/calendar_service_page.dart';
import '../../config/app_config.dart';
import '../../utils/invite_code_util.dart';

/// 推荐邀请页面
class InvitePage extends StatelessWidget {
  /// 创建推荐邀请页面
  const InvitePage({super.key});

  Widget _buildQRCode(BuildContext context, String data,
      {bool isBlurred = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surfaceContainerHighest.withAlpha(50)
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(50),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 160,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: colorScheme.primary,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: colorScheme.primary.withAlpha(204),
            ),
            padding: const EdgeInsets.all(16),
          ),
          if (isBlurred)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: colorScheme.surface.withAlpha(120),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        color: colorScheme.primary,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('已复制到剪贴板'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userService = context.watch<UserService>();
    final userInfo = userService.userInfo?.userInfo;
    final referralCode = userInfo?.referralCode?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('推荐邀请'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 顶部统计卡片
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: StatisticCard(
                      value: userInfo?.commission?.toStringAsFixed(2) ?? '0.00',
                      label: '已获提成（元）',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CommissionDetailPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatisticCard(
                      value: userInfo?.referralCount?.toString() ?? '0',
                      label: '总邀请（人）',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InviteDetailPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 推荐码卡片
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withAlpha(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 20),
                      child: Text(
                        '我的推荐码',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    _buildQRCode(
                      context,
                      // 使用工具类生成邀请链接
                      referralCode.isNotEmpty
                          ? InviteCodeUtil.generateInviteLink(referralCode)
                          : AppConfig.apiBaseUrl,
                      isBlurred: userInfo?.promotion == 0,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ID: ${referralCode.isNotEmpty ? referralCode : "-"}',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () =>
                              _copyToClipboard(context, referralCode),
                          icon: Icon(
                            Icons.copy_rounded,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            minimumSize: const Size(36, 36),
                            backgroundColor: colorScheme.primary.withAlpha(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: colorScheme.outlineVariant.withAlpha(50),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatItem(
                              context,
                              '分享给好友',
                              '第一步',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 24,
                            color: colorScheme.outlineVariant.withAlpha(50),
                          ),
                          Expanded(
                            child: _buildStatItem(
                              context,
                              '输入邀请码/扫码',
                              '第二步',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 24,
                            color: colorScheme.outlineVariant.withAlpha(50),
                          ),
                          Expanded(
                            child: _buildStatItem(
                              context,
                              '用户付费提现到账',
                              '第三步',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 添加两个按钮
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  // Ghost按钮
                  Container(
                    width: double.infinity,
                    height: 56,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.primary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CalendarServicePage(type: 1),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '直接推荐奖励权限',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                userInfo?.promotion == 1 ||
                                        userInfo?.promotion == 2
                                    ? '已开通'
                                    : '¥365',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (userInfo?.promotion != 1 &&
                                  userInfo?.promotion != 2) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: colorScheme.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 实心按钮
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CalendarServicePage(type: 2),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '直接与间接推荐奖励权限',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                userInfo?.promotion == 2 ? '已开通' : '¥3650',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (userInfo?.promotion != 2) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: colorScheme.onPrimary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

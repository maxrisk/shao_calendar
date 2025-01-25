import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../../services/fortune_service.dart';
import 'edit_nickname_page.dart';
import '../../widgets/dialogs/index.dart';
import 'change_phone_page.dart';
import 'bank_card_page.dart';
import '../../widgets/list/list_cell.dart';
import '../../widgets/list/list_group.dart';
import 'security_page.dart';
import 'calendar_service_page.dart';

/// 账户中心页面
class AccountPage extends StatefulWidget {
  /// 创建账户中心页面
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userService = context.watch<UserService>();
    final userInfo = userService.userInfo?.userInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('账户中心'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListGroup(
                    title: '基本信息',
                    children: [
                      ListCell(
                        title: 'ID',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userInfo?.referralCode?.toString() ?? '-',
                              style: TextStyle(
                                fontSize: 15,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _copyToClipboard(
                                  context, userInfo?.id?.toString() ?? ''),
                              icon: Icon(
                                Icons.copy_rounded,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(36, 36),
                                backgroundColor:
                                    colorScheme.primary.withAlpha(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        showArrow: false,
                      ),
                      ListCell(
                        title: '昵称',
                        trailing: Text(
                          userInfo?.nickName ?? '未设置',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        onTap: () => _handleEditNickname(userInfo?.nickName),
                      ),
                      ListCell(
                        title: '天历服务',
                        trailing: Text(
                          userInfo?.isVip == true
                              ? '剩余 ${userService.remainingDays} 天'
                              : '未开通',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.primary,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CalendarServicePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  ListGroup(
                    title: '绑定信息',
                    children: [
                      ListCell(
                        icon: Icons.phone_outlined,
                        title: '手机号',
                        trailing: Text(
                          _formatPhone(userInfo?.phone),
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePhonePage(
                                phone: userInfo?.phone ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                      ListCell(
                        icon: Icons.wechat_outlined,
                        title: '微信号',
                        trailing: Text(
                          userInfo?.openId != null ? '已绑定' : '未绑定',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        onTap: () {
                          // TODO: 处理微信绑定
                        },
                      ),
                      ListCell(
                        icon: Icons.account_balance_wallet_outlined,
                        title: '我的银行卡',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BankCardPage(),
                            ),
                          );
                        },
                      ),
                      ListCell(
                        icon: Icons.qr_code_rounded,
                        title: '推荐人ID',
                        trailing: Text(
                          userInfo?.firstCode ?? '-',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        showArrow: false,
                      ),
                      ListCell(
                        icon: Icons.security_outlined,
                        title: '账户安全',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SecurityPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 退出按钮
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              16 + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  final confirmed = await ConfirmDialog.show(
                    context: context,
                    title: '退出登录',
                    content: '确定要退出登录吗？',
                    isDanger: true,
                  );

                  if (confirmed == true && mounted) {
                    // 退出登录
                    final userService = context.read<UserService>();
                    await userService.logout();
                    // 清理运势数据
                    final fortuneService =
                        Provider.of<FortuneService>(context, listen: false);
                    fortuneService.clearFortuneData();
                    // 返回到首页
                    if (context.mounted) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '退出登录',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleEditNickname(String? initialNickname) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditNicknamePage(
          initialValue: initialNickname,
        ),
      ),
    );

    if (result != null && result.isNotEmpty && mounted) {
      final userService = context.read<UserService>();
      await userService.updateNickname(result);
    }
  }

  String _formatPhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return '未绑定';
    }
    if (phone.length != 11) {
      return phone;
    }
    return '${phone.substring(0, 3)}****${phone.substring(7)}';
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
}

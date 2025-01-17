import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile/login_page.dart';
import 'widgets/login_prompt.dart';
import 'widgets/user_info_card.dart';
import 'widgets/interpretation_card.dart';
import '../../widgets/list/list_cell.dart';
import '../../widgets/list/list_group.dart';
import '../../services/user_service.dart';
import 'invite_page.dart';
import 'account_page.dart';
import 'about_page.dart';

/// 个人中心页面
class ProfilePage extends StatefulWidget {
  /// 创建个人中心页面
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _handleLogin() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            )),
            child: FadeTransition(
              opacity: animation,
              child: const LoginPage(),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        fullscreenDialog: true,
        opaque: false,
        barrierColor: Colors.black.withAlpha(100),
      ),
    );
  }

  void _handleInvite() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InvitePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userService = context.watch<UserService>();
    final userInfo = userService.userInfo?.userInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('邵氏先天历'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: userInfo != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  UserInfoCard(
                    birthTime: userInfo.birthDate != null
                        ? '${userInfo.birthDate} ${_getBirthTimeText(userInfo.birthTime)}'
                        : '未设置',
                    userId: userInfo.id?.toString() ?? '-',
                    onInviteTap: _handleInvite,
                  ),
                  InterpretationCard(
                    title:
                        '邵氏解读：${userService.userInfo?.weatherDivination?.luck ?? ''}',
                    type: InterpretationType.tianShi,
                    hexagramText:
                        userService.userInfo?.weatherDivination?.name ?? '',
                    guaCi: userService.userInfo?.weatherDivination?.words ?? '',
                    xiangZhuan:
                        userService.userInfo?.weatherDivination?.xiangChuan ??
                            '',
                    tuanZhuan:
                        userService.userInfo?.weatherDivination?.tuanChuan ??
                            '',
                  ),
                  InterpretationCard(
                    title:
                        '邵氏解读：${userService.userInfo?.terrainDivination?.luck ?? ''}',
                    type: InterpretationType.diShi,
                    hexagramText:
                        userService.userInfo?.terrainDivination?.name ?? '',
                    guaCi: userService.userInfo?.terrainDivination?.words ?? '',
                    xiangZhuan:
                        userService.userInfo?.terrainDivination?.xiangChuan ??
                            '',
                    tuanZhuan:
                        userService.userInfo?.terrainDivination?.tuanChuan ??
                            '',
                  ),
                  InterpretationCard(
                    title:
                        '邵氏解读：${userService.userInfo?.birthDivination?.luck ?? ''}',
                    type: InterpretationType.shengLi,
                    hexagramText:
                        userService.userInfo?.birthDivination?.name ?? '',
                    guaCi: userService.userInfo?.birthDivination?.words ?? '',
                    xiangZhuan:
                        userService.userInfo?.birthDivination?.xiangChuan ?? '',
                    tuanZhuan:
                        userService.userInfo?.birthDivination?.tuanChuan ?? '',
                    onPressed: () {
                      // TODO: 处理按钮点击
                    },
                  ),
                  InterpretationCard(
                    title:
                        '邵氏解读：${userService.userInfo?.knotDivination?.luck ?? ''}',
                    type: InterpretationType.siJie,
                    hexagramText:
                        userService.userInfo?.knotDivination?.name ?? '',
                    guaCi: userService.userInfo?.knotDivination?.words ?? '',
                    xiangZhuan:
                        userService.userInfo?.knotDivination?.xiangChuan ?? '',
                    tuanZhuan:
                        userService.userInfo?.knotDivination?.tuanChuan ?? '',
                    onPressed: () {
                      // TODO: 处理按钮点击
                    },
                  ),
                  const SizedBox(height: 16),
                  ListGroup(
                    children: [
                      ListCell(
                        icon: Icons.account_circle_outlined,
                        title: '账户中心',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountPage(),
                            ),
                          );
                        },
                      ),
                      if ((userInfo.promotion ?? 0) > 0)
                        ListCell(
                          icon: Icons.share_outlined,
                          title: '推荐邀请',
                          onTap: _handleInvite,
                        ),
                      ListCell(
                        icon: Icons.headset_mic_outlined,
                        title: '在线客服',
                        onTap: () {
                          // TODO: 处理点击
                        },
                      ),
                      ListCell(
                        icon: Icons.info_outline,
                        title: '关于我们',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          : LoginPrompt(onLogin: _handleLogin),
    );
  }

  String _getBirthTimeText(int? birthTime) {
    switch (birthTime) {
      case 1:
        return '00:00-04:00';
      case 2:
        return '04:00-08:00';
      case 3:
        return '08:00-12:00';
      case 4:
        return '12:00-16:00';
      case 5:
        return '16:00-20:00';
      case 6:
        return '20:00-24:00';
      default:
        return '';
    }
  }
}

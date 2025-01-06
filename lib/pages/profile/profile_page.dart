import 'package:flutter/material.dart';
import '../profile/login_page.dart';
import 'widgets/login_prompt.dart';
import 'widgets/user_info_card.dart';
import 'widgets/interpretation_card.dart';
import '../../widgets/glowing_hexagram.dart';
import '../../widgets/list/list_cell.dart';
import '../../widgets/list/list_group.dart';
import 'invite_page.dart';
import 'account_page.dart';

/// 个人中心页面
class ProfilePage extends StatefulWidget {
  /// 创建个人中心页面
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: 这里应该从用户状态管理中获取
  bool _isLoggedIn = true;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('邵氏先天历'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: _isLoggedIn
          ? SingleChildScrollView(
              child: Column(
                children: [
                  UserInfoCard(
                    birthTime: '1990年8月1日 12:00',
                    userId: '138****0000',
                    onInviteTap: _handleInvite,
                  ),
                  InterpretationCard(
                    title: '邵氏解读：剥离剥夺，分化瓦解',
                    type: InterpretationType.tianShi,
                    hexagramText: '剥',
                    hexagramType: HexagramBgType.orange,
                    guaCi: '剥：不利于有攸往。',
                    xiangZhuan: '山附于地，剥；上以厚下，安宅。',
                    tuanZhuan: '剥，剥也，柔变刚也。不利有攸往，小人长也。顺而止之，观象也。君子尚消息盈虚，天行也。',
                  ),
                  InterpretationCard(
                    title: '邵氏解读：剥离剥夺，分化瓦解',
                    type: InterpretationType.diShi,
                    hexagramText: '剥',
                    hexagramType: HexagramBgType.orange,
                    guaCi: '剥：不利于有攸往。',
                    xiangZhuan: '山附于地，剥；上以厚下，安宅。',
                    tuanZhuan: '剥，剥也，柔变刚也。不利有攸往，小人长也。顺而止之，观象也。君子尚消息盈虚，天行也。',
                  ),
                  InterpretationCard(
                    title: '邵氏解读：剥离剥夺，分化瓦解',
                    type: InterpretationType.shengLi,
                    hexagramText: '剥',
                    hexagramType: HexagramBgType.orange,
                    guaCi: '剥：不利于有攸往。',
                    xiangZhuan: '山附于地，剥；上以厚下，安宅。',
                    tuanZhuan: '剥，剥也，柔变刚也。不利有攸往，小人长也。顺而止之，观象也。君子尚消息盈虚，天行也。',
                    onPressed: () {
                      // TODO: 处理按钮点击
                    },
                  ),
                  InterpretationCard(
                    title: '邵氏解读：剥离剥夺，分化瓦解',
                    type: InterpretationType.siJie,
                    hexagramText: '剥',
                    hexagramType: HexagramBgType.orange,
                    guaCi: '剥：不利于有攸往。',
                    xiangZhuan: '山附于地，剥；上以厚下，安宅。',
                    tuanZhuan: '剥，剥也，柔变刚也。不利有攸往，小人长也。顺而止之，观象也。君子尚消息盈虚，天行也。',
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
                          // TODO: 处理点击
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
}

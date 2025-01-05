import 'package:flutter/material.dart';
import '../profile/login_page.dart';

/// 个人中心页面
class ProfilePage extends StatelessWidget {
  /// 创建个人中心页面
  const ProfilePage({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 头像占位
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withAlpha(50),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 40,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            // 登录提示
            Text(
              '登录后查看更多内容',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            // 登录按钮
            TextButton(
              onPressed: () {
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
                    reverseTransitionDuration:
                        const Duration(milliseconds: 400),
                    fullscreenDialog: true,
                    opaque: false,
                    barrierColor: Colors.black.withAlpha(100),
                  ),
                );
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(120, 40),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                foregroundColor: colorScheme.primary,
              ),
              child: const Text(
                '立即登录',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

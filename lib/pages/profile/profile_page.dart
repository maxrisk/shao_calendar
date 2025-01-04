import 'package:flutter/material.dart';
import '../profile/login_page.dart';

/// 个人中心页面
class ProfilePage extends StatelessWidget {
  /// 创建个人中心页面
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 头像占位
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 40,
              color: Theme.of(context).cardColor,
            ),
          ),
          const SizedBox(height: 16),
          // 登录提示
          Text(
            '登录后查看更多内容',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          // 登录按钮
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              minimumSize: const Size(120, 40),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text(
              '立即登录',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// 个人中心页面
class ProfilePage extends StatelessWidget {
  /// 创建个人中心页面
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '个人中心',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

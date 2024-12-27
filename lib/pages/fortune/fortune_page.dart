import 'package:flutter/material.dart';

/// 个人运势页面
class FortunePage extends StatelessWidget {
  /// 创建个人运势页面
  const FortunePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '个人运势',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

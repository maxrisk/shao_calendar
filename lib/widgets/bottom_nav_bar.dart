import 'package:flutter/material.dart';

/// 应用底部导航栏
class BottomNavBar extends StatelessWidget {
  /// 创建一个底部导航栏
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  /// 当前选中的索引
  final int currentIndex;

  /// 点击事件回调
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: '先天历',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: '个人运势',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '个人中心',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onTap,
    );
  }
}

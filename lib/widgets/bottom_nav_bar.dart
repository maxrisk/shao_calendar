import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: '先天历',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_awesome_outlined),
          activeIcon: Icon(Icons.auto_awesome),
          label: '个人运势',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: '个人中心',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
    );
  }
}

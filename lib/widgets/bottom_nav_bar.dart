/*
 * @Author: maxrisk 469057099@qq.com
 * @Date: 2024-12-31 15:10:25
 * @LastEditors: maxrisk 469057099@qq.com
 * @LastEditTime: 2025-05-15 15:01:33
 * @FilePath: /flutter_calendar/lib/widgets/bottom_nav_bar.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
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
          label: '本数历',
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

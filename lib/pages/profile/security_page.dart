import 'package:flutter/material.dart';
import '../../widgets/list/list_cell.dart';
import '../../widgets/list/list_group.dart';

/// 账户安全页面
class SecurityPage extends StatelessWidget {
  /// 创建账户安全页面
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('账户安全'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListGroup(
              children: [
                // ListCell(
                //   icon: Icons.lock_outline,
                //   title: '登录密码',
                //   subtitle: '用于账号登录',
                //   onTap: () {
                //     // TODO: 跳转修改密码页面
                //   },
                // ),
                ListCell(
                  icon: Icons.pin_outlined,
                  title: '支付密码',
                  subtitle: '用于账户支付',
                  onTap: () {
                    // TODO: 跳转设置支付密码页面
                  },
                ),
                // ListCell(
                //   icon: Icons.phonelink_lock_outlined,
                //   title: '设备管理',
                //   subtitle: '查看登录设备',
                //   onTap: () {
                //     // TODO: 跳转设备管理页面
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

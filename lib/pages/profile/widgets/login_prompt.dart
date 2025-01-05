import 'package:flutter/material.dart';

/// 登录提示组件
class LoginPrompt extends StatelessWidget {
  /// 创建登录提示组件
  const LoginPrompt({
    super.key,
    required this.onLogin,
  });

  /// 登录按钮点击回调
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Text(
            '登录后查看更多内容',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: onLogin,
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
    );
  }
}

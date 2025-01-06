import 'package:flutter/material.dart';
import '../../widgets/verify_code_input.dart';
import '../../pages/profile/complete_info_page.dart';

/// 验证码页面
class VerifyCodePage extends StatelessWidget {
  /// 创建验证码页面
  const VerifyCodePage({
    super.key,
    required this.phone,
  });

  /// 手机号
  final String phone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return VerifyCodeInput(
      title: '验证手机号',
      subtitle: TextSpan(
        text: '获取 ',
        children: [
          TextSpan(
            text: '${phone.substring(0, 3)}****${phone.substring(7)}',
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(
            text: ' 的短信验证码',
          ),
        ],
      ),
      onSubmit: (code) {
        // TODO: 处理验证码提交
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteInfoPage(),
          ),
        );
      },
      onCancel: () => Navigator.pop(context),
    );
  }
}

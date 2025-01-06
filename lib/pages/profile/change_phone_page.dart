import 'package:flutter/material.dart';
import '../../widgets/verify_code_input.dart';
import 'bind_new_phone_page.dart';

/// 修改手机号页面
class ChangePhonePage extends StatelessWidget {
  /// 创建修改手机号页面
  const ChangePhonePage({
    super.key,
    required this.phone,
  });

  /// 当前手机号
  final String phone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return VerifyCodeInput(
      title: '如需修改，请先验证旧手机号',
      subtitle: TextSpan(
        text: '验证 ',
        children: [
          TextSpan(
            text: phone,
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
        // 验证成功后跳转到绑定新手机号页面
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BindNewPhonePage(),
          ),
        );
      },
      onCancel: () => Navigator.pop(context),
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/verify_code_input.dart';
import '../../services/user_service.dart';
import 'set_pay_password_page.dart';
import 'package:provider/provider.dart';

/// 验证手机号页面
class VerifyPhonePage extends StatefulWidget {
  /// 创建验证手机号页面
  const VerifyPhonePage({
    super.key,
    this.phone,
    this.isVerifyCode = false,
  });

  /// 手机号
  final String? phone;

  /// 是否是验证码页面
  final bool isVerifyCode;

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(String code) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPayPasswordPage(verificationCode: code),
      ),
    );
  }

  Future<bool> _handleSend() async {
    // 发送支付密码验证码
    final success = await UserService().getPayPasswordCode();
    if (mounted) {
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取验证码失败，请重试')),
        );
      }
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    final userService = context.watch<UserService>();
    final userInfo = userService.userInfo?.userInfo;

    return VerifyCodeInput(
      title: '获取验证码',
      subtitle: TextSpan(
          text:
              '验证 ${userInfo?.phone?.substring(0, 3)}****${userInfo?.phone?.substring(7, 11)} 获取的验证码'),
      autoFocus: true,
      onSubmit: _handleSubmit,
      onCancel: () => Navigator.pop(context),
      onSend: _handleSend,
    );
  }
}

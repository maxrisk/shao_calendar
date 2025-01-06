import 'package:flutter/material.dart';
import '../../widgets/verify_code_input.dart';
import '../../widgets/form/form_field.dart';
import 'set_pay_password_page.dart';

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
  bool _isValid = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit(String code) {
    if (widget.isVerifyCode) {
      // 验证码验证成功后跳转到设置支付密码页面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SetPayPasswordPage(),
        ),
      );
    } else {
      // 手机号验证成功后跳转到验证码页面
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyPhonePage(
            phone: _phoneController.text,
            isVerifyCode: true,
          ),
        ),
      );
    }
  }

  void _onPhoneChanged(String value) {
    setState(() {
      _isValid = value.length == 11;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVerifyCode) {
      return VerifyCodeInput(
        title: '输入验证码',
        subtitle: TextSpan(text: '验证码已发送至 ${widget.phone}'),
        autoStart: true,
        autoFocus: true,
        onSubmit: _handleSubmit,
        onCancel: () => Navigator.pop(context),
      );
    }

    return VerifyCodeInput(
      title: '验证手机号',
      subtitle: const TextSpan(text: '请输入手机号进行验证'),
      customContent: FormItem(
        label: '手机号',
        hint: '请输入手机号',
        icon: Icons.phone_outlined,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        maxLength: 11,
        onChanged: _onPhoneChanged,
      ),
      showVerifyCodeButton: false,
      submitEnabled: _isValid,
      onSubmit: _handleSubmit,
      onCancel: () => Navigator.pop(context),
    );
  }
}

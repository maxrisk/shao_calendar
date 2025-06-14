import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/user_service.dart';
import '../../widgets/verify_code_input.dart';

/// 绑定新手机号页面
class BindNewPhonePage extends StatefulWidget {
  /// 创建绑定新手机号页面
  const BindNewPhonePage({super.key, required this.verificationCode});

  /// 验证码
  final String verificationCode;

  @override
  State<BindNewPhonePage> createState() => _BindNewPhonePageState();
}

class _BindNewPhonePageState extends State<BindNewPhonePage> {
  final _phoneController = TextEditingController();
  bool _isValid = false;
  bool _showVerifyCode = false;
  String? _phone;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onPhoneChanged(String value) {
    setState(() {
      _isValid = value.length == 11;
    });
  }

  void _handleNext() async {
    if (_isValid) {
      final success = await UserService().getNewPhoneCode(
        _phoneController.text,
        widget.verificationCode,
      );
      if (success) {
        setState(() {
          _phone = _phoneController.text;
          _showVerifyCode = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取验证码失败')),
        );
      }
    }
  }

  void _handleSuccess(BuildContext context, String code) async {
    final (success, errorMsg) = await UserService().updatePhone(
      _phoneController.text,
      code,
    );
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('手机号修改成功'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
    if (errorMsg != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
    // 延迟一下再返回，让用户看到提示
    Future.delayed(const Duration(seconds: 1), () {
      if (!context.mounted) return;
      // 返回到账户页面（移除验证旧手机号和绑定新手机号两个页面）
      Navigator.of(context)
        ..pop() // 移除绑定新手机号页面
        ..pop(); // 移除验证旧手机号页面
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showVerifyCode) {
      return VerifyCodeInput(
        title: '绑定新手机号',
        subtitle: TextSpan(
          text: '获取 ',
          children: [
            TextSpan(
              text: _phone,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: ' 的短信验证码',
            ),
          ],
        ),
        onSubmit: (code) {
          _handleSuccess(context, code);
        },
        onCancel: () => Navigator.pop(context),
        onSend: () async {
          final success = await UserService().getNewPhoneCode(
            _phoneController.text,
            widget.verificationCode,
          );
          if (!success && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('获取验证码失败')),
            );
          }
          return success;
        },
      );
    }

    final colorScheme = Theme.of(context).colorScheme;

    return VerifyCodeInput(
      title: '绑定新手机号',
      subtitle: const TextSpan(text: '请输入新的手机号'),
      customContent: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: TextField(
          controller: _phoneController,
          style: const TextStyle(
            fontSize: 15,
            height: 1.2,
          ),
          decoration: InputDecoration(
            hintText: '请输入手机号',
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: InputBorder.none,
            counterText: '',
          ),
          maxLength: 11,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: _onPhoneChanged,
        ),
      ),
      showVerifyCodeButton: false,
      onSubmit: (_) => _handleNext(),
      onCancel: () => Navigator.pop(context),
      submitEnabled: _isValid,
    );
  }
}

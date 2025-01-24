import 'package:flutter/material.dart';
import '../../widgets/verify_code_input.dart';
import '../../services/user_service.dart';

/// 设置支付密码页面
class SetPayPasswordPage extends StatefulWidget {
  /// 创建设置支付密码页面
  const SetPayPasswordPage({super.key, required this.verificationCode});

  /// 验证码
  final String verificationCode;

  @override
  State<SetPayPasswordPage> createState() => _SetPayPasswordPageState();
}

class _SetPayPasswordPageState extends State<SetPayPasswordPage>
    with SingleTickerProviderStateMixin {
  String? _firstPassword;
  late final AnimationController _animationController;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit(String password) async {
    if (_firstPassword == null) {
      setState(() {
        _firstPassword = password;
      });
      _controller.clear();
      _animationController.forward(from: 0.0);
    } else {
      if (_firstPassword == password) {
        final success = await UserService().updatePayPassword(
          code: widget.verificationCode,
          password: password,
        );
        if (mounted) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('支付密码设置成功')),
            );
            // 密码设置成功，返回到安全页面
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('支付密码设置失败')),
            );
          }
        }
      } else {
        // 两次密码不一致
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('两次输入的密码不一致'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() {
          _firstPassword = null;
        });
        _controller.clear();
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return VerifyCodeInput(
          title: _firstPassword == null ? '设置支付密码' : '确认支付密码',
          subtitle: TextSpan(
            text: _firstPassword == null ? '请设置6位数字支付密码' : '请再次输入支付密码',
          ),
          codeLength: 6,
          obscureText: true,
          autoFocus: true,
          showVerifyCodeButton: false,
          controller: _controller,
          onSubmit: _handleSubmit,
          onCancel: () => Navigator.pop(context, false),
        );
      },
    );
  }
}

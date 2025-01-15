import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/verify_code_input.dart';
import '../../pages/profile/complete_info_page.dart';
import '../../services/user_service.dart';

/// 验证码页面
class VerifyCodePage extends StatefulWidget {
  /// 创建验证码页面
  const VerifyCodePage({
    super.key,
    required this.phone,
    this.autoStart = false,
  });

  /// 手机号
  final String phone;

  /// 是否自动开始倒计时
  final bool autoStart;

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  bool _isSubmitting = false;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
      ),
    );
  }

  Future<bool> _sendVerifyCode() async {
    try {
      if (_isSubmitting) return false;

      setState(() {
        _isSubmitting = true;
      });

      final userService = context.read<UserService>();
      final success = await userService.getVerificationCode(widget.phone);
      if (!mounted) return false;

      if (!success) {
        showMessage('发送验证码失败，请重试');
      }
      return success;
    } catch (e) {
      if (!mounted) return false;
      showMessage('发送验证码失败，请重试');
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _handleSubmit(String code) async {
    try {
      final userService = context.read<UserService>();
      final userInfo = await userService.login(widget.phone, code);

      if (!mounted) return;

      if (userInfo != null) {
        // 登录成功，判断是否需要完善信息
        if (userInfo.userInfo.birthDate == null) {
          // 需要完善生日信息
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CompleteInfoPage(),
            ),
          );
        } else {
          // 直接返回上一页
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } else {
        showMessage('验证码错误或已过期');
      }
    } catch (e) {
      if (!mounted) return;
      showMessage('验证失败，请重试');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // 页面加载时自动发送验证码
    if (widget.autoStart) {
      _sendVerifyCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return VerifyCodeInput(
      title: '验证手机号',
      autoStart: widget.autoStart,
      codeLength: 6,
      subtitle: TextSpan(
        text: '获取 ',
        children: [
          TextSpan(
            text:
                '${widget.phone.substring(0, 3)}****${widget.phone.substring(7)}',
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
      onSubmit: _handleSubmit,
      onSend: _sendVerifyCode,
      onCancel: () => Navigator.pop(context),
    );
  }
}

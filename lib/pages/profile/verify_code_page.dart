import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/verify_code_input.dart';
import '../../pages/profile/complete_info_page.dart';
import '../../pages/profile/confirm_area_page.dart';
import '../../services/user_service.dart';

/// 验证码页面
class VerifyCodePage extends StatefulWidget {
  /// 创建验证码页面
  const VerifyCodePage({
    super.key,
    required this.phone,
    this.autoStart = false,
    this.openid,
    this.unionid,
  });

  /// 手机号
  final String phone;

  /// 是否自动开始倒计时
  final bool autoStart;

  /// 微信openid，用于绑定手机号
  final String? openid;

  /// 微信unionid，用于绑定手机号
  final String? unionid;

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  bool _isSubmitting = false;
  Map<String, dynamic>? _province;
  Map<String, dynamic>? _city;

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
      final (success, province, city) =
          await userService.getVerificationCode(widget.phone);
      if (!mounted) return false;

      if (!success) {
        showMessage('发送验证码失败，请重试');
      } else {
        _province = province;
        _city = city;
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
      final userInfo = await userService.login(
        phone: widget.phone,
        code: code,
        openid: widget.openid,
        unionid: widget.unionid,
      );

      if (!mounted) return;

      if (userInfo != null) {
        // 登录成功，检查用户信息
        final user = userInfo.userInfo;

        if (user.provinceId == null || user.cityId == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmAreaPage(
                phone: widget.phone,
                code: code,
                province: _province,
                city: _city,
              ),
            ),
          );
        } else if (user.birthDate?.isEmpty ?? true) {
          // 如果生日信息为空，跳转到完善信息页面
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CompleteInfoPage(),
            ),
          );
        } else {
          // 信息完整，直接返回
          Navigator.pop(context);
          if (widget.openid != null) {
            // 如果是微信登录绑定手机号，多返回一层
            Navigator.pop(context);
          }
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
      codeLength: 4,
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

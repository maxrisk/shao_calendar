import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../../../widgets/rounded_icon_button.dart';
import 'verify_code_page.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  /// 创建登录页面
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isAgreed = false;
  bool _isPhoneValid = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validatePhone(String value) {
    setState(() {
      _isPhoneValid = RegExp(r'^1[3-9]\d{9}$').hasMatch(value);
    });
  }

  void _handleNext() {
    if (_isPhoneValid && _isAgreed) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VerifyCodePage(
            phone: _phoneController.text,
          ),
        ),
      );
    }
  }

  void _handleAgreement() {
    // TODO: 跳转到用户协议页面
  }

  void _handlePrivacy() {
    // TODO: 跳转到隐私政策页面
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.dark
            : Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => _focusNode.unfocus(),
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Text(
                        '让我知道你的手机号码',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _phoneController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.phone,
                        onChanged: _validatePhone,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: '请输入手机号',
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 64),
                      Center(
                        child: Text(
                          '其他登录方式',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 微信图标
                      Center(
                        child: IconButton(
                          onPressed: () {
                            // TODO: 处理微信登录
                          },
                          icon: Image.asset(
                            'assets/images/wechat.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // 用户协议
                      Row(
                        children: [
                          Checkbox(
                            value: _isAgreed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isAgreed = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: '我已阅读并同意',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                children: [
                                  TextSpan(
                                    text: '《用户协议》',
                                    style: TextStyle(
                                      color: colorScheme.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _handleAgreement,
                                  ),
                                  TextSpan(
                                    text: '和',
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '《隐私政策》',
                                    style: TextStyle(
                                      color: colorScheme.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _handlePrivacy,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // 关闭按钮
                        RoundedIconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
                        // 下一步按钮
                        RoundedIconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed:
                              _isPhoneValid && _isAgreed ? _handleNext : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

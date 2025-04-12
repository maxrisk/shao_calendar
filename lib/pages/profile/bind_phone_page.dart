import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/rounded_icon_button.dart';
import '../../config/urls.dart';
import 'verify_code_page.dart';

/// 绑定手机号页面
class BindPhonePage extends StatefulWidget {
  /// 创建绑定手机号页面
  const BindPhonePage({
    super.key,
    required this.openid,
    required this.unionid,
  });

  /// 微信openid
  final String openid;

  /// 微信unionid
  final String? unionid;

  @override
  State<BindPhonePage> createState() => _BindPhonePageState();
}

class _BindPhonePageState extends State<BindPhonePage> {
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isAgreed = false;
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    // 延迟聚焦，确保页面已完全构建
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

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
            autoStart: true,
            openid: widget.openid,
            unionid: widget.unionid,
          ),
        ),
      );
    }
  }

  Future<void> _openUrl(String url) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法打开链接')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('打开链接失败')),
        );
      }
    }
  }

  void _handleAgreement() {
    _openUrl(URLs.userAgreement);
  }

  void _handlePrivacy() {
    _openUrl(URLs.privacyPolicy);
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
                        '绑定手机号',
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

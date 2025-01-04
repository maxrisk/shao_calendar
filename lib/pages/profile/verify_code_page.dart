import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/rounded_icon_button.dart';

/// 验证码输入页面
class VerifyCodePage extends StatefulWidget {
  /// 创建验证码输入页面
  const VerifyCodePage({
    super.key,
    required this.phone,
  });

  /// 手机号
  final String phone;

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  bool _isValid = false;
  int _countdown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // 延迟聚焦，确保页面已完全构建
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdown = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _handleResend() {
    if (_countdown == 0) {
      // TODO: 处理重新发送验证码
      _startCountdown();
    }
  }

  void _handleSubmit() {
    if (_isValid) {
      // TODO: 处理验证码提交
    }
  }

  void _onChanged(String value) {
    setState(() {
      _isValid = value.length == 4;
    });
  }

  String get _formattedPhone {
    final phone = widget.phone;
    return '+86-${phone.substring(0, 3)}****${phone.substring(7)}';
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
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          Text.rich(
                            TextSpan(
                              text: '输入验证码\n',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onBackground,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: '我已发送到 $_formattedPhone',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          GestureDetector(
                            onTap: () => _focusNode.requestFocus(),
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  final text = _controller.text;
                                  final char =
                                      text.length > index ? text[index] : '';
                                  return Container(
                                    width: 64,
                                    height: 64,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: colorScheme.outlineVariant,
                                      ),
                                    ),
                                    child: Text(
                                      char,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
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
                            RoundedIconButton(
                              icon: Icon(
                                Icons.close,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const Spacer(),
                            _countdown > 0
                                ? TextButton(
                                    onPressed: null,
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(120, 44),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: colorScheme.outlineVariant,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      '重新发送($_countdown)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  )
                                : MaterialButton(
                                    onPressed: _handleResend,
                                    color: colorScheme.primary,
                                    minWidth: 120,
                                    height: 44,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '重新发送',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                            const Spacer(),
                            RoundedIconButton(
                              icon: Icon(Icons.check),
                              onPressed: _isValid ? _handleSubmit : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 隐藏的输入框
              Positioned(
                left: 0,
                right: 0,
                bottom: -200,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: const InputDecoration(
                    counterText: '',
                  ),
                  onChanged: _onChanged,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

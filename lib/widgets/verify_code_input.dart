import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rounded_icon_button.dart';
import 'pin_input.dart';

/// 验证码输入组件
class VerifyCodeInput extends StatefulWidget {
  /// 创建验证码输入组件
  const VerifyCodeInput({
    super.key,
    required this.title,
    required this.subtitle,
    this.onSend,
    this.customContent,
    this.showVerifyCodeButton = true,
    this.submitEnabled = false,
    required this.onSubmit,
    required this.onCancel,
    this.autoStart = false,
    this.codeLength = 4,
    this.obscureText = false,
    this.autoFocus = false,
    this.controller,
  });

  /// 标题
  final String title;

  /// 副标题
  final InlineSpan subtitle;

  /// 自定义内容
  final Widget? customContent;

  /// 是否显示获取验证码按钮
  final bool showVerifyCodeButton;

  /// 提交按钮是否启用
  final bool submitEnabled;

  /// 提交回调
  final FutureOr<void> Function(String) onSubmit;

  /// 取消回调
  final VoidCallback onCancel;

  /// 是否自动开始倒计时
  final bool autoStart;

  /// 是否自动获取焦点
  final bool autoFocus;

  /// 是否隐藏输入框内容
  final bool obscureText;

  /// 验证码长度
  final int codeLength;

  /// 输入控制器
  final TextEditingController? controller;

  /// 发送验证码回调
  final Future<bool> Function()? onSend;

  @override
  State<VerifyCodeInput> createState() => _VerifyCodeInputState();
}

class _VerifyCodeInputState extends State<VerifyCodeInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _countdown = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      _startCountdown();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = 60;
    });
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

  void _handleSubmit() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final result = widget.onSubmit(_controller.text);
      if (result is Future) {
        await result;
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _handleSend() {
    if (_countdown == 0) {
      setState(() {
        _isSubmitting = true;
      });
      print('发送验证码 method, ${widget.onSend}');
      widget.onSend?.call().then((value) {
        setState(() {
          _isSubmitting = false;
        });
      });
      _startCountdown();
    }
  }

  void _onChanged(String value) {
    setState(() {
      _controller.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isVerifyCodeInput = widget.customContent == null;

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
        onTap: () => FocusScope.of(context).unfocus(),
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
                              text: '${widget.title}\n',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  children: [widget.subtitle],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          widget.customContent ??
                              PinInput(
                                length: widget.codeLength,
                                autofocus: widget.autoFocus,
                                onChanged: _onChanged,
                                obscureText: widget.obscureText,
                                controller: _controller,
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
                              onPressed: widget.onCancel,
                            ),
                            const Spacer(),
                            if (widget.showVerifyCodeButton &&
                                isVerifyCodeInput)
                              _countdown > 0
                                  ? TextButton(
                                      onPressed: null,
                                      child: Text(
                                        '你可以在 $_countdown 秒后重新获取验证码',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    )
                                  : MaterialButton(
                                      onPressed:
                                          _isSubmitting ? null : _handleSend,
                                      color: colorScheme.primary,
                                      minWidth: 180,
                                      height: 44,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: _isSubmitting
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              '获取验证码',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: colorScheme.onPrimary,
                                              ),
                                            ),
                                    ),
                            if (widget.showVerifyCodeButton) const Spacer(),
                            RoundedIconButton(
                              isSubmitting: _isSubmitting,
                              icon: Icon(
                                Icons.check,
                                color: (isVerifyCodeInput
                                        ? _controller.text.length ==
                                            widget.codeLength
                                        : widget.submitEnabled)
                                    ? colorScheme.primary
                                    : colorScheme.onSurfaceVariant
                                        .withAlpha(120),
                              ),
                              onPressed: (isVerifyCodeInput
                                      ? _controller.text.length ==
                                          widget.codeLength
                                      : widget.submitEnabled)
                                  ? _handleSubmit
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

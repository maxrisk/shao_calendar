import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pin_input.dart';

/// 支付密码输入对话框
class PayPasswordDialog extends StatefulWidget {
  /// 创建支付密码输入对话框
  const PayPasswordDialog({
    super.key,
    this.title = '请输入支付密码',
    this.hintText = '请输入6位数字支付密码',
    this.cancelText = '取消',
    this.confirmText = '确定',
    this.errorText,
  });

  /// 标题
  final String title;

  /// 输入框提示文本
  final String hintText;

  /// 取消按钮文本
  final String cancelText;

  /// 确认按钮文本
  final String confirmText;

  /// 错误提示文本
  final String? errorText;

  /// 显示支付密码输入对话框
  static Future<String?> show({
    required BuildContext context,
    String title = '请输入支付密码',
    String hintText = '请输入6位数字支付密码',
    String cancelText = '取消',
    String confirmText = '确定',
    String? errorText,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PayPasswordDialog(
        title: title,
        hintText: hintText,
        cancelText: cancelText,
        confirmText: confirmText,
        errorText: errorText,
      ),
    );
  }

  @override
  State<PayPasswordDialog> createState() => _PayPasswordDialogState();
}

class _PayPasswordDialogState extends State<PayPasswordDialog> {
  final _controller = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _isValid = value.length == 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.hintText,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          PinInput(
            length: 6,
            obscureText: true,
            autofocus: true,
            compact: true,
            controller: _controller,
            onChanged: _onPasswordChanged,
            onCompleted: (value) {},
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        Row(
          children: [
            Expanded(
              child: FilledButton.tonal(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                ),
                child: Text(
                  widget.cancelText,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: _isValid
                    ? () => Navigator.pop(context, _controller.text)
                    : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.confirmText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

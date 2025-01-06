import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// PIN 码输入框
class PinInput extends StatefulWidget {
  /// 创建 PIN 码输入框
  const PinInput({
    super.key,
    this.length = 4,
    this.obscureText = false,
    this.autofocus = false,
    this.onCompleted,
    this.onChanged,
    this.controller,
  }) : assert(length > 0 && length <= 6, 'PIN码长度必须在1-6之间');

  /// 长度
  final int length;

  /// 是否隐藏内容
  final bool obscureText;

  /// 是否自动获取焦点
  final bool autofocus;

  /// 输入完成回调
  final ValueChanged<String>? onCompleted;

  /// 输入框改变回调
  final ValueChanged<String>? onChanged;

  /// 输入控制器
  final TextEditingController? controller;

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleChange);
    if (widget.autofocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {});
    widget.onChanged?.call(_controller.text);
    if (_controller.text.length == widget.length) {
      widget.onCompleted?.call(_controller.text);
    }
  }

  String _getDisplayChar(String char) {
    if (widget.obscureText && char.isNotEmpty) {
      return '●';
    }
    return char;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // 计算每个输入框的大小
    final minSpacing = 5.0; // 输入框之间的最小间距
    final horizontalPadding = 32.0; // 两侧留白
    final totalSpacing = (widget.length - 1) * minSpacing; // 所有间距的总和
    final availableWidth =
        screenWidth - totalSpacing - horizontalPadding * 2; // 可用宽度
    final size =
        (availableWidth / widget.length).clamp(48.0, 64.0); // 输入框大小，限制在48-64之间

    return Stack(
      children: [
        GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.length, (index) {
                final text = _controller.text;
                final char = text.length > index ? text[index] : '';

                return Container(
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Text(
                    _getDisplayChar(char),
                    style: TextStyle(
                      fontSize: size * 0.375, // 字体大小随输入框大小变化
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                );
              }),
            ),
          ),
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
            maxLength: widget.length,
            decoration: const InputDecoration(
              counterText: '',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}

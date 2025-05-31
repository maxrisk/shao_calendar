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
    this.compact = false,
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

  /// 是否使用紧凑模式（适用于对话框等空间有限的场景）
  final bool compact;

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

    // 根据是否紧凑模式调整参数
    final topMargin = widget.compact ? 8.0 : 16.0;
    final spacing = widget.compact ? 4.0 : 5.0; // 输入框之间的间距

    return Stack(
      children: [
        GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Container(
            margin: EdgeInsets.only(top: topMargin),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 根据可用宽度和PIN长度计算每个输入框的尺寸
                final availableWidth = constraints.maxWidth;

                // 计算所有间距的总宽度
                final totalSpacingWidth = spacing * (widget.length - 1);

                // 计算每个输入框的宽度
                final itemWidth =
                    (availableWidth - totalSpacingWidth) / widget.length;

                // 将宽度约束在合理范围内，以便在各种屏幕上显示
                final constrainedWidth = widget.compact
                    ? itemWidth
                    : itemWidth.clamp(
                        36.0, // 最小宽度
                        widget.length <= 4 ? 70.0 : 56.0, // 4位或更少时允许更大的最大宽度
                      );

                // 创建一个正方形的输入框（高度等于宽度）
                final itemSize = constrainedWidth;

                // 计算字体大小（基于输入框尺寸）
                final fontSize = itemSize * 0.4;

                // 计算行的总宽度（所有输入框+所有间距）
                final totalRowWidth =
                    (itemSize * widget.length) + totalSpacingWidth;

                // 计算需要的水平填充以使行居中
                final horizontalPadding = (availableWidth - totalRowWidth) / 2;

                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          horizontalPadding.clamp(0.0, double.infinity)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.length, (index) {
                      final text = _controller.text;
                      final char = text.length > index ? text[index] : '';

                      return Container(
                        width: itemSize,
                        height: itemSize,
                        margin: EdgeInsets.only(
                          right: index < widget.length - 1 ? spacing : 0,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.circular(widget.compact ? 8 : 12),
                          border: Border.all(
                            color: colorScheme.outlineVariant,
                          ),
                        ),
                        child: Text(
                          _getDisplayChar(char),
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
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

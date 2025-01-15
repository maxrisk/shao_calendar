import 'package:flutter/material.dart';

/// 圆角图标按钮组件
class RoundedIconButton extends StatelessWidget {
  /// 创建圆角图标按钮组件
  const RoundedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isSubmitting = false,
  });

  /// 图标
  final Widget icon;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 是否正在提交
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: isSubmitting
          ? const CircularProgressIndicator()
          : IconButton(
              onPressed: onPressed,
              icon: icon,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
    );
  }
}

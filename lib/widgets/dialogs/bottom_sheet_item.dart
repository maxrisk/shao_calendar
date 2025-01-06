import 'package:flutter/material.dart';

/// 底部弹窗列表项
class BottomSheetItem extends StatelessWidget {
  /// 创建底部弹窗列表项
  const BottomSheetItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  /// 标题
  final String title;

  /// 点击回调
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outlineVariant.withAlpha(50),
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

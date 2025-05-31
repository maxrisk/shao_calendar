import 'package:flutter/material.dart';

/// 底部弹窗列表项
class BottomSheetItem extends StatelessWidget {
  /// 创建底部弹窗列表项
  const BottomSheetItem({
    super.key,
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  /// 标题
  final String title;

  /// 点击回调
  final VoidCallback onTap;

  /// 是否选中
  final bool selected;

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
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color:
                        selected ? colorScheme.primary : colorScheme.onSurface,
                    fontWeight: selected ? FontWeight.w500 : null,
                  ),
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

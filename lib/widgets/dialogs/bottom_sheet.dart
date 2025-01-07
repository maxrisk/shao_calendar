import 'package:flutter/material.dart';

/// 底部弹窗
class BottomSheet extends StatelessWidget {
  /// 创建底部弹窗
  const BottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.constraints,
  });

  /// 标题
  final String title;

  /// 内容
  final Widget child;

  /// 约束
  final BoxConstraints? constraints;

  /// 显示底部弹窗
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    BoxConstraints? constraints,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BottomSheet(
          title: title,
          constraints: constraints,
          child: child,
        ),
      ),
    ).then((result) {
      if (!context.mounted) return result;
      FocusScope.of(context).unfocus();
      return result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
        if (constraints != null)
          ConstrainedBox(
            constraints: constraints!,
            child: child,
          )
        else
          child,
      ],
    );
  }
}

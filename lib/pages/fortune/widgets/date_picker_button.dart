import 'package:flutter/material.dart';

/// 日期选择按钮组件
class DatePickerButton extends StatelessWidget {
  /// 创建日期选择按钮组件
  const DatePickerButton({
    super.key,
    required this.date,
    required this.onPressed,
  });

  /// 选中的日期
  final DateTime date;

  /// 点击回调
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Theme.of(context).primaryColor.withAlpha(180),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          minimumSize: const Size.fromHeight(48),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            Text(
              '${date.year}年${date.month}月${date.day}日',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

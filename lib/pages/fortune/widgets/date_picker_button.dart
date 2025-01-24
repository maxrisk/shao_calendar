import 'package:flutter/material.dart';
import '../../../widgets/dialogs/date_picker_dialog.dart';

/// 日期选择按钮组件
class DatePickerButton extends StatelessWidget {
  /// 创建日期选择按钮组件
  const DatePickerButton({
    super.key,
    required this.date,
    required this.onDateChanged,
  });

  /// 选中的日期
  final DateTime date;

  /// 日期变更回调
  final ValueChanged<DateTime> onDateChanged;

  Future<void> _handlePressed(BuildContext context) async {
    final selectedDate = await showDatePickerDialog(
      context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      onDateChanged(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextButton(
        onPressed: () => _handlePressed(context),
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
            const Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

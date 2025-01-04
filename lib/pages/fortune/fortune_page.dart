import 'package:flutter/material.dart';
import 'widgets/fortune_card.dart';
import 'widgets/date_picker_button.dart';
import 'widgets/decorated_title.dart';
import 'widgets/fortune_display.dart';
import 'widgets/fortune_interpretation.dart';
import 'widgets/fortune_purchase_card.dart';

/// 个人运势页面
class FortunePage extends StatefulWidget {
  /// 创建个人运势页面
  const FortunePage({super.key});

  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                // 顶部卡片区域
                const FortuneCardGroup(),
                // 革年标题
                const DecoratedTitle(title: '革年'),
                // 日期选择按钮
                DatePickerButton(
                  date: _selectedDate,
                  onPressed: _selectDate,
                ),
                // 运势展示卡片
                FortuneDisplay(
                  date: _selectedDate,
                  onPrevious: _previousDay,
                  onNext: _nextDay,
                ),
                const SizedBox(height: 16),
                // 购买卡片
                FortunePurchaseCard(
                  onPurchase: () {
                    // TODO: 处理购买逻辑
                  },
                ),
                const SizedBox(height: 16),
                // 运势解读
                const FortuneInterpretation(),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/fortune_card.dart';
import 'widgets/date_picker_button.dart';
import 'widgets/decorated_title.dart';
import 'widgets/fortune_display.dart';
import 'widgets/fortune_interpretation.dart';
import 'widgets/fortune_purchase_card.dart';
import '../../pages/profile/calendar_service_page.dart';
import '../../models/fortune.dart';
import '../../services/fortune_service.dart';

/// 个人运势页面
class FortunePage extends StatefulWidget {
  /// 创建个人运势页面
  const FortunePage({super.key, this.fortuneData});

  /// 个人运势数据
  final FortuneData? fortuneData;

  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  DateTime _selectedDate = DateTime.now();
  final _fortuneService = FortuneService();
  FortuneResponse? _fortuneData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fortuneData = widget.fortuneData != null
        ? FortuneResponse(code: 0, data: widget.fortuneData)
        : null;
    if (_fortuneData == null) {
      _loadFortuneData(_selectedDate);
    }
  }

  Future<void> _loadFortuneData(DateTime date) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final response = await _fortuneService.getUserFortune(dateStr);
      if (mounted) {
        setState(() {
          _fortuneData = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取个人运势数据失败')),
        );
      }
    }
  }

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
      _loadFortuneData(picked);
    }
  }

  void _previousDay() {
    final previousDate = _selectedDate.subtract(const Duration(days: 1));
    setState(() {
      _selectedDate = previousDate;
    });
    _loadFortuneData(previousDate);
  }

  void _nextDay() {
    final nextDate = _selectedDate.add(const Duration(days: 1));
    setState(() {
      _selectedDate = nextDate;
    });
    _loadFortuneData(nextDate);
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
                FortuneCardGroup(fortuneData: _fortuneData?.data),
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
                  divination: _fortuneData?.data?.dayDivinationInfo,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
                // 购买卡片
                FortunePurchaseCard(
                  onPurchase: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarServicePage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // 运势解读
                FortuneInterpretation(
                  yaos: _fortuneData?.data?.yaos,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

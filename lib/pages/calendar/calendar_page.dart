import 'package:flutter/material.dart';
import 'widgets/hexagram_detail.dart';
import 'widgets/hexagram_display.dart';
import '../../widgets/lunar_calendar.dart';
import '../../widgets/fortune_card_group.dart';
import '../../widgets/glowing_hexagram.dart';
import '../../services/fortune_service.dart';
import '../../models/fortune.dart';
import '../fortune/hexagram_year_page.dart';
import '../fortune/hexagram_decade_page.dart';

/// 先天历页面
class CalendarPage extends StatefulWidget {
  /// 创建先天历页面
  const CalendarPage({super.key, this.fortuneData});

  final FortuneData? fortuneData;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final _fortuneService = FortuneService();
  FortuneData? _fortuneData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fortuneData = widget.fortuneData;
  }

  Future<void> _loadFortuneData(DateTime date) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final response = await _fortuneService.getFortune(dateStr);

      if (mounted) {
        setState(() {
          _fortuneData = response?.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取先天历数据失败')),
        );
      }
    }
  }

  void _handleCardTap(String cardType) {
    // 只处理点击左侧卡片（本命卦）的情况，跳转到六十年世选择页面
    if (cardType == 'base' && _fortuneData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HexagramYearPage(
            text: _fortuneData!.baseName,
            bgType: HexagramBgType.green,
            yearRange: _fortuneData!.decadeYears,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HexagramDecadePage(
            text: _fortuneData!.baseName,
            bgType: HexagramBgType.green,
            yearRange: _fortuneData!.decadeYears,
          ),
        ),
      );
    }
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
                FortuneCardGroup(
                  fortuneData: _fortuneData,
                  onCardTap: _handleCardTap,
                ),
                LunarCalendar(
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _loadFortuneData(selectedDay);
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _selectedDay = focusedDay;
                    });
                    _loadFortuneData(focusedDay);
                  },
                ),
                HexagramDisplay(
                  date: _selectedDay ?? _focusedDay,
                  divination: _fortuneData?.dayDivinationInfo,
                  isLoading: _isLoading,
                ),
                HexagramDetail(
                  yaos: _fortuneData?.yaos,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

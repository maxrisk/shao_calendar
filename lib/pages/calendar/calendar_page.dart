import 'package:flutter/material.dart';
import 'widgets/hexagram_detail.dart';
import 'widgets/hexagram_display.dart';
import '../../widgets/lunar_calendar.dart';

/// 先天历页面
class CalendarPage extends StatefulWidget {
  /// 创建先天历页面
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

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
                LunarCalendar(
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                HexagramDisplay(
                  date: _selectedDay ?? _focusedDay,
                ),
                HexagramDetail(
                  timeRange: '0:00-4:00',
                  hexagramName: '需卦',
                  mainText: '潜龙勿用',
                  secondaryText: '勿用取女',
                  interpretation:
                      '潜藏而无法施展，\n比喻君子压抑于下层，\n不能有所作为。\n遭遇强悍，\n不要妄生非分之想',
                  score: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

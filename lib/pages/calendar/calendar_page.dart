import 'package:flutter/material.dart';
import '../../widgets/lunar_calendar.dart';
import '../../widgets/hexagram_display.dart';
import '../../theme/app_theme.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
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
              ],
            ),
          ),
        );
      },
    );
  }
}

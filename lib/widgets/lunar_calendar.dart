import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lunar/lunar.dart';
import '../theme/app_theme.dart';

class LunarCalendar extends StatefulWidget {
  const LunarCalendar({
    super.key,
    this.onDaySelected,
    this.onPageChanged,
  });

  final void Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;
  final void Function(DateTime focusedDay)? onPageChanged;

  @override
  State<LunarCalendar> createState() => _LunarCalendarState();
}

class _LunarCalendarState extends State<LunarCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String _getLunarDate(DateTime date) {
    Lunar lunar = Lunar.fromDate(date);
    return '${lunar.getYearInGanZhiByLiChun()}年${lunar.getMonthInChinese()}月${lunar.getDayInChinese()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          // 日历头部 - 透明背景
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                      );
                    });
                  },
                ),
                Column(
                  children: [
                    Text(
                      '${_focusedDay.year}年${_focusedDay.month}月',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _getLunarDate(_focusedDay),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          // 日历主体 - 卡片背景
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: TableCalendar(
              headerVisible: false,
              availableGestures: AvailableGestures.horizontalSwipe,
              firstDay: DateTime.utc(1901, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              locale: 'zh_CN',
              daysOfWeekHeight: 32,
              onPageChanged: (focusedDay) {
                widget.onPageChanged?.call(focusedDay);
                // 处理页面切换事件
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedDay = focusedDay;
                });
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                weekendStyle: const TextStyle(
                  color: AppTheme.primaryColor,
                ),
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                widget.onDaySelected?.call(selectedDay, focusedDay);
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withAlpha(127),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              rowHeight: 44,
            ),
          ),
        ],
      ),
    );
  }
}

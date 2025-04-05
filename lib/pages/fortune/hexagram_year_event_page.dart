import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';

/// 年卦事件页面
class HexagramYearEventPage extends StatefulWidget {
  /// 创建年卦事件页面
  const HexagramYearEventPage({
    super.key,
    required this.initialYear,
    required this.hexagramText,
    required this.bgType,
  });

  /// 初始选中年份
  final int initialYear;

  /// 卦象文字
  final String hexagramText;

  /// 背景类型
  final HexagramBgType bgType;

  @override
  State<HexagramYearEventPage> createState() => _HexagramYearEventPageState();
}

class _HexagramYearEventPageState extends State<HexagramYearEventPage> {
  late int _selectedYear;
  late final List<int> _years;
  late final ScrollController _yearScrollController;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialYear;

    // 生成年份列表，倒序排列
    final currentYear = DateTime.now().year;
    _years = List.generate(10, (index) => currentYear - index);

    _yearScrollController = ScrollController();

    // 找到初始年份的索引，并在下一帧滚动到该位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_years.contains(_selectedYear)) {
        final index = _years.indexOf(_selectedYear);
        if (index >= 0) {
          _yearScrollController.animateTo(
            index * 80.0, // 每个年份项宽度约为80
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _yearScrollController.dispose();
    super.dispose();
  }

  // 根据年份获取对应的年号
  String _getEraName(int year) {
    // 简化处理，实际应用中可能需要更复杂的逻辑
    if (year >= 2024) return '龙年';
    if (year >= 2023) return '兔年';
    if (year >= 2022) return '虎年';
    if (year >= 2021) return '牛年';
    if (year >= 2020) return '鼠年';
    if (year >= 2019) return '猪年';
    if (year >= 2018) return '狗年';
    if (year >= 2017) return '鸡年';
    if (year >= 2016) return '猴年';
    if (year >= 2015) return '羊年';
    return '其他';
  }

  // 根据年份获取重要事件列表
  List<Map<String, String>> _getEvents(int year) {
    // 模拟数据，实际应用中应从API获取
    final events = <Map<String, String>>[];

    if (year == 2024) {
      events.add({
        'date': '2024年1月10日',
        'title': '龙年大运开启',
        'description': '甲辰年伊始，太岁星君值守东方，带来生机与活力，适合开启新的事业与计划。',
      });
      events.add({
        'date': '2024年5月5日',
        'title': '五月初五端午节',
        'description': '端午节期间，阳气上升，龙舟竞渡，以【${widget.hexagramText}】卦象能量助运，更显威猛。',
      });
      events.add({
        'date': '2024年5月6日',
        'title': '五月初五端午节',
        'description': '端午节期间，阳气上升，龙舟竞渡，以【${widget.hexagramText}】卦象能量助运，更显威猛。',
      });
    } else if (year == 2023) {
      events.add({
        'date': '2023年1月22日',
        'title': '兔年新岁始',
        'description': '癸卯年开始，守卦【${widget.hexagramText}】，温和柔顺，适合沉稳发展，循序渐进。',
      });
      events.add({
        'date': '2023年8月15日',
        'title': '中秋月满',
        'description': '月至中秋分外明，卦象变化，家庭团圆之时，宜思考人生方向。',
      });
    } else {
      // 添加默认事件
      events.add({
        'date': '$year年正月初一',
        'title': '新年伊始',
        'description': '新的一年开始，卦象【${widget.hexagramText}】主导运势，宜顺势而为，静待时机。',
      });
    }

    return events;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final events = _getEvents(_selectedYear);

    return Scaffold(
      appBar: AppBar(
        title: const Text('年卦事件'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 横向年份选择
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withAlpha(12),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              controller: _yearScrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _years.length,
              itemBuilder: (context, index) {
                final year = _years[index];
                final isSelected = year == _selectedYear;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedYear = year;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          year.toString(),
                          style: TextStyle(
                            fontSize: isSelected ? 24 : 18,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getEraName(year),
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? colorScheme.primary.withOpacity(0.8)
                                : colorScheme.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 24,
                            height: 3,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 内容区域（年卦解说卡片 + 时间轴）
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 年卦解说卡片
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  colorScheme.primary.withOpacity(0.2),
                              radius: 20,
                              child: Text(
                                _selectedYear
                                    .toString()
                                    .substring(2), // 显示年份后两位
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '$_selectedYear年 · ${_getEraName(_selectedYear)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '此年卦象【${widget.hexagramText}】',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '在$_selectedYear年，【${widget.hexagramText}】卦象主导全年运势。此卦象代表着"变通与创新"，意味着这一年将充满变化与机遇。适合尝试新事物，开拓新领域，但也需注意变化中的稳定性。\n\n'
                          '宜：创新、变通、开拓新领域\n'
                          '忌：因循守旧、冒进冒险',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: colorScheme.onSurface.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 重要时间点标题
                  Text(
                    '重要时间点',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 垂直时间轴
                  ...List.generate(events.length, (index) {
                    final event = events[index];
                    // 最后一个事件不显示连接线
                    final showConnector = index < events.length - 1;

                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 时间轴左侧部分（圆点和连接线）
                          Column(
                            children: [
                              // 上半部分连接线（仅对非第一个事件显示）
                              if (index > 0)
                                Container(
                                  width: 2,
                                  height: 16, // 上方连接线高度
                                  color: colorScheme.outlineVariant,
                                ),
                              // 圆点
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorScheme.primary,
                                  border: Border.all(
                                    color: colorScheme.surface,
                                    width: 2,
                                  ),
                                ),
                              ),
                              // 下半部分连接线（仅对非最后一个事件显示）
                              if (showConnector)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: colorScheme.outlineVariant,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // 事件卡片
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: showConnector ? 16 : 0,
                                top: index > 0 ? 12 : 0,
                              ),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.shadow.withOpacity(0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 日期
                                  Text(
                                    event['date'] ?? '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // 标题
                                  Text(
                                    event['title'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // 描述
                                  Text(
                                    event['description'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

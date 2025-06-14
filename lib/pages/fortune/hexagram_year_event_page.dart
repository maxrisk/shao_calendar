import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';
import '../../services/hexagram_service.dart';
import '../../models/year_event.dart';

/// 年卦事件页面
class HexagramYearEventPage extends StatefulWidget {
  /// 创建年卦事件页面
  const HexagramYearEventPage({
    super.key,
    required this.initialYear,
    required this.hexagramText,
    required this.bgType,
    required this.tenYearId,
  });

  /// 初始选中年份
  final int initialYear;

  /// 卦象文字
  final String hexagramText;

  /// 背景类型
  final HexagramBgType bgType;

  /// 十年卦ID
  final int tenYearId;

  @override
  State<HexagramYearEventPage> createState() => _HexagramYearEventPageState();
}

class _HexagramYearEventPageState extends State<HexagramYearEventPage> {
  late int _selectedYearIndex;
  late final ScrollController _yearScrollController;
  final _hexagramService = HexagramService();
  List<YearEvent>? _events;
  List<YearDivination>? _divinations;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedYearIndex = 0;
    _yearScrollController = ScrollController();

    // 在下一帧加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 先加载数据，不立即滚动
      _loadYearData();
    });
  }

  @override
  void dispose() {
    _yearScrollController.dispose();
    super.dispose();
  }

  // 加载年卦数据
  Future<void> _loadYearData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 先获取年卦解说
      final divinations =
          await _hexagramService.getYearDivinations(widget.tenYearId);

      if (mounted && divinations.isNotEmpty) {
        setState(() {
          _divinations = divinations;
        });

        // 确保_selectedYearIndex不超过数组范围
        if (_selectedYearIndex >= divinations.length) {
          _selectedYearIndex = 0;
        }

        // 使用当前选中的divination.name作为参数
        final selectedDivination = divinations[_selectedYearIndex];
        final events =
            await _hexagramService.getYearEvents(selectedDivination.year);

        if (mounted) {
          setState(() {
            _events = events;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _divinations = [];
            _events = [];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('加载年卦数据失败: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 只加载当前选中年份的事件数据
  Future<void> _loadYearEvents() async {
    if (_divinations == null ||
        _divinations!.isEmpty ||
        _selectedYearIndex >= _divinations!.length) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 使用当前选中的divination的year作为参数
      final selectedDivination = _divinations![_selectedYearIndex];
      final events =
          await _hexagramService.getYearEvents(selectedDivination.year);

      if (mounted) {
        setState(() {
          _events = events;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('加载年卦事件失败: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
            child: _divinations == null || _divinations!.isEmpty
                ? const Center(child: Text('暂无年卦数据'))
                : ListView.builder(
                    controller: _yearScrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _divinations?.length ?? 0,
                    itemBuilder: (context, index) {
                      final YearDivination divination = _divinations![index];
                      final isSelected = index == _selectedYearIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedYearIndex = index;
                          });
                          // 重新请求该年份的所有数据
                          _loadYearData();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                divination.year.toString(),
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
                                '${divination.name}年',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected
                                      ? colorScheme.primary.withAlpha(204)
                                      : colorScheme.onSurfaceVariant
                                          .withAlpha(178),
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _divinations == null || _divinations!.isEmpty
                    ? const Center(child: Text('暂无年卦数据'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 年卦解说卡片
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withAlpha(25),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: colorScheme.primary.withAlpha(50),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   '此年卦象【${widget.hexagramText}】',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: colorScheme.onSurface,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 8),

                                  Text(
                                    _divinations != null &&
                                            _divinations!.isNotEmpty &&
                                            _selectedYearIndex <
                                                _divinations!.length
                                        ? (_divinations![_selectedYearIndex]
                                                .guide ??
                                            '暂无解说')
                                        : '暂无解说',
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.6,
                                      color: colorScheme.onSurface
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 重要时间点标题
                            if (_events != null && _events!.isNotEmpty)
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
                            if (_events != null && _events!.isNotEmpty)
                              ...List.generate(_events!.length, (index) {
                                final event = _events![index];
                                // 最后一个事件不显示连接线
                                final showConnector =
                                    index < _events!.length - 1;

                                return IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4),
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
                                                color:
                                                    colorScheme.outlineVariant,
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
                                            color: theme.cardColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorScheme.shadow
                                                    .withAlpha(25),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // 日期
                                              Text(
                                                event.time,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              // 标题
                                              Text(
                                                event.title,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: colorScheme.primary,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              // 描述
                                              Text(
                                                event.content,
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

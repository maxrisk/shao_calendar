import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';
import 'widgets/hexagram_info_card.dart';
import 'hexagram_year_event_page.dart';
import '../../services/hexagram_service.dart';
import '../../models/ten_year.dart';

/// 十年旬选择页面
class HexagramDecadePage extends StatefulWidget {
  /// 创建十年旬选择页面
  const HexagramDecadePage({
    super.key,
    required this.baseYearId,
  });

  /// 60年卦象ID
  final int baseYearId;

  @override
  State<HexagramDecadePage> createState() => _HexagramDecadePageState();
}

class _HexagramDecadePageState extends State<HexagramDecadePage> {
  final _hexagramService = HexagramService();
  bool _isLoading = false;
  List<TenYear>? _tenYears;

  @override
  void initState() {
    super.initState();
    _loadTenYearData();
  }

  /// 加载10年卦象数据
  Future<void> _loadTenYearData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _hexagramService.getTenYear(widget.baseYearId);
      if (mounted) {
        setState(() {
          _tenYears = response?.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('获取10年卦象数据失败: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('十年旬选择'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _tenYears == null
                ? Center(
                    child: Text(
                      '暂无数据',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                  )
                : ListView(
                    children: [
                      // 十年旬说明
                      Text(
                        '十年旬选择',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '每个六十年世又分为六个十年旬，每个十年旬都有其独特的卦象能量。请选择与您命运相关的十年旬，以获取更准确的卦象解读。',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 十年旬列表
                      for (var tenYear in _tenYears!) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: HexagramInfoCard(
                            text: tenYear.divinationName ??
                                tenYear.name ??
                                '未知卦象',
                            bgType: HexagramBgType.orange,
                            yearRange:
                                '${tenYear.startYear}-${tenYear.endYear}',
                            guide:
                                tenYear.guide ?? tenYear.description ?? '暂无描述',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HexagramYearEventPage(
                                    initialYear: tenYear.startYear,
                                    hexagramText: tenYear.divinationName ??
                                        tenYear.name ??
                                        '未知卦象',
                                    bgType: HexagramBgType.green,
                                    tenYearId: tenYear.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
      ),
    );
  }
}

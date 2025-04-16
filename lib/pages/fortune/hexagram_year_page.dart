import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';
import 'widgets/hexagram_info_card.dart';
import 'hexagram_decade_page.dart';
import 'hexagram_year_event_page.dart';
import '../../services/hexagram_service.dart';
import '../../models/base_year.dart';

/// 六十年世选择页面
class HexagramYearPage extends StatefulWidget {
  /// 创建六十年世选择页面
  const HexagramYearPage({
    super.key,
    required this.text,
    required this.bgType,
    required this.yearRange,
  });

  /// 卦象文字
  final String text;

  /// 背景类型
  final HexagramBgType bgType;

  /// 年份范围
  final String yearRange;

  @override
  State<HexagramYearPage> createState() => _HexagramYearPageState();
}

class _HexagramYearPageState extends State<HexagramYearPage> {
  final _hexagramService = HexagramService();
  bool _isLoading = false;
  List<BaseYear>? _baseYears;

  @override
  void initState() {
    super.initState();
    _loadBaseYearData();
  }

  /// 加载60年卦象数据
  Future<void> _loadBaseYearData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _hexagramService.getBaseYear();
      print('60年卦象响应数据--------: $response');
      if (response?.data != null) {
        setState(() {
          _baseYears = response!.data;
        });
      }
    } catch (e) {
      print('获取60年卦象数据失败: $e');
    } finally {
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

    print('60年卦象数据: $_baseYears');

    return Scaffold(
      appBar: AppBar(
        title: const Text('六十年世选择'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _baseYears == null
              ? Center(
                  child: Text(
                    '暂无数据',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // 年份选择说明
                    Text(
                      '年份选择',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '在六十甲子周期中，每个年份都对应特定卦象能量。请选择与您命运相关的年份，以获取更准确的卦象解读。',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 卦象列表
                    ..._baseYears!.map((baseYear) {
                      final yearRange =
                          '${baseYear.startYear}-${baseYear.endYear}';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: HexagramInfoCard(
                          text: baseYear.divinationName ?? '',
                          bgType: widget.bgType,
                          yearRange: yearRange,
                          guide: baseYear.guide ?? '',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HexagramDecadePage(
                                  baseYearId: baseYear.id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';
import 'widgets/hexagram_info_card.dart';
import 'hexagram_decade_page.dart';
import '../../services/hexagram_service.dart';
import '../../models/base_year.dart';

/// 六十年世选择页面
class HexagramYearPage extends StatefulWidget {
  /// 创建六十年世选择页面
  const HexagramYearPage({
    super.key,
    required this.text,
    required this.yearRange,
  });

  /// 卦象文字
  final String text;

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
                    // 卦象列表
                    ..._baseYears!.map((baseYear) {
                      final yearRange =
                          '${baseYear.startYear}-${baseYear.endYear}';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: HexagramInfoCard(
                          text: baseYear.divinationName ?? '',
                          bgType: HexagramBgType.orange,
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

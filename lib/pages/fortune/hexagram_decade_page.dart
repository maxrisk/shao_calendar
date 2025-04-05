import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';
import 'widgets/hexagram_info_card.dart';
import 'hexagram_year_event_page.dart';

/// 十年旬选择页面
class HexagramDecadePage extends StatelessWidget {
  /// 创建十年旬选择页面
  const HexagramDecadePage({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 卦象信息卡片
            HexagramInfoCard(
              text: text,
              bgType: bgType,
              yearRange: yearRange,
              onTap: () {
                // 点击卡片跳转到年卦事件页面，默认选择当前年份
                final currentYear = DateTime.now().year;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HexagramYearEventPage(
                      initialYear: currentYear,
                      hexagramText: text,
                      bgType: bgType,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

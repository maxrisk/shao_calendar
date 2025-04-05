import 'package:flutter/material.dart';
import '../../widgets/glowing_hexagram.dart';
import 'widgets/hexagram_info_card.dart';
import 'hexagram_decade_page.dart';

/// 六十年世选择页面
class HexagramYearPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 卦象信息卡片 - 使用onTap属性
            HexagramInfoCard(
              text: text,
              bgType: bgType,
              yearRange: yearRange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HexagramDecadePage(
                      text: text,
                      bgType: bgType,
                      yearRange: yearRange,
                    ),
                  ),
                );
              },
            ),

            // 这里可以添加年份选择的UI组件
            // 例如一个GridView显示年份列表
          ],
        ),
      ),
    );
  }
}

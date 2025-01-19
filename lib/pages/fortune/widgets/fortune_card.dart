import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';
import '../../../models/fortune.dart';

/// 运势卡片组件
class FortuneCard extends StatelessWidget {
  /// 创建运势卡片组件
  const FortuneCard({
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
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlowingHexagram(
            text: text,
            size: 50,
            enableAnimation: false,
            bgType: bgType,
          ),
          Text(
            yearRange,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/// 运势卡片组
class FortuneCardGroup extends StatelessWidget {
  /// 创建运势卡片组
  const FortuneCardGroup({super.key, this.fortuneData});

  /// 个人运势数据
  final FortuneData? fortuneData;

  @override
  Widget build(BuildContext context) {
    if (fortuneData == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: FortuneCard(
              text: fortuneData!.baseName,
              bgType: HexagramBgType.green,
              yearRange: fortuneData!.decadeYears,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FortuneCard(
              text: fortuneData!.decadeName,
              bgType: HexagramBgType.orange,
              yearRange: fortuneData!.decadeYears,
            ),
          ),
        ],
      ),
    );
  }
}

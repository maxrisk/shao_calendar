import 'package:flutter/material.dart';
import 'package:flutter_calendar/widgets/glowing_hexagram.dart';
import '../models/fortune.dart';
import 'fortune_card.dart';

/// 运势卡片组 - 提取为公共组件
class FortuneCardGroup extends StatelessWidget {
  /// 创建运势卡片组
  const FortuneCardGroup({super.key, this.fortuneData, this.onCardTap});

  /// 个人运势数据
  final FortuneData? fortuneData;

  /// 卡片点击回调
  final Function(String cardType)? onCardTap;

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
            child: GestureDetector(
              onTap: () => onCardTap?.call('base'),
              child: FortuneCard(
                text: fortuneData!.baseName,
                bgType: HexagramBgType.green,
                yearRange: fortuneData!.decadeYears,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => onCardTap?.call('decade'),
              child: FortuneCard(
                text: fortuneData!.decadeName,
                bgType: HexagramBgType.orange,
                yearRange: fortuneData!.decadeYears,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

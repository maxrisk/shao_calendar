import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 运势卡片组件
class FortuneCard extends StatelessWidget {
  /// 创建运势卡片组件
  const FortuneCard({
    super.key,
    required this.text,
    required this.bgType,
    this.yearRange = '1984-2043',
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
  const FortuneCardGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: const [
          Expanded(
            child: FortuneCard(
              text: '乾',
              bgType: HexagramBgType.green,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: FortuneCard(
              text: '坤',
              bgType: HexagramBgType.orange,
            ),
          ),
        ],
      ),
    );
  }
}

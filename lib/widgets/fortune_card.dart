import 'package:flutter/material.dart';
import 'glowing_hexagram.dart';

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
      height: 95,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
          image: AssetImage('assets/images/fortune_card_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlowingHexagram(
            text: text,
            size: 56,
            enableAnimation: false,
            bgType: bgType,
          ),
          Transform.translate(
            offset: const Offset(0, -5),
            child: Text(
              yearRange,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

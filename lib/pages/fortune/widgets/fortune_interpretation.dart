import 'package:flutter/material.dart';
import '../../../widgets/info_card.dart';
import '../../../widgets/label.dart';
import '../../../widgets/yao_selector.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 运势解读组件
class FortuneInterpretation extends StatefulWidget {
  /// 创建运势解读组件
  const FortuneInterpretation({super.key});

  @override
  State<FortuneInterpretation> createState() => _FortuneInterpretationState();
}

class _FortuneInterpretationState extends State<FortuneInterpretation> {
  int _selectedYao = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Label(text: '运势解读'),
          const SizedBox(height: 5),
          // 爻选择器
          YaoSelector(
            selectedIndex: _selectedYao,
            onSelected: (index) {
              setState(() {
                _selectedYao = index;
              });
            },
          ),
          // 解读内容
          InfoCardGroup(
            cards: const [
              InfoCard(
                title: '爻辞',
                content: '潜龙勿用',
              ),
              InfoCard(
                title: '卦辞',
                content: '勿用取女',
              ),
            ],
          ),
          const Label(text: '批文'),
          const SizedBox(height: 5),
          // 使用 SizedBox.expand 或 Row 包裹全宽卡片
          Row(
            children: const [
              Expanded(
                child: InfoCard(
                  content: '运势平平，宜静不宜动',
                  centered: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Label(text: '应对策略'),
          Row(
            children: const [
              Expanded(
                child: InfoCard(
                  content: '运势平平，宜静不宜动',
                  centered: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Label(text: '总评'),
          const SizedBox(height: 5),
          // 底部卦象卡片
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/hexagram_bg.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: const [
                GlowingHexagram(
                  text: '坤',
                  enableAnimation: false,
                  bgType: HexagramBgType.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

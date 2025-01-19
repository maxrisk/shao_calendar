import 'package:flutter/material.dart';
import '../../../widgets/info_card.dart';
import '../../../widgets/label.dart';
import '../../../widgets/yao_selector.dart';
import '../../../widgets/glowing_hexagram.dart';
import '../../../models/fortune.dart';

/// 运势解读组件
class FortuneInterpretation extends StatefulWidget {
  /// 创建运势解读组件
  const FortuneInterpretation({super.key, this.yaos});

  /// 卦象
  final List<Yao>? yaos;

  @override
  State<FortuneInterpretation> createState() => _FortuneInterpretationState();
}

class _FortuneInterpretationState extends State<FortuneInterpretation> {
  int _selectedYao = 0;

  @override
  Widget build(BuildContext context) {
    Yao? yao = widget.yaos != null && _selectedYao < (widget.yaos?.length ?? 0)
        ? widget.yaos![_selectedYao]
        : null;

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
            cards: [
              InfoCard(
                content: '时效: ${yao?.times ?? ''}',
                centered: true,
              ),
              InfoCard(
                content: yao?.words,
                centered: true,
              ),
            ],
          ),
          const Label(text: '批文'),
          const SizedBox(height: 5),
          // 使用 SizedBox.expand 或 Row 包裹全宽卡片
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  content: yao?.changeWords,
                  centered: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Label(text: '应对策略'),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  content: yao?.changeInterpret,
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
              children: [
                GlowingHexagram(
                  text: yao?.change ?? '付费解锁',
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

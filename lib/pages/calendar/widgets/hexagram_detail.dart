import 'package:flutter/material.dart';
import '../../../models/fortune.dart';
import '../../../widgets/yao_selector.dart';
import '../../../widgets/info_card.dart';
import '../../../widgets/label.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 卦象详情组件
class HexagramDetail extends StatefulWidget {
  /// 创建卦象详情组件
  const HexagramDetail({
    super.key,
    required this.yaos,
  });

  /// 爻列表
  final List<Yao>? yaos;

  @override
  State<HexagramDetail> createState() => _HexagramDetailState();
}

class _HexagramDetailState extends State<HexagramDetail> {
  int _selectedYao = 0;

  @override
  Widget build(BuildContext context) {
    Yao? yao = widget.yaos != null && _selectedYao < (widget.yaos?.length ?? 0)
        ? widget.yaos![_selectedYao]
        : null;

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 爻位选择器
          YaoSelector(
            selectedIndex: _selectedYao,
            onSelected: (index) {
              setState(() {
                _selectedYao = index;
              });
            },
          ),
          // 两个卡片
          InfoCardGroup(
            cards: [
              InfoCard(
                content: '时效：${yao?.times ?? ''}',
                centered: true,
              ),
              InfoCard(
                content: yao?.change != null ? '${yao!.change}卦' : null,
                centered: true,
              ),
            ],
          ),
          // 标签
          const Label(text: '《易经》运势'),
          InfoCardGroup(
            cards: [
              InfoCard(
                content: yao?.words,
                centered: true,
              ),
              InfoCard(
                content: yao?.changeWords,
              ),
            ],
          ),
          const Label(text: '解读'),
          InfoCardGroup(
            cards: [
              InfoCard(
                content: yao?.interpret,
              ),
              InfoCard(
                content: yao?.changeInterpret,
              ),
            ],
          ),
          const Label(text: '总评'),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5, bottom: 5),
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
                  text: yao?.determine ?? '付费解锁',
                  bgType: yao?.determine.contains('凶') ?? false
                      ? HexagramBgType.orange
                      : HexagramBgType.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

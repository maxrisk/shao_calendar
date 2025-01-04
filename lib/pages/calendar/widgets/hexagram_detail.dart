import 'package:flutter/material.dart';
import '../../../widgets/yao_selector.dart';
import '../../../widgets/info_card.dart';
import '../../../widgets/label.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 卦象详情组件
class HexagramDetail extends StatefulWidget {
  /// 创建卦象详情组件
  const HexagramDetail({
    super.key,
    required this.timeRange,
    required this.hexagramName,
    required this.mainText,
    required this.secondaryText,
    required this.interpretation,
    required this.score,
  });

  /// 时间范围
  final String timeRange;

  /// 卦名
  final String hexagramName;

  /// 主要文本
  final String mainText;

  /// 次要文本
  final String secondaryText;

  /// 解释
  final String interpretation;

  /// 分数
  final int score;

  @override
  State<HexagramDetail> createState() => _HexagramDetailState();
}

class _HexagramDetailState extends State<HexagramDetail> {
  int _selectedYao = 0;

  @override
  Widget build(BuildContext context) {
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
            cards: const [
              InfoCard(
                title: '阳爻',
                content: '君子道长，小人道消。事业上机遇与挑战并存，保持谨慎乐观的态度。',
              ),
              InfoCard(
                title: '变爻',
                content: '运势渐入佳境，贵人相助。投资理财宜稳健为主，避免冒进。',
              ),
            ],
          ),
          // 标签
          Label(text: '《易经》运势'),
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
          Label(text: '解读'),
          InfoCardGroup(
            cards: const [
              InfoCard(
                content: '潜藏而无法施展，\n比喻君子压抑于下层，\n不能有所作为。',
                centered: true,
              ),
              InfoCard(
                content: '勿用取女',
                centered: true,
              ),
            ],
          ),
          Label(text: '总评'),
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

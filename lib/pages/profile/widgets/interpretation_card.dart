import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 解读类型
enum InterpretationType {
  /// 天时
  tianShi(label: '天时', color: Color(0xFFD59E00)),

  /// 地势
  diShi(label: '地势', color: Color(0xFFFEA85C)),

  /// 生历
  shengLi(label: '生历', color: Color(0xFF40A922)),

  /// 死结
  siJie(label: '死结', color: Color(0xFF91DBD7));

  /// 创建解读类型
  const InterpretationType({
    required this.label,
    required this.color,
  });

  /// 标签文本
  final String label;

  /// 标签颜色
  final Color color;
}

/// 解读卡片组件
class InterpretationCard extends StatelessWidget {
  /// 创建解读卡片组件
  const InterpretationCard({
    super.key,
    required this.title,
    required this.type,
    required this.hexagramText,
    required this.hexagramType,
    required this.guaCi,
    required this.xiangZhuan,
    required this.tuanZhuan,
    this.onPressed,
  });

  /// 标题
  final String title;

  /// 解读类型
  final InterpretationType type;

  /// 卦象文字
  final String hexagramText;

  /// 卦象类型
  final HexagramBgType hexagramType;

  /// 卦辞
  final String guaCi;

  /// 象传
  final String xiangZhuan;

  /// 彖传
  final String tuanZhuan;

  /// 按钮点击回调
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部标题区域
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 0, 14),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outlineVariant.withAlpha(100),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: type.color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      type.label,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 内容区域
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左侧卦象
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.3),
                      ),
                    ),
                    child: GlowingHexagram(
                      text: hexagramText,
                      size: 76,
                      enableAnimation: false,
                      bgType: hexagramType,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 右侧解读
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInterpretationItem('卦辞', guaCi),
                        const SizedBox(height: 14),
                        _buildInterpretationItem('象传', xiangZhuan),
                        const SizedBox(height: 14),
                        _buildInterpretationItem('彖传', tuanZhuan),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 底部按钮
            if (onPressed != null)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: colorScheme.primary.withOpacity(0.12),
                      ),
                    ),
                    backgroundColor: colorScheme.primary.withOpacity(0.08),
                    foregroundColor: colorScheme.primary,
                  ),
                  child: const Text(
                    '邵氏生历解读',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterpretationItem(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 42,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}

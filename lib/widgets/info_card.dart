import 'package:flutter/material.dart';

/// 信息卡片组件
class InfoCard extends StatelessWidget {
  /// 创建信息卡片组件
  const InfoCard({
    super.key,
    required this.content,
    this.title,
    this.centered = false,
  });

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  /// 是否居中显示
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: content != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: centered ? TextAlign.center : TextAlign.start,
                  text: TextSpan(
                    children: [
                      if (title != null)
                        TextSpan(
                          text: '$title：',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      TextSpan(
                        text: content!,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '付费解锁',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  '?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
    );
  }
}

/// 信息卡片组
class InfoCardGroup extends StatelessWidget {
  /// 创建信息卡片组
  const InfoCardGroup({
    super.key,
    required this.cards,
    this.spacing = 5.0,
  });

  /// 卡片列表
  final List<InfoCard> cards;

  /// 卡片间距
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            cards.length * 2 - 1,
            (index) {
              if (index.isOdd) {
                return SizedBox(width: spacing);
              }
              return Expanded(child: cards[index ~/ 2]);
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';
import '../../../models/divination.dart';

/// 卦象展示组件
class HexagramDisplay extends StatelessWidget {
  /// 创建卦象展示组件
  const HexagramDisplay({
    super.key,
    required this.date,
    required this.divination,
    this.isLoading = false,
  });

  /// 日期
  final DateTime date;

  /// 卦象
  final Divination? divination;

  /// 是否加载中
  final bool isLoading;

  double calcWidth(BuildContext context, int width) {
    return MediaQuery.of(context).size.width * width / 375;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: calcWidth(context, 197),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12.0),
            image: const DecorationImage(
              image: AssetImage('assets/images/hexagram_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 顶部标题栏
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '今日卦象',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset(
                    'assets/images/signet.png',
                    width: calcWidth(context, 22),
                    height: calcWidth(context, 22),
                  ),
                ],
              ),
              // 中间卦象
              GlowingHexagram(
                text: divination?.name ?? '付费解锁',
                size: calcWidth(context, 80),
              ),
              // 底部描述
              Text(
                divination?.baziInterpretation ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (isLoading)
          Positioned(
            top: 0,
            left: 16.0,
            right: 16.0,
            height: calcWidth(context, 197),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(76),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

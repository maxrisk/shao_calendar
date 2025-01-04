import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';

/// 运势展示卡片组件
class FortuneDisplay extends StatefulWidget {
  /// 创建运势展示卡片组件
  const FortuneDisplay({
    super.key,
    required this.date,
    this.onPrevious,
    this.onNext,
  });

  /// 日期
  final DateTime date;

  /// 上一个回调
  final VoidCallback? onPrevious;

  /// 下一个回调
  final VoidCallback? onNext;

  @override
  State<FortuneDisplay> createState() => _FortuneDisplayState();
}

class _FortuneDisplayState extends State<FortuneDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isForward = true;

  double calcWidth(BuildContext context, int width) {
    return MediaQuery.of(context).size.width * width / 375;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPrevious() {
    if (_controller.isAnimating) return;
    setState(() => _isForward = false);
    _controller.forward().then((_) {
      widget.onPrevious?.call();
      _controller.reset();
    });
  }

  void _onNext() {
    if (_controller.isAnimating) return;
    setState(() => _isForward = true);
    _controller.forward().then((_) {
      widget.onNext?.call();
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: calcWidth(context, 197),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 顶部标题栏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '个人运势',
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
          // 中间内容区域
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _onPrevious,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: calcWidth(context, 18),
                ),
              ),
              Stack(
                children: [
                  // 当前卦象
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0),
                      end: Offset(_isForward ? -1.5 : 1.5, 0),
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeInOut,
                    )),
                    child: FadeTransition(
                      opacity: Tween<double>(
                        begin: 1.0,
                        end: 0.0,
                      ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut,
                      )),
                      child: GlowingHexagram(
                        text: '坤',
                        size: calcWidth(context, 80),
                        bgType: HexagramBgType.purple,
                      ),
                    ),
                  ),
                  // 新卦象
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(_isForward ? 1.5 : -1.5, 0),
                      end: const Offset(0, 0),
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeInOut,
                    )),
                    child: FadeTransition(
                      opacity: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut,
                      )),
                      child: GlowingHexagram(
                        text: '乾',
                        size: calcWidth(context, 80),
                        bgType: HexagramBgType.purple,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _onNext,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: calcWidth(context, 18),
                ),
              ),
            ],
          ),
          // 底部描述
          const Text(
            '乾卦：元亨利贞',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// 卦象背景类型
enum HexagramBgType {
  /// 默认背景
  normal,

  /// 紫色背景
  purple,

  /// 橙色背景
  orange,

  /// 绿色背景
  green,
}

/// 发光卦象组件
class GlowingHexagram extends StatefulWidget {
  /// 创建发光卦象组件
  const GlowingHexagram({
    super.key,
    required this.text,
    this.size = 80,
    this.enableAnimation = true,
    this.bgType = HexagramBgType.normal,
  });

  /// 卦象文字
  final String text;

  /// 组件大小
  final double size;

  /// 是否启用动画
  final bool enableAnimation;

  /// 背景类型
  final HexagramBgType bgType;

  @override
  State<GlowingHexagram> createState() => _GlowingHexagramState();
}

class _GlowingHexagramState extends State<GlowingHexagram>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.enableAnimation) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = 0.8;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GlowingHexagram oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enableAnimation != oldWidget.enableAnimation) {
      if (widget.enableAnimation) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0.8;
      }
    }
  }

  String _getBackgroundImage() {
    switch (widget.bgType) {
      case HexagramBgType.normal:
        return 'assets/images/word_bg.png';
      case HexagramBgType.purple:
        return 'assets/images/word_bg2.png';
      case HexagramBgType.orange:
        return 'assets/images/word_bg3.png';
      case HexagramBgType.green:
        return 'assets/images/word_bg4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 外层光晕
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: widget.size * 1.25,
                height: widget.size * 1.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha(80),
                      blurRadius: 20 * _animation.value,
                      spreadRadius: 5 * _animation.value,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // 中层光晕
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value * 0.95,
              child: Container(
                width: widget.size * 1.125,
                height: widget.size * 1.125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha(100),
                      blurRadius: 15 * _animation.value,
                      spreadRadius: 2 * _animation.value,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // 主体球体和文字
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_getBackgroundImage()),
              fit: BoxFit.contain,
            ),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.text.length > 2
                    ? widget.size * 0.17 // 四字时使用更小的字号
                    : widget.size * 0.375,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Colors.white,
                    blurRadius: 10,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

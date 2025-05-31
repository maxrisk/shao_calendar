import 'package:flutter/material.dart';
import '../../../widgets/glowing_hexagram.dart';
import '../../../models/divination.dart';

/// 运势展示卡片组件
class FortuneDisplay extends StatefulWidget {
  /// 创建运势展示卡片组件
  const FortuneDisplay({
    super.key,
    required this.date,
    this.onPrevious,
    this.onNext,
    this.divination,
    this.isLoading = false,
  });

  /// 日期
  final DateTime date;

  /// 上一个回调
  final VoidCallback? onPrevious;

  /// 下一个回调
  final VoidCallback? onNext;

  /// 卦象
  final Divination? divination;

  /// 是否加载中
  final bool isLoading;

  @override
  State<FortuneDisplay> createState() => _FortuneDisplayState();
}

class _FortuneDisplayState extends State<FortuneDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isForward = true;
  Divination? _currentDivination;
  Divination? _nextDivination;

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
    _currentDivination = widget.divination;
  }

  @override
  void didUpdateWidget(FortuneDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.divination != oldWidget.divination) {
      setState(() {
        _nextDivination = widget.divination;
      });
      _controller.forward().then((_) {
        setState(() {
          _currentDivination = _nextDivination;
        });
        _controller.reset();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPrevious() {
    if (_controller.isAnimating) return;
    setState(() {
      _isForward = false;
    });
    widget.onPrevious?.call();
  }

  void _onNext() {
    if (_controller.isAnimating) return;
    setState(() {
      _isForward = true;
    });
    widget.onNext?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                    '值年轨迹',
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
                    onPressed: widget.isLoading ? null : _onPrevious,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: widget.isLoading
                          ? Colors.white.withAlpha(128)
                          : Colors.white,
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
                            text: _currentDivination?.name ?? '付费解锁',
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
                            text: _nextDivination?.name ?? '付费解锁',
                            size: calcWidth(context, 80),
                            bgType: HexagramBgType.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: widget.isLoading ? null : _onNext,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: widget.isLoading
                          ? Colors.white.withAlpha(128)
                          : Colors.white,
                      size: calcWidth(context, 18),
                    ),
                  ),
                ],
              ),
              // 底部描述
              Text(
                _currentDivination?.baziInterpretation ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (widget.isLoading)
          Positioned(
            top: 16.0,
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

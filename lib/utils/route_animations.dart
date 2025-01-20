import 'package:flutter/material.dart';

/// 路由动画工具类
class RouteAnimations {
  /// 创建底部滑入路由
  static PageRouteBuilder<T> slideUp<T>({
    required Widget page,
    Duration duration = const Duration(milliseconds: 400),
    Color barrierColor = const Color(0x64000000),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          )),
          child: FadeTransition(
            opacity: animation,
            child: page,
          ),
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      fullscreenDialog: true,
      opaque: false,
      barrierColor: barrierColor,
    );
  }

  /// 创建淡入路由
  static PageRouteBuilder<T> fade<T>({
    required Widget page,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  /// 创建缩放路由
  static PageRouteBuilder<T> scale<T>({
    required Widget page,
    Duration duration = const Duration(milliseconds: 300),
    Offset? alignment,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          alignment: alignment?.asAlignment ?? Alignment.center,
          scale: animation,
          child: page,
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }
}

/// Offset 扩展
extension OffsetAlignment on Offset {
  Alignment get asAlignment => Alignment(dx * 2 - 1, dy * 2 - 1);
}

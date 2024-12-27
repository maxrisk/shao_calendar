import 'package:flutter/material.dart';

/// 应用主题配置
class AppTheme {
  /// 主色调
  static const Color primaryColor = Colors.deepPurple;

  /// 次要色调
  static const Color secondaryColor = Colors.amber;

  /// 背景色
  static const Color backgroundColor = Colors.white;

  /// 文本主色
  static const Color primaryTextColor = Colors.black87;

  /// 文本次要色
  static const Color secondaryTextColor = Colors.black54;

  /// 边框颜色
  static const Color borderColor = Colors.deepPurple;

  /// 获取主题数据
  static ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey[600],
      ),
    );
  }
}

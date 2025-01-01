import 'package:flutter/material.dart';

/// 应用主题配置
class AppTheme {
  /// 主色调
  static const Color primaryColor = Color(0xFF8D724B);

  /// 次要色调
  static const Color secondaryColor = Colors.indigo;

  /// 背景色
  static const Color backgroundColor = Color(0xFFF7F3E9);

  /// 文本主色
  static const Color primaryTextColor = Colors.black87;

  /// 文本次要色
  static const Color secondaryTextColor = Colors.black54;

  /// 边框颜色
  static const Color borderColor = Colors.indigo;

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
      scaffoldBackgroundColor: backgroundColor,
      cardColor: const Color(0xFFFEFCF7),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFFFEFCF7),
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey[600],
      ),
    );
  }
}

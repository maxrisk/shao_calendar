import 'package:flutter/material.dart';

/// 应用主题配置
class AppTheme {
  /// 主色调
  static const Color primaryColor = Color(0xFF936C42);

  /// 次要色调
  static const Color secondaryColor = Color(0xFFB38B5D);

  /// 浅色背景色
  static const Color lightBackgroundColor = Color(0xFFF7F3E9);

  /// 深色背景色
  static const Color darkBackgroundColor = Color(0xFF1C1917);

  /// 浅色卡片背景
  static const Color lightCardColor = Color(0xFFFEFCF7);

  /// 深色卡片背景
  static const Color darkCardColor = Color(0xFF282422);

  /// 深色模式强调色
  static const Color darkAccentColor = Color(0xFFD4A373);

  /// 获取主题数据
  static ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: lightBackgroundColor,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      scaffoldBackgroundColor: lightBackgroundColor,
      cardColor: lightCardColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightCardColor,
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey[600],
      ),
    );
  }

  /// 获取深色主题数据
  static ThemeData get darkThemeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: darkAccentColor,
        secondary: secondaryColor,
        surface: darkBackgroundColor,
        onSurface: Colors.grey[300],
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: darkCardColor,
        foregroundColor: darkAccentColor,
        centerTitle: false,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkCardColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkCardColor,
        selectedItemColor: darkAccentColor,
        unselectedItemColor: Colors.grey[600],
      ),
      textTheme: Typography.material2021().white.copyWith(
            bodyLarge: TextStyle(color: Colors.grey[300]),
            bodyMedium: TextStyle(color: Colors.grey[300]),
          ),
      iconTheme: IconThemeData(
        color: Colors.grey[300],
      ),
    );
  }
}

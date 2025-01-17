class AppConfig {
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';

  // API 配置
  static String get apiBaseUrl {
    // 从环境变量获取 API 地址，如果没有设置则使用默认值
    return const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'SET_YOUR_API_BASE_URL',
    );
  }

  // 生成构建号
  static int generateBuildNumber() {
    // 使用日期和时间作为构建号，格式：MMDDHHMM (8位数字)
    // 例如：01162147 = 1月16日21时47分
    // 避免使用年份，保证构建号不会太大
    final now = DateTime.now();
    final buildNumber =
        int.parse('${now.month.toString().padLeft(2, '0')}' // 月份，补齐两位
            '${now.day.toString().padLeft(2, '0')}' // 日期，补齐两位
            '${now.hour.toString().padLeft(2, '0')}' // 小时，补齐两位
            '${now.minute.toString().padLeft(2, '0')}' // 分钟，补齐两位
            );
    return buildNumber;
  }

  // 其他配置
  static Map<String, dynamic> get config {
    return {
          'production': {
            'appName': '日历',
            'logLevel': 'ERROR',
            'apiTimeout': const Duration(seconds: 10),
            'enableCache': true,
            'cacheMaxAge': const Duration(hours: 24),
          },
          'development': {
            'appName': '日历(测试版)',
            'logLevel': 'DEBUG',
            'apiTimeout': const Duration(seconds: 30),
            'enableCache': false,
            'cacheMaxAge': const Duration(minutes: 5),
          },
        }[environment] ??
        {};
  }
}

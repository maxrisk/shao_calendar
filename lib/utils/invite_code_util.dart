/// 邀请码工具类
/// 提供邀请码相关的处理方法
class InviteCodeUtil {
  /// 提取邀请码的静态方法
  static String? extractInviteCode(String url) {
    try {
      // 解析URL中的邀请码
      final uri = Uri.parse(url);

      // 检查是否来自我们的应用域名
      final validHosts = [
        'app.sssltc.com', // 正式环境
        'dev-app.sssltc.com', // 开发环境
        'test-app.sssltc.com', // 测试环境
        'localhost', // 本地开发
      ];

      // 如果是有效域名，从查询参数中获取code
      if (validHosts.contains(uri.host)) {
        return uri.queryParameters['code'];
      }

      // 如果是我们自定义的URI方案，如sssltc://invite?code=xxx
      if (uri.scheme == 'sssltc' && uri.path.contains('invite')) {
        return uri.queryParameters['code'];
      }

      // 如果不是有效的URL，则判断整个字符串是否可能是邀请码本身
      if (url.length < 20 && RegExp(r'^\d+$').hasMatch(url)) {
        return url;
      }

      return null;
    } catch (e) {
      // 如果URL解析失败，检查是否整个字符串就是邀请码
      if (url.length < 20 && RegExp(r'^\d+$').hasMatch(url)) {
        return url;
      }
      return null;
    }
  }

  /// 生成邀请链接
  static String generateInviteLink(String code, {bool isProduction = true}) {
    final host = isProduction ? 'app.sssltc.com' : 'dev-app.sssltc.com';
    return 'https://$host/invite?code=$code';
  }

  /// 验证邀请码是否有效
  static bool isValidInviteCode(String? code) {
    if (code == null || code.isEmpty) return false;

    // 邀请码应该是数字，且长度合理
    return RegExp(r'^\d+$').hasMatch(code) && code.length < 20;
  }
}

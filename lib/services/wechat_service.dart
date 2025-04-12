import 'package:dio/dio.dart';
import 'http_client.dart';

/// 微信登录结果
class WechatLoginResult {
  /// 创建微信登录结果
  WechatLoginResult({
    required this.success,
    required this.message,
    this.openid,
    this.unionid,
  });

  /// 是否成功
  final bool success;

  /// 提示消息
  final String message;

  /// 微信openid
  final String? openid;

  /// 微信unionid
  final String? unionid;
}

/// 微信服务
class WechatService {
  static final WechatService _instance = WechatService._internal();
  factory WechatService() => _instance;
  WechatService._internal();

  final _dio = HttpClient().dio;

  /// code换取openid
  Future<WechatLoginResult> codeToOpenid(String code) async {
    try {
      final response = await _dio.get('/app/codeToOpenid/$code');

      if (response.data['code'] == 0 && response.data['data'] != null) {
        final data = response.data['data'];
        return WechatLoginResult(
          success: true,
          message: response.data['msg'] ?? '获取成功',
          openid: data['openid'],
          unionid: data['unionid'],
        );
      }

      return WechatLoginResult(
        success: false,
        message: response.data['msg'] ?? '获取失败',
      );
    } catch (e) {
      print('code换取openid失败: $e');
      return WechatLoginResult(
        success: false,
        message: '网络异常，请稍后重试',
      );
    }
  }
}

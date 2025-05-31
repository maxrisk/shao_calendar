import 'http_client.dart';
import '../models/order.dart';
import 'package:fluwx/fluwx.dart';
import 'dart:async';

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

/// 微信支付服务
class WechatService {
  static final WechatService _instance = WechatService._internal();
  final Fluwx _fluwx = Fluwx();
  final _dio = HttpClient().dio;

  /// 是否已初始化
  static bool _isInitialized = false;

  factory WechatService() {
    return _instance;
  }

  WechatService._internal() {
    // 初始化时注册支付结果监听
    _fluwx.addSubscriber((resp) {
      print('收到微信回调: $resp');
      if (resp is WeChatPaymentResponse) {
        print('支付结果状态码: ${resp.errCode}');
        print('支付结果类型: ${resp.type}');
        _paymentController.add(resp);
      }
    });
  }

  final _paymentController =
      StreamController<WeChatPaymentResponse>.broadcast();

  /// 初始化微信SDK
  Future<bool> init() async {
    if (_isInitialized) {
      print('微信SDK已初始化，无需重复初始化');
      return true;
    }

    try {
      print('开始初始化微信SDK...');
      final result = await _fluwx.registerApi(
        appId: "wx94c3ff80fb2eb730",
        universalLink: "https://hjjs101110.com/app/",
        doOnIOS: true,
        doOnAndroid: true,
      );
      print('初始化微信SDK结果: $result');
      _isInitialized = result;
      return result;
    } catch (e, stackTrace) {
      print('初始化微信SDK失败: $e');
      print('初始化异常堆栈: $stackTrace');
      return false;
    }
  }

  /// 发起微信支付
  Future<bool> pay(WechatPayParams params) async {
    try {
      print('准备调用微信支付...');

      // 确保已初始化
      if (!_isInitialized) {
        print('微信SDK尚未初始化，尝试初始化...');
        final initResult = await init();
        if (!initResult) {
          print('微信SDK初始化失败，无法继续支付');
          return false;
        }
        print('微信SDK初始化成功');
      }

      // 检查微信是否安装
      final installed = await _fluwx.isWeChatInstalled;
      if (!installed) {
        return false;
      }

      int timestamp;
      try {
        timestamp = int.parse(params.timestamp);
      } catch (e) {
        return false;
      }

      final payResult = await _fluwx.pay(
        which: Payment(
          appId: params.appid,
          partnerId: params.partnerId, // 通常不需要
          prepayId: params.prepayId,
          packageValue: params.packageValue,
          nonceStr: params.noncestr,
          timestamp: timestamp,
          sign: params.sign,
        ),
      );

      print('微信支付调用结果: $payResult');
      return payResult;
    } catch (e, stackTrace) {
      print('微信支付异常: $e');
      print('异常堆栈: $stackTrace');
      return false;
    }
  }

  /// 监听支付结果
  Stream<WeChatPaymentResponse> get paymentResponseStream =>
      _paymentController.stream;

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

  /// 检查微信环境
  Future<bool> checkWechatEnvironment() async {
    try {
      print('检查微信环境...');
      final installed = await _fluwx.isWeChatInstalled;
      print('微信安装状态: $installed');
      return installed;
    } catch (e) {
      print('检查微信环境失败: $e');
      return false;
    }
  }

  /// 释放资源
  void dispose() {
    _paymentController.close();
  }
}

import 'package:flutter/material.dart';
import 'wechat_service.dart';
import 'user_service.dart';
import 'package:fluwx/fluwx.dart';
import '../pages/profile/bind_phone_page.dart';

/// 微信登录管理器
class WechatLoginManager {
  static final WechatLoginManager _instance = WechatLoginManager._internal();
  factory WechatLoginManager() => _instance;
  WechatLoginManager._internal();

  final _wechatService = WechatService();
  final _userService = UserService();

  /// 是否已初始化
  static bool _isInitialized = false;

  /// 初始化微信SDK
  static Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    try {
      Fluwx fluwx = Fluwx();
      final result = await fluwx.registerApi(
        appId: "wx94c3ff80fb2eb730",
        universalLink: "https://hjjs101110.com/app/",
      );
      print('初始化微信SDK结果: $result');
      _isInitialized = result;
    } catch (e) {
      print('初始化微信SDK失败: $e');
      rethrow;
    }
  }

  /// 发起微信登录
  static Future<void> login() async {
    try {
      await init();
      Fluwx fluwx = Fluwx();
      final result = await fluwx.authBy(
        which: NormalAuth(
          scope: 'snsapi_userinfo',
          state: 'wechat_sdk_demo_test',
        ),
      );
      print('微信授权结果: $result');
      if (!result) {
        throw Exception('微信授权失败');
      }
    } catch (e) {
      print('微信登录失败: $e');
      rethrow;
    }
  }

  /// 处理微信登录回调
  Future<bool> handleLoginResponse(String code, {BuildContext? context}) async {
    try {
      final result = await _wechatService.codeToOpenid(code);
      if (!result.success) {
        debugPrint('code换取openid失败: ${result.message}');
        return false;
      }
      print('code换取openid成功: ${result.openid}');

      // 调用后端登录接口，使用openid和unionid进行登录
      final loginResult = await _userService.login(
        openid: result.openid,
        unionid: result.unionid,
      );

      // 如果返回 4010，需要绑定手机号
      if (loginResult == null && context != null) {
        // 使用Future.microtask确保在新的帧中执行
        Future.microtask(() {
          // 跳转到绑定手机号页面
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BindPhonePage(
                openid: result.openid!,
                unionid: result.unionid,
              ),
            ),
          );
        });
        return true;
      }

      // 如果登录成功，返回首页
      if (loginResult != null && context != null) {
        // 使用Future.microtask确保在新的帧中执行
        Future.microtask(() {
          // 返回到首页
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }

      return loginResult != null;
    } catch (e) {
      debugPrint('处理微信登录回调异常: $e');
      return false;
    }
  }
}

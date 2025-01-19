import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_info_response.dart';
import 'http_client.dart';

class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  final Dio _dio = HttpClient().dio;
  late final SharedPreferences _prefs;
  UserInfoResponse? _userInfo;

  UserInfoResponse? get userInfo => _userInfo;

  bool get isVip => _userInfo?.userInfo.isVip ?? false;

  factory UserService() {
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 获取用户信息
  Future<UserInfoResponse?> getUserInfo() async {
    try {
      final response = await _dio.get('/app/user');
      if (response.data['code'] == 0 && response.data['data'] != null) {
        final data = response.data['data'];
        if (data['userInfo'] != null) {
          _userInfo = UserInfoResponse.fromJson(data);
          notifyListeners();
          return _userInfo;
        }
      }
      return null;
    } catch (e) {
      print('获取用户信息失败: $e');
      return null;
    }
  }

  // 用户登录或注册
  Future<UserInfoResponse?> login(String phone, String code,
      {String? openid, String? unionid}) async {
    try {
      final response = await _dio.post('/app/user', data: {
        'phone': phone,
        'code': code,
        if (openid != null) 'openid': openid,
        if (unionid != null) 'unionid': unionid,
      });

      print('response11: ${response.data}');
      if (response.data['code'] == 0) {
        // 保存token
        final token = response.data['data']['token'];
        print('token11: $token');
        if (token != null) {
          await _prefs.setString('token', token);
          // 获取用户信息
          return await getUserInfo();
        }
      }
      return null;
    } catch (e) {
      print('登录失败: $e');
      return null;
    }
  }

  // 获取验证码
  Future<bool> getVerificationCode(String phone) async {
    try {
      print('获取验证码: $phone');
      final response = await _dio.get('/app/verification/$phone');
      return response.data['code'] == 0;
    } catch (e) {
      print('获取验证码失败: $e');
      return false;
    }
  }

  // 修改昵称
  Future<bool> updateNickname(String nickname) async {
    try {
      final response = await _dio.put('/app/user/nickName/$nickname');
      if (response.data['code'] == 0) {
        await getUserInfo(); // 更新用户信息
        return true;
      }
      return false;
    } catch (e) {
      print('修改昵称失败: $e');
      return false;
    }
  }

  // 设置生日和时辰
  Future<bool> setBirthInfo(String birthDate, int birthTime,
      {String? code}) async {
    try {
      final response = await _dio.put(
        '/app/user/birthDate/$birthDate/$birthTime',
        queryParameters: code != null ? {'code': code} : null,
      );
      if (response.data['code'] == 0) {
        await getUserInfo(); // 更新用户信息
        return true;
      }
      return false;
    } catch (e) {
      print('设置生日信息失败: $e');
      return false;
    }
  }

  // 开启流年运势
  Future<bool> openFortune(String birthDate, int birthTime,
      {String? code}) async {
    try {
      final response = await _dio.put(
        '/app/user/birthDate/$birthDate/$birthTime',
        queryParameters: code != null ? {'code': code} : null,
      );
      print('response fortune: ${response.data}');
      if (response.data['code'] == 0) {
        final token = await _prefs.getString('token');
        if (token != null) {
          // 获取用户信息
          await getUserInfo();
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print('开启流年运势失败: $e');
      return false;
    }
  }

  // 获取token
  String? getToken() {
    return _prefs.getString('token');
  }

  // 清除token和用户信息
  Future<void> logout() async {
    await _prefs.remove('token');
    _userInfo = null;
    notifyListeners();
  }

  UserService._internal();
}

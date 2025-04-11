import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_info_response.dart';
import 'http_client.dart';
import 'fortune_service.dart';

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
      final response = await _dio.post(
        '/app/user',
        data: {
          'phone': phone,
          'code': code,
          if (openid != null) 'openid': openid,
          if (unionid != null) 'unionid': unionid,
        },
      );

      print('response11: ${response.data}');
      if (response.data['code'] == 0) {
        // 保存token
        final token = response.data['data']['token'];
        print('token11: $token');
        if (token != null) {
          await _prefs.setString('token', token);
          // 获取用户信息
          final userInfo = await getUserInfo();
          if (userInfo != null) {
            // 重新加载运势数据
            await FortuneService().reloadAllData();
            return userInfo;
          }
        }
      }
      return null;
    } catch (e) {
      print('登录失败: $e');
      return null;
    }
  }

  // 获取验证码
  Future<(bool, Map<String, dynamic>?, Map<String, dynamic>?)>
      getVerificationCode(String phone) async {
    try {
      print('获取验证码: $phone');
      final response = await _dio.get('/app/verification/$phone');
      if (response.data['code'] == 0 && response.data['data'] != null) {
        final data = response.data['data'];
        final provinces = data['provinces'] as Map<String, dynamic>?;
        final city = data['city'] as Map<String, dynamic>?;
        return (true, provinces, city);
      }
      return (false, null, null);
    } catch (e) {
      print('获取验证码失败: $e');
      return (false, null, null);
    }
  }

  // 修改昵称
  Future<bool> updateNickname(String nickname) async {
    try {
      final response = await _dio.put('/app/user/nickname', data: {
        'nickname': nickname,
      });
      if (response.data['code'] == 0) {
        await getUserInfo();
        return true;
      }
      return false;
    } catch (e) {
      print('更新昵称失败: $e');
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
  Future<(bool, String?)> openFortune(String birthDate, int birthTime,
      {String? code}) async {
    try {
      final response = await _dio.put(
        '/app/user/birthDate/$birthDate/$birthTime',
        queryParameters: code != null ? {'code': code} : null,
      );
      print('response fortune: ${response.data}');
      if (response.data['code'] == 0) {
        final token = _prefs.getString('token');
        if (token != null) {
          // 获取用户信息
          await getUserInfo();
          return (true, null);
        }
        return (false, '登录状态已失效');
      }
      final msg = response.data['msg'];
      return (false, msg is String ? msg : '开启流年运势失败');
    } on DioException catch (e) {
      print('开启流年运势失败: ${e.message}');
      return (false, e.message ?? '网络请求失败');
    } catch (e) {
      print('开启流年运势失败: $e');
      return (false, '开启流年运势失败');
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

  /// 获取修改支付密码的验证码
  Future<bool> getPayPasswordCode() async {
    try {
      final response = await _dio.get('/app/sendChangePassCode');
      return response.data['code'] == 0;
    } on DioException catch (e) {
      print('获取修改支付密码验证码失败: ${e.message}');
      return false;
    } catch (e) {
      print('获取修改支付密码验证码失败: $e');
      return false;
    }
  }

  /// 修改支付密码
  Future<bool> updatePayPassword({
    required String code,
    required String password,
  }) async {
    try {
      final response = await _dio.put(
        '/app/payPass/$password/$code',
      );
      return response.data['code'] == 0;
    } on DioException catch (e) {
      print('修改支付密码失败: ${e.message}');
      return false;
    } catch (e) {
      print('修改支付密码失败: $e');
      return false;
    }
  }

  /// 获取旧手机号验证码
  Future<bool> getOldPhoneCode() async {
    try {
      final response = await _dio.get('/app/oldPhoneCode');
      return response.data['code'] == 0;
    } on DioException catch (e) {
      print('获取旧手机号验证码失败: ${e.message}');
      return false;
    } catch (e) {
      print('获取旧手机号验证码失败: $e');
      return false;
    }
  }

  /// 获取新手机号验证码
  Future<bool> getNewPhoneCode(String phone, String oldPhoneCode) async {
    try {
      final response =
          await _dio.get('/app/changePhoneCheck/$phone/$oldPhoneCode');
      return response.data['code'] == 0;
    } on DioException catch (e) {
      print('获取新手机号验证码失败: ${e.message}');
      return false;
    } catch (e) {
      print('获取新手机号验证码失败: $e');
      return false;
    }
  }

  /// 更改手机号
  Future<(bool, String?)> updatePhone(String newPhone, String code) async {
    try {
      final response = await _dio.put('/app/updatePhone/$newPhone/$code');
      if (response.data['code'] == 0) {
        await getUserInfo(); // 更新用户信息
        return (true, null);
      }
      final msg = response.data['msg'];
      return (false, msg is String ? msg : '更改手机号失败');
    } on DioException catch (e) {
      print('更改手机号失败: ${e.message}');
      return (false, e.message ?? '网络请求失败');
    } catch (e) {
      print('更改手机号失败: $e');
      return (false, '更改手机号失败');
    }
  }

  /// 验证支付密码验证码
  Future<bool> validatePayCode(String code) async {
    try {
      final response = await _dio.get('/app/validPayCode/$code');
      return response.data['code'] == 0;
    } on DioException catch (e) {
      print('验证支付密码验证码失败: ${e.message}');
      return false;
    } catch (e) {
      print('验证支付密码验证码失败: $e');
      return false;
    }
  }

  /// 获取服务剩余天数
  int get remainingDays {
    if (userInfo?.userInfo.expirationTime == null) return 0;
    final expiration = DateTime.parse(userInfo!.userInfo.expirationTime!);
    final now = DateTime.now();
    final days = expiration.difference(now).inDays;
    return days < 0 ? 0 : days;
  }

  /// 更新用户地区信息
  Future<bool> updateArea({
    required int provinceId,
    required int cityId,
    int? districtId,
  }) async {
    try {
      final response = await _dio.put('/app/userArea', data: {
        'provinceId': provinceId,
        'cityId': cityId,
        if (districtId != null) 'districtId': districtId,
      });

      if (response.data['code'] == 0) {
        await getUserInfo(); // 更新用户信息
        return true;
      }
      return false;
    } catch (e) {
      print('更新地区信息失败: $e');
      return false;
    }
  }

  UserService._internal();
}

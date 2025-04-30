import 'package:shared_preferences/shared_preferences.dart';

/// 共享偏好设置工具类
class SharedPrefs {
  static SharedPreferences? _prefs;

  /// 偏好设置键名
  static const String _userAgreementAccepted = 'user_agreement_accepted';

  /// 初始化
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// 检查用户是否已同意用户协议和隐私政策
  static bool isUserAgreementAccepted() {
    return _prefs?.getBool(_userAgreementAccepted) ?? false;
  }

  /// 设置用户已同意用户协议和隐私政策
  static Future<bool> setUserAgreementAccepted(bool value) async {
    return await _prefs?.setBool(_userAgreementAccepted, value) ?? false;
  }
}

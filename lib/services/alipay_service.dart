import 'package:tobias/tobias.dart';

/// 支付宝支付服务
class AlipayService {
  static final AlipayService _instance = AlipayService._internal();

  factory AlipayService() {
    return _instance;
  }

  AlipayService._internal();

  Tobias tobias = Tobias();

  /// 调用支付宝支付
  ///
  /// [order] 支付字符串
  /// 返回支付结果，成功返回true，失败返回false
  Future<bool> pay(String order) async {
    try {
      // 检查支付宝是否安装
      final isInstalled = await tobias.isAliPayInstalled;
      if (!isInstalled) {
        print('未安装支付宝APP');
        return false;
      }

      // 调用支付宝支付
      final result = await tobias.pay(order);

      // 处理支付结果
      if (result['resultStatus'] == '9000') {
        print('支付成功');
        return true;
      } else {
        print('支付失败: ${result['memo']}');
        return false;
      }
    } catch (e) {
      print('支付异常: $e');
      return false;
    }
  }
}

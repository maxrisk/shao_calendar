import 'package:dio/dio.dart';
import 'http_client.dart';

/// 支付服务
class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  final Dio _dio = HttpClient().dio;

  factory PaymentService() {
    return _instance;
  }

  PaymentService._internal();

  /// 查询支付结果
  ///
  /// [params] 支付宝回跳的所有参数
  ///
  /// 返回验签结果，成功返回 true，失败返回 false
  Future<bool> verifyPayment({
    required Map<String, String> params,
  }) async {
    print('验签参数: $params');
    try {
      final response = await _dio.get(
        '/app/order/queryPay',
        queryParameters: params,
      );

      // 检查响应状态
      if (response.data['code'] == 0) {
        return true;
      }
      print('验签失败: ${response.data['msg']}');
      return false;
    } on DioException catch (e) {
      print('验签请求失败: ${e.message}');
      return false;
    } catch (e) {
      print('验签异常: $e');
      return false;
    }
  }
}

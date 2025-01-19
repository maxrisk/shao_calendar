import 'package:dio/dio.dart';
import 'http_client.dart';
import '../models/order.dart';

/// 支付类型
enum PayType {
  /// 支付宝
  alipay,

  /// 微信支付
  wechat,
}

/// 产品类型
enum ProductType {
  /// 普通365天
  normal(1),

  /// VIP 3650天
  vip(2);

  final int id;
  const ProductType(this.id);
}

/// 订单服务
class OrderService {
  static final OrderService _instance = OrderService._internal();
  final Dio _dio = HttpClient().dio;

  factory OrderService() {
    return _instance;
  }

  OrderService._internal();

  /// 创建订单
  Future<OrderResponse?> createOrder(
      PayType payType, ProductType productType) async {
    try {
      final response = await _dio.post(
        '/order/create/${payType.name.toUpperCase()}/${productType.id}',
      );
      return OrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('创建订单失败: ${e.message}');
      return null;
    }
  }
}

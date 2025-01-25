import 'package:dio/dio.dart';
import 'http_client.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/order_list.dart';

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

  /// 获取服务产品
  Future<Product?> getProduct() async {
    try {
      final response = await _dio.get('/order/product');
      final productResponse = ProductResponse.fromJson(response.data);
      return productResponse.data;
    } on DioException catch (e) {
      print('获取产品信息失败: ${e.message}');
      return null;
    } catch (e) {
      print('解析产品信息失败: $e');
      return null;
    }
  }

  /// 获取订单列表
  Future<List<OrderItem>?> getOrders() async {
    try {
      final response = await _dio.get('/order/list');
      final orderListResponse = OrderListResponse.fromJson(response.data);
      return orderListResponse.data;
    } on DioException catch (e) {
      print('获取订单列表失败: ${e.message}');
      return null;
    } catch (e) {
      print('解析订单列表失败: $e');
      return null;
    }
  }
}

import 'package:dio/dio.dart';
import 'http_client.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/order_list.dart';

/// 支付类型
enum PayType {
  /// 支付宝
  alipay('alipay'),

  /// 微信支付
  wechat('wechat'),

  /// 支付宝 H5
  alipayH5('alipay_h5'),

  /// 微信 H5
  wechatH5('wechat_h5');

  final String value;

  const PayType(this.value);
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
  ///
  /// [payType] 支付类型，支付宝或微信支付
  /// [productId] 产品ID
  ///
  /// 返回订单响应：
  /// - 支付宝支付：返回支付链接，通过 [OrderResponse.alipayUrl] 获取
  /// - 微信支付：返回支付参数，通过 [OrderResponse.wechatData] 获取
  Future<OrderResponse?> createOrder(PayType payType, int productId) async {
    try {
      final response = await _dio.post(
        '/app/order/create/${payType.value.toUpperCase()}/$productId',
      );
      return OrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('创建订单失败: ${e.message}');
      return null;
    }
  }

  /// 获取服务产品 1: 普通365天 2: VIP 3650天
  Future<Product?> getProduct({int type = 1}) async {
    try {
      final response = await _dio.get('/app/order/product?type=$type');
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
      final response = await _dio.get('/app/order/list');
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

  /// 继续支付订单
  Future<OrderResponse?> payOrder(String orderId, PayType payType) async {
    try {
      final response = await _dio.post(
        '/app/order/payOrder/$orderId/${payType.name.toUpperCase()}',
      );
      return OrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('支付订单失败: ${e.message}');
      return null;
    }
  }
}

import 'package:dio/dio.dart';
import 'http_client.dart';
import '../models/order.dart';
import '../models/package.dart';
import '../models/package_group.dart';

/// 支付类型
enum PayType {
  /// 支付宝
  alipay,

  /// 微信支付
  wechat,
}

/// 服务包服务
class PackageService {
  static final PackageService _instance = PackageService._internal();
  final Dio _dio = HttpClient().dio;

  factory PackageService() {
    return _instance;
  }

  PackageService._internal();

  /// 创建单项服务订单
  Future<OrderResponse?> createPackageOrder(
      int packageId, PayType payType) async {
    try {
      final response = await _dio.post(
        '/app/order/packageOrder',
        data: {
          'id': packageId,
          'payType': payType.name.toUpperCase(),
        },
      );
      return OrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('创建单项服务订单失败: ${e.message}');
      return null;
    }
  }

  /// 创建服务包订单
  Future<OrderResponse?> createPackageGroupOrder(
      int groupId, PayType payType) async {
    try {
      final response = await _dio.post(
        '/app/order/packageGroupOrder',
        data: {
          'id': groupId,
          'payType': payType.name.toUpperCase(),
        },
      );
      return OrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('创建服务包订单失败: ${e.message}');
      return null;
    }
  }

  /// 获取单项服务列表
  Future<List<Package>> getPackages() async {
    try {
      final response = await _dio.get('/app/package/list');
      final packageResponse = PackageResponse.fromJson(response.data);
      return packageResponse.data ?? [];
    } on DioException catch (e) {
      print('获取单项服务列表失败: ${e.message}');
      return [];
    } catch (e) {
      print('解析单项服务列表失败: $e');
      return [];
    }
  }

  /// 获取单项服务详情
  Future<Package?> getPackageDetail(int id) async {
    try {
      final response = await _dio.get('/app/package/$id');
      final packageDetailResponse =
          PackageDetailResponse.fromJson(response.data);
      return packageDetailResponse.data;
    } on DioException catch (e) {
      print('获取单项服务详情失败: ${e.message}');
      return null;
    } catch (e) {
      print('解析单项服务详情失败: $e');
      return null;
    }
  }

  /// 获取服务包列表
  Future<List<PackageGroup>> getPackageGroups() async {
    try {
      final response = await _dio.get('/app/package/group');
      final packageGroupResponse = PackageGroupResponse.fromJson(response.data);
      return packageGroupResponse.data ?? [];
    } on DioException catch (e) {
      print('获取服务包列表失败: ${e.message}');
      return [];
    } catch (e) {
      print('解析服务包列表失败: $e');
      return [];
    }
  }

  /// 获取服务包详情
  Future<PackageGroup?> getPackageGroupDetail(int id) async {
    try {
      final response = await _dio.get('/app/package/group/$id');
      final packageGroupDetailResponse =
          PackageGroupDetailResponse.fromJson(response.data);
      return packageGroupDetailResponse.data;
    } on DioException catch (e) {
      print('获取服务包详情失败: ${e.message}');
      return null;
    } catch (e) {
      print('解析服务包详情失败: $e');
      return null;
    }
  }
}

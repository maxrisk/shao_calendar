import 'package:dio/dio.dart';
import '../models/commission_record.dart';
import 'http_client.dart';

/// 佣金服务
class CommissionService {
  static final CommissionService _instance = CommissionService._internal();
  final Dio _dio = HttpClient().dio;

  factory CommissionService() {
    return _instance;
  }

  CommissionService._internal();

  /// 获取佣金明细列表
  Future<List<CommissionRecord>> getCommissionRecords({int? level}) async {
    try {
      final response = await _dio.get(
        '/app/amount/record',
        queryParameters: level != null ? {'level': level} : null,
      );

      if (response.data['code'] == 0) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => CommissionRecord.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('获取佣金明细失败: ${e.message}');
      return [];
    }
  }
}

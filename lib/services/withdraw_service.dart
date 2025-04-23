import 'package:dio/dio.dart';
import '../models/withdraw_record.dart';
import 'http_client.dart';

/// 提现结果
class WithdrawResult {
  /// 创建提现结果
  WithdrawResult({
    required this.success,
    required this.message,
  });

  /// 是否成功
  final bool success;

  /// 提示消息
  final String message;
}

class WithdrawService {
  static final WithdrawService _instance = WithdrawService._internal();
  factory WithdrawService() => _instance;
  WithdrawService._internal();

  final _dio = HttpClient().dio;

  /// 余额提现
  Future<WithdrawResult> withdraw(double amount, String password) async {
    try {
      final response = await _dio.post('/app/withdraw', data: {
        'money': amount.toStringAsFixed(2),
        'password': password,
      });
      return WithdrawResult(
        success: response.data['code'] == 0,
        message: response.data['msg'] ?? '提现申请已提交',
      );
    } catch (e) {
      print('提现失败: $e');
      return WithdrawResult(
        success: false,
        message: '网络异常，请稍后重试',
      );
    }
  }

  /// 获取提现记录
  Future<List<WithdrawRecord>> getWithdrawRecords() async {
    try {
      final response = await _dio.get('/app/withdraw/record');
      final apiResponse = WithdrawRecordListResponse.fromJson(response.data);

      if (apiResponse.code == 0 && apiResponse.data != null) {
        return apiResponse.data!;
      }
      return [];
    } catch (e) {
      print('获取提现记录失败: $e');
      return [];
    }
  }
}

import 'package:dio/dio.dart';
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
  Future<WithdrawResult> withdraw(double amount) async {
    try {
      final response = await _dio.post(
        '/app/withdraw/${amount.toStringAsFixed(2)}',
      );
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
  Future<List<Map<String, dynamic>>> getWithdrawRecords() async {
    try {
      final response = await _dio.get('/app/withdraw/record');
      if (response.data['code'] == 0 && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'];
        return data.map((e) => e as Map<String, dynamic>).toList();
      }
      return [];
    } catch (e) {
      print('获取提现记录失败: $e');
      return [];
    }
  }
}

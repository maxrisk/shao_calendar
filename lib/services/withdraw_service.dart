import 'package:dio/dio.dart';
import '../models/withdraw_record.dart';
import 'http_client.dart';

/// 提现结果
class WithdrawResult {
  /// 创建提现结果
  WithdrawResult({
    required this.success,
    required this.message,
    this.code = 0,
  });

  /// 是否成功
  final bool success;

  /// 提示消息
  final String message;

  /// 响应代码
  final int code;
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

      final code = response.data['code'] ?? -1;
      final success = code == 0;
      final message = response.data['msg'] ?? (success ? '提现申请已提交' : '提现失败');

      return WithdrawResult(
        success: success,
        message: message,
        code: code,
      );
    } on DioException catch (e) {
      print('提现请求失败: ${e.message}');
      // 处理Dio异常，提供更具体的错误信息
      String errorMessage = '网络异常，请稍后重试';

      if (e.response != null) {
        // 如果服务器返回了错误响应
        final responseData = e.response?.data;
        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('msg')) {
          errorMessage = responseData['msg'] ?? errorMessage;
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = '连接超时，请检查网络';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = '接收数据超时，请稍后再试';
      }

      return WithdrawResult(
        success: false,
        message: errorMessage,
        code: e.response?.statusCode ?? -1,
      );
    } catch (e) {
      print('提现失败: $e');
      return WithdrawResult(
        success: false,
        message: '系统异常，请稍后重试',
        code: -1,
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

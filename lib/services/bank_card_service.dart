import 'package:dio/dio.dart';
import '../models/bank_card.dart';
import 'http_client.dart';

class BankCardService {
  static final BankCardService _instance = BankCardService._internal();
  final Dio _dio = HttpClient().dio;

  factory BankCardService() {
    return _instance;
  }

  BankCardService._internal();

  /// 获取银行卡信息
  Future<BankCard?> getBankCard() async {
    try {
      final response = await _dio.get('/app/bankCard');
      final bankCardResponse = BankCardResponse.fromJson(response.data);
      return bankCardResponse.data;
    } on DioException catch (e) {
      print('获取银行卡信息失败: ${e.message}');
      return null;
    } catch (e) {
      print('解析银行卡信息失败: $e');
      return null;
    }
  }

  /// 添加银行卡
  Future<bool> addBankCard({
    required String name,
    required String cardNo,
    required String bankName,
    String? subBranchBankName,
    required String idCard,
  }) async {
    try {
      final response = await _dio.put(
        '/app/bankCard',
        data: {
          'name': name,
          'cardNo': cardNo,
          'bankName': bankName,
          'subBranchBankName': subBranchBankName,
          'idCard': idCard,
        },
      );
      return response.data['code'] == 0;
    } on DioException catch (e) {
      print('添加银行卡失败: ${e.message}');
      return false;
    } catch (e) {
      print('添加银行卡失败: $e');
      return false;
    }
  }
}

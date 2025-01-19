import 'package:dio/dio.dart';
import '../models/fortune.dart';
import 'http_client.dart';

class FortuneService {
  static final FortuneService _instance = FortuneService._internal();
  final Dio _dio = HttpClient().dio;

  factory FortuneService() {
    return _instance;
  }

  FortuneService._internal();

  /// 获取先天历信息
  Future<FortuneResponse?> getFortune(String date) async {
    try {
      final response = await _dio.get('/app/fortune/$date');
      return FortuneResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('获取先天历信息失败: ${e.message}');
      return null;
    }
  }

  /// 获取个人运势
  Future<FortuneResponse?> getUserFortune(String date) async {
    try {
      final response = await _dio.get('/app/user/fortune/$date');
      return FortuneResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('获取个人运势失败: ${e.message}');
      return null;
    }
  }
}

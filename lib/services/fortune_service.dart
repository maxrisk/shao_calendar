import 'package:dio/dio.dart';
import '../models/fortune.dart';
import 'http_client.dart';

class FortuneService {
  static final FortuneService _instance = FortuneService._internal();
  final Dio _dio = HttpClient().dio;
  FortuneResponse? _fortuneData;
  FortuneResponse? _userFortuneData;

  FortuneResponse? get fortuneData => _fortuneData;
  FortuneResponse? get userFortuneData => _userFortuneData;

  factory FortuneService() {
    return _instance;
  }

  FortuneService._internal();

  /// 获取先天历信息
  Future<FortuneResponse?> getFortune(String date) async {
    try {
      print('获取先天历信息: $date');
      final response = await _dio.get('/app/fortune/$date');
      print('先天历响应数据: ${response.data}');
      _fortuneData = FortuneResponse.fromJson(response.data);
      return _fortuneData;
    } on DioException catch (e) {
      print('获取先天历信息失败: ${e.message}');
      return null;
    } catch (e, stackTrace) {
      print('解析先天历数据失败: $e');
      print('堆栈跟踪: $stackTrace');
      return null;
    }
  }

  /// 获取个人运势
  Future<FortuneResponse?> getUserFortune(String date) async {
    try {
      final response = await _dio.get('/app/user/fortune/$date');
      _userFortuneData = FortuneResponse.fromJson(response.data);
      return _userFortuneData;
    } on DioException catch (e) {
      print('获取个人运势失败: ${e.message}');
      return null;
    } catch (e, stackTrace) {
      print('解析个人运势数据失败: $e');
      print('堆栈跟踪: $stackTrace');
      return null;
    }
  }

  /// 重新加载所有数据
  Future<void> reloadAllData() async {
    final today = DateTime.now();
    final dateStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    await Future.wait([
      getFortune(dateStr),
      getUserFortune(dateStr),
    ]);
  }

  /// 清理运势数据
  void clearFortuneData() {
    _fortuneData = null;
    _userFortuneData = null;
  }
}

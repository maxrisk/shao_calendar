import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  late final Dio dio;
  late final SharedPreferences _prefs;

  factory HttpClient() {
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    dio = Dio(BaseOptions(
      baseUrl: 'https://shao-calendar-test.txcb.com', // TODO: 替换为实际的API地址
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 从本地存储获取token
        final token = _prefs.getString('token') ?? '';
        print('token: $token');
        if (token.isNotEmpty) {
          options.headers['Authorization'] = token;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('response: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('error: ${e.response?.data}');
        // 统一错误处理
        if (e.response?.statusCode == 401) {
          // Token过期或无效，清除token
          _prefs.remove('token');
        }
        return handler.next(e);
      },
    ));
  }

  HttpClient._internal();
}

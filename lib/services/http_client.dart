import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  late final Dio dio;
  late final SharedPreferences _prefs;
  // 用于存储全局 context
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory HttpClient() {
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: AppConfig.config['apiTimeout'] as Duration,
      receiveTimeout: AppConfig.config['apiTimeout'] as Duration,
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 从本地存储获取token
        final token = _prefs.getString('token') ?? '';
        if (token.isNotEmpty) {
          options.headers['Authorization'] = token;
        }
        if (!AppConfig.isProduction) {
          print(
              '${options.method}:${options.path} \n request: ${options.data}, header: ${options.headers}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (!AppConfig.isProduction) {
          print('response headers: ${response.headers}');
          print(
              '${response.requestOptions.method}:${response.requestOptions.path} \n response: ${response.data}');
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (!AppConfig.isProduction) {
          print(
              '${e.response?.requestOptions.method}:${e.response?.requestOptions.path} error: ${e.response?.data}');
        }
        // 统一错误处理
        if (e.response?.statusCode == 401) {
          // Token过期或无效，清除token
          _prefs.remove('token');

          // 获取全局context显示提示
          final context = navigatorKey.currentContext;
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('登录已过期，请重新登录'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
        return handler.next(e);
      },
    ));
  }

  HttpClient._internal();
}

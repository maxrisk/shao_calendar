import 'package:dio/dio.dart';
import 'http_client.dart';
import '../models/base_year.dart';
import '../models/ten_year.dart';
import '../models/year_event.dart';

/// 卦象服务
class HexagramService {
  static final HexagramService _instance = HexagramService._internal();
  factory HexagramService() => _instance;

  final Dio _dio = HttpClient().dio;
  BaseYearResponse? _baseYearData;
  TenYearResponse? _tenYearData;
  YearEventResponse? _yearEventData;
  YearDivinationResponse? _yearDivinationData;

  BaseYearResponse? get baseYearData => _baseYearData;
  TenYearResponse? get tenYearData => _tenYearData;
  YearEventResponse? get yearEventData => _yearEventData;
  YearDivinationResponse? get yearDivinationData => _yearDivinationData;

  HexagramService._internal();

  /// 获取60年卦象
  Future<BaseYearResponse?> getBaseYear() async {
    try {
      print('获取60年卦象');
      final response = await _dio.get('/app/baseYear');
      print('60年卦象原始响应数据:');
      print(response.data);

      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // 检查数据结构
        if (data['data'] != null && data['data'] is List) {
          final list = data['data'] as List;
          if (list.isNotEmpty) {
            print('\n第一条数据的字段和类型:');
            final firstItem = list.first as Map<String, dynamic>;
            firstItem.forEach((key, value) {
              print('$key: ${value?.runtimeType} = $value');
            });
          }
        }

        _baseYearData = BaseYearResponse.fromJson(response.data);
        return _baseYearData;
      }

      return null;
    } on DioException catch (e) {
      print('获取60年卦象异常: ${e.message}');
      return null;
    } catch (e, stackTrace) {
      print('解析60年卦象数据失败: $e');
      print('堆栈跟踪: $stackTrace');
      return null;
    }
  }

  /// 获取年卦事件
  Future<List<YearEvent>> getYearEvents(int year) async {
    try {
      print('获取年卦事件: year=$year');
      final response = await _dio.get('/app/yearNews/$year');
      print('年卦事件原始响应数据:');
      print(response.data);

      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];
        if (data != null) {
          if (data is List) {
            // 直接处理数组数据
            return data
                .map((e) => YearEvent.fromJson(e as Map<String, dynamic>))
                .toList();
          }
        }
      }

      return [];
    } catch (e, stackTrace) {
      print('获取年卦事件失败: $e');
      print('堆栈跟踪: $stackTrace');
      return [];
    }
  }

  /// 获取年卦解说
  Future<List<YearDivination>> getYearDivinations(int tenYearId) async {
    try {
      final response = await _dio.get('/app/year/$tenYearId');
      // 检查响应数据是否为数组格式
      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];
        if (data != null && data is List) {
          // 如果data是数组，则处理数组数据
          return data
              .map((item) =>
                  YearDivination.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } catch (e) {
      print('获取年卦解说失败: $e');
      return [];
    }
  }

  /// 获取十年卦
  Future<TenYearResponse?> getTenYear(int baseYearId) async {
    try {
      print('获取十年卦: baseYearId=$baseYearId');
      final response = await _dio.get('/app/tenYear/$baseYearId');
      print('十年卦响应数据: ${response.data}');
      _tenYearData = TenYearResponse.fromJson(response.data);
      return _tenYearData;
    } catch (e, stackTrace) {
      print('获取十年卦失败: $e');
      print('堆栈跟踪: $stackTrace');
      return null;
    }
  }

  /// 清理卦象数据
  void clearHexagramData() {
    _baseYearData = null;
    _tenYearData = null;
    _yearEventData = null;
    _yearDivinationData = null;
  }
}

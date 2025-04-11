import 'http_client.dart';

class AreaService {
  static final AreaService _instance = AreaService._internal();
  factory AreaService() => _instance;
  AreaService._internal();

  final _dio = HttpClient().dio;

  // 缓存数据
  final Map<String, List<Map<String, dynamic>>> _provinceCache = {};
  final Map<int, List<Map<String, dynamic>>> _cityCache = {};
  final Map<String, List<Map<String, dynamic>>> _districtCache = {};

  /// 获取省份列表
  Future<List<Map<String, dynamic>>> getProvinces() async {
    // 检查缓存
    if (_provinceCache.containsKey('provinces')) {
      return _provinceCache['provinces']!;
    }

    try {
      final response = await _dio.get('/app/area/province');
      final List<dynamic> data = response.data['data'] ?? [];
      final provinces = data.map((e) => e as Map<String, dynamic>).toList();

      // 保存到缓存
      _provinceCache['provinces'] = provinces;
      return provinces;
    } catch (e) {
      print('获取省份列表失败: $e');
      return [];
    }
  }

  /// 获取城市列表
  Future<List<Map<String, dynamic>>> getCities(int provinceId) async {
    // 检查缓存
    if (_cityCache.containsKey(provinceId)) {
      return _cityCache[provinceId]!;
    }

    try {
      final response = await _dio.get('/app/area/city/$provinceId');
      final List<dynamic> data = response.data['data'] ?? [];
      final cities = data.map((e) => e as Map<String, dynamic>).toList();

      // 保存到缓存
      _cityCache[provinceId] = cities;
      return cities;
    } catch (e) {
      print('获取城市列表失败: $e');
      return [];
    }
  }

  /// 获取区县列表
  Future<List<Map<String, dynamic>>> getDistricts(
      int provinceId, int cityId) async {
    // 生成缓存key
    final String cacheKey = '$provinceId-$cityId';

    // 检查缓存
    if (_districtCache.containsKey(cacheKey)) {
      return _districtCache[cacheKey]!;
    }

    try {
      final response = await _dio.get('/app/area/district/$provinceId/$cityId');
      final List<dynamic> data = response.data['data'] ?? [];
      final districts = data.map((e) => e as Map<String, dynamic>).toList();

      // 保存到缓存
      _districtCache[cacheKey] = districts;
      return districts;
    } catch (e) {
      print('获取区县列表失败: $e');
      return [];
    }
  }

  // 清除缓存方法
  void clearCache() {
    _provinceCache.clear();
    _cityCache.clear();
    _districtCache.clear();
  }

  // 清除特定省份的城市和区域缓存
  void clearProvinceCityCache(int provinceId) {
    _cityCache.remove(provinceId);
    _districtCache.removeWhere((key, _) => key.startsWith('$provinceId-'));
  }

  // 清除特定城市的区域缓存
  void clearCityDistrictCache(int provinceId, int cityId) {
    _districtCache.remove('$provinceId-$cityId');
  }
}

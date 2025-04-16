/// 60年卦象响应
class BaseYearResponse {
  /// 响应码
  final int code;

  /// 响应消息
  final String? message;

  /// 响应数据
  final List<BaseYear>? data;

  /// 构造函数
  BaseYearResponse({
    required this.code,
    this.message,
    this.data,
  });

  /// 从JSON创建实例
  factory BaseYearResponse.fromJson(Map<String, dynamic> json) {
    return BaseYearResponse(
      code: json['code'] as int,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => BaseYear.fromJson(e)).toList()
          : null,
    );
  }
}

/// 60年卦象数据
class BaseYear {
  /// ID
  final int id;

  /// 卦象名称
  final String name;

  /// 卦象描述
  final String description;

  /// 开始年份
  final int startYear;

  /// 结束年份
  final int endYear;

  /// 卦象图片
  final String? image;

  /// 构造函数
  BaseYear({
    required this.id,
    required this.name,
    required this.description,
    required this.startYear,
    required this.endYear,
    this.image,
  });

  /// 从JSON创建实例
  factory BaseYear.fromJson(Map<String, dynamic> json) {
    return BaseYear(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      startYear: json['startYear'] as int,
      endYear: json['endYear'] as int,
      image: json['image'] as String?,
    );
  }
}

/// 10年卦象响应
class TenYearResponse {
  /// 响应码
  final int code;

  /// 响应消息
  final String? message;

  /// 响应数据
  final List<TenYear>? data;

  /// 构造函数
  TenYearResponse({
    required this.code,
    this.message,
    this.data,
  });

  /// 从JSON创建实例
  factory TenYearResponse.fromJson(Map<String, dynamic> json) {
    return TenYearResponse(
      code: json['code'] as int,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => TenYear.fromJson(e)).toList()
          : null,
    );
  }
}

/// 10年卦象数据
class TenYear {
  /// ID
  final int id;

  /// 卦象名称
  final String name;

  /// 卦象描述
  final String description;

  /// 开始年份
  final int startYear;

  /// 结束年份
  final int endYear;

  /// 卦象图片
  final String? image;

  /// 所属60年卦象ID
  final int baseYearId;

  /// 构造函数
  TenYear({
    required this.id,
    required this.name,
    required this.description,
    required this.startYear,
    required this.endYear,
    required this.baseYearId,
    this.image,
  });

  /// 从JSON创建实例
  factory TenYear.fromJson(Map<String, dynamic> json) {
    return TenYear(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      startYear: json['startYear'] as int,
      endYear: json['endYear'] as int,
      baseYearId: json['baseYearId'] as int,
      image: json['image'] as String?,
    );
  }
}

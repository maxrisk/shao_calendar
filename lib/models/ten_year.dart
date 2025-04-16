import 'package:json_annotation/json_annotation.dart';

part 'ten_year.g.dart';

/// 十年卦响应
@JsonSerializable()
class TenYearResponse {
  /// 状态码
  final int code;

  /// 消息
  final String? message;

  /// 数据
  final List<TenYear>? data;

  /// 构造函数
  TenYearResponse({
    required this.code,
    this.message,
    this.data,
  });

  factory TenYearResponse.fromJson(Map<String, dynamic> json) =>
      _$TenYearResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TenYearResponseToJson(this);
}

/// 十年卦数据
@JsonSerializable()
class TenYear {
  /// ID
  @JsonKey(fromJson: _parseInt)
  final int id;

  /// 卦象名称
  final String? name;

  /// 卦象描述
  final String? description;

  /// 开始年份
  @JsonKey(fromJson: _parseInt)
  final int startYear;

  /// 结束年份
  @JsonKey(fromJson: _parseInt)
  final int endYear;

  /// 卦象图片
  final String? image;

  /// 所属60年卦象ID
  @JsonKey(fromJson: _parseInt)
  final int baseYearId;

  /// 卦象占卜名称
  final String? divinationName;

  /// 卦象指引
  final String? guide;

  /// 构造函数
  TenYear({
    required this.id,
    this.name,
    this.description,
    required this.startYear,
    required this.endYear,
    required this.baseYearId,
    this.image,
    this.divinationName,
    this.guide,
  });

  factory TenYear.fromJson(Map<String, dynamic> json) =>
      _$TenYearFromJson(json);

  Map<String, dynamic> toJson() => _$TenYearToJson(this);

  /// 解析可能为字符串的整数
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}

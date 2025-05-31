import 'package:json_annotation/json_annotation.dart';

part 'base_year.g.dart';

/// 60年卦象响应
@JsonSerializable()
class BaseYearResponse {
  /// 响应码
  @JsonKey(defaultValue: 0)
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

  factory BaseYearResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseYearResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseYearResponseToJson(this);
}

/// 60年卦象数据
@JsonSerializable()
class BaseYear {
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

  /// 卦象占卜名称
  final String? divinationName;

  /// 卦象指引
  final String? guide;

  /// 卦象符号
  final String? divinationSymbol;

  /// 卦象排序
  @JsonKey(fromJson: _parseInt)
  final int divinationSort;

  /// 第一个十年开始
  @JsonKey(fromJson: _parseInt)
  final int firstDecadeStart;

  /// 第一个十年结束
  @JsonKey(fromJson: _parseInt)
  final int firstDecadeEnd;

  /// 第二个十年开始
  @JsonKey(fromJson: _parseInt)
  final int secondDecadeStart;

  /// 第二个十年结束
  @JsonKey(fromJson: _parseInt)
  final int secondDecadeEnd;

  /// 第三个十年开始
  @JsonKey(fromJson: _parseInt)
  final int thirdDecadeStart;

  /// 第三个十年结束
  @JsonKey(fromJson: _parseInt)
  final int thirdDecadeEnd;

  /// 第四个十年开始
  @JsonKey(fromJson: _parseInt)
  final int fourthDecadeStart;

  /// 第四个十年结束
  @JsonKey(fromJson: _parseInt)
  final int fourthDecadeEnd;

  /// 第五个十年开始
  @JsonKey(fromJson: _parseInt)
  final int fifthDecadeStart;

  /// 第五个十年结束
  @JsonKey(fromJson: _parseInt)
  final int fifthDecadeEnd;

  /// 第六个十年开始
  @JsonKey(fromJson: _parseInt)
  final int sixthDecadeStart;

  /// 第六个十年结束
  @JsonKey(fromJson: _parseInt)
  final int sixthDecadeEnd;

  /// 构造函数
  BaseYear({
    required this.id,
    this.name,
    this.description,
    required this.startYear,
    required this.endYear,
    this.image,
    this.divinationName,
    this.guide,
    this.divinationSymbol,
    required this.divinationSort,
    required this.firstDecadeStart,
    required this.firstDecadeEnd,
    required this.secondDecadeStart,
    required this.secondDecadeEnd,
    required this.thirdDecadeStart,
    required this.thirdDecadeEnd,
    required this.fourthDecadeStart,
    required this.fourthDecadeEnd,
    required this.fifthDecadeStart,
    required this.fifthDecadeEnd,
    required this.sixthDecadeStart,
    required this.sixthDecadeEnd,
  });

  factory BaseYear.fromJson(Map<String, dynamic> json) =>
      _$BaseYearFromJson(json);

  Map<String, dynamic> toJson() => _$BaseYearToJson(this);

  /// 解析可能为字符串的整数
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}

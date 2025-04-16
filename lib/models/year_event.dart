import 'package:json_annotation/json_annotation.dart';

part 'year_event.g.dart';

/// 年卦事件响应
@JsonSerializable()
class YearEventResponse {
  /// 状态码
  final int code;

  /// 消息
  final String? msg;

  /// 数据
  final List<YearEvent>? data;

  /// 构造函数
  YearEventResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory YearEventResponse.fromJson(Map<String, dynamic> json) =>
      _$YearEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YearEventResponseToJson(this);
}

/// 年卦事件
@JsonSerializable()
class YearEvent {
  /// ID
  final int id;

  /// 创建时间
  final String createTime;

  /// 年份
  final int year;

  /// 标题
  final String title;

  /// 内容
  final String content;

  /// 时间
  final String time;

  /// 构造函数
  YearEvent({
    required this.id,
    required this.createTime,
    required this.year,
    required this.title,
    required this.content,
    required this.time,
  });

  factory YearEvent.fromJson(Map<String, dynamic> json) =>
      _$YearEventFromJson(json);

  Map<String, dynamic> toJson() => _$YearEventToJson(this);
}

/// 年卦解说响应
@JsonSerializable()
class YearDivinationResponse {
  /// 状态码
  final int code;

  /// 消息
  final String? msg;

  /// 数据
  final YearDivination? data;

  /// 构造函数
  YearDivinationResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory YearDivinationResponse.fromJson(Map<String, dynamic> json) =>
      _$YearDivinationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YearDivinationResponseToJson(this);
}

/// 年卦解说
@JsonSerializable()
class YearDivination {
  /// ID
  final int id;

  /// 年份
  final int year;

  /// 上年冬至
  final String lastWinterSolstice;

  /// 冬至
  final String winterSolstice;

  /// 雨水
  final String rainWater;

  /// 谷雨
  final String grainRain;

  /// 夏至
  final String summerSolstice;

  /// 处暑
  final String endOfHeat;

  /// 霜降
  final String frostDescent;

  /// 名称
  final String name;

  /// 符号
  final String symbol;

  /// 指引
  final String? guide;

  /// 构造函数
  YearDivination({
    required this.id,
    required this.year,
    required this.lastWinterSolstice,
    required this.winterSolstice,
    required this.rainWater,
    required this.grainRain,
    required this.summerSolstice,
    required this.endOfHeat,
    required this.frostDescent,
    required this.name,
    required this.symbol,
    this.guide,
  });

  factory YearDivination.fromJson(Map<String, dynamic> json) =>
      _$YearDivinationFromJson(json);

  Map<String, dynamic> toJson() => _$YearDivinationToJson(this);
}

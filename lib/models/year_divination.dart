import 'package:json_annotation/json_annotation.dart';

part 'year_divination.g.dart';

@JsonSerializable()
class YearDivinationResponse {
  final int code;
  final String msg;
  final List<YearDivination> data;

  YearDivinationResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory YearDivinationResponse.fromJson(Map<String, dynamic> json) =>
      _$YearDivinationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YearDivinationResponseToJson(this);
}

@JsonSerializable()
class YearDivination {
  final int id;
  final int year;
  final String lastWinterSolstice;
  final String winterSolstice;
  final String rainWater;
  final String grainRain;
  final String summerSolstice;
  final String endOfHeat;
  final String frostDescent;
  final String name;
  final String symbol;
  final String guide;

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
    required this.guide,
  });

  factory YearDivination.fromJson(Map<String, dynamic> json) =>
      _$YearDivinationFromJson(json);

  Map<String, dynamic> toJson() => _$YearDivinationToJson(this);
}

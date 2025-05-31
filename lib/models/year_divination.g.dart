// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_divination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearDivinationResponse _$YearDivinationResponseFromJson(
        Map<String, dynamic> json) =>
    YearDivinationResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => YearDivination.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YearDivinationResponseToJson(
        YearDivinationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

YearDivination _$YearDivinationFromJson(Map<String, dynamic> json) =>
    YearDivination(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      lastWinterSolstice: json['lastWinterSolstice'] as String,
      winterSolstice: json['winterSolstice'] as String,
      rainWater: json['rainWater'] as String,
      grainRain: json['grainRain'] as String,
      summerSolstice: json['summerSolstice'] as String,
      endOfHeat: json['endOfHeat'] as String,
      frostDescent: json['frostDescent'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      guide: json['guide'] as String,
    );

Map<String, dynamic> _$YearDivinationToJson(YearDivination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'lastWinterSolstice': instance.lastWinterSolstice,
      'winterSolstice': instance.winterSolstice,
      'rainWater': instance.rainWater,
      'grainRain': instance.grainRain,
      'summerSolstice': instance.summerSolstice,
      'endOfHeat': instance.endOfHeat,
      'frostDescent': instance.frostDescent,
      'name': instance.name,
      'symbol': instance.symbol,
      'guide': instance.guide,
    };

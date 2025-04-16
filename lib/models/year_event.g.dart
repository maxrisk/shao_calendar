// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearEventResponse _$YearEventResponseFromJson(Map<String, dynamic> json) =>
    YearEventResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => YearEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YearEventResponseToJson(YearEventResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

YearEvent _$YearEventFromJson(Map<String, dynamic> json) => YearEvent(
      id: (json['id'] as num).toInt(),
      createTime: json['createTime'] as String,
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$YearEventToJson(YearEvent instance) => <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'year': instance.year,
      'title': instance.title,
      'content': instance.content,
      'time': instance.time,
    };

YearDivinationResponse _$YearDivinationResponseFromJson(
        Map<String, dynamic> json) =>
    YearDivinationResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : YearDivination.fromJson(json['data'] as Map<String, dynamic>),
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
      guide: json['guide'] as String?,
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
